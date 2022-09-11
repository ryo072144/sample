import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  //ProviderScopeでプロジェクト全体を囲みます
  runApp(const ProviderScope(child: MyApp()),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

// 名前と表示・非表示の情報を持つクラス（モデル）。　immutableというのはインスタンスの内容をを変更できないという意味です。
@immutable
class Block{
  const Block({required this.name, required this.isVisible});
  final String name;
  final bool isVisible;

  // 内容を変更できないので、このメソッドでBlockの内容をコピーして新しいBlockインスタンスを作ります。
  Block copyWith({String? name, bool? isVisible}) {
    return Block(
      name: name ?? this.name,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

List<Block> blocks = [
  const Block(name: '今日の天気', isVisible: true),
  const Block(name: '降水量', isVisible: true),
  const Block(name: '風', isVisible: true),
  const Block(name: '生活指標', isVisible: true),
];

// StateNotifierProviderを使うには、StateNotifierを使ったクラスが必要です。
class BlockNotifier extends StateNotifier<List<Block>>{
  BlockNotifier(): super(blocks);// 上で定義したblocksを初期値にしている。

  // stateという変数が更新されると、画面も更新されます。 stateはList<Block>型です。
  // 特定のBlockのisVisibleの値を変えたリストを新たに作ってstateに代入しています。
  // Stringやintなどと違って、Listは要素を変更してもList自体を更新したということにはならないので注意。
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.name == todoId)
          todo.copyWith(isVisible: !todo.isVisible)
        else
          todo,
    ];
  }
}

// StatNotifierの更新を監視できるようにするために必要です。
final blockListProvider = StateNotifierProvider<BlockNotifier, List<Block>>((ref){
  return BlockNotifier();
});

// blockListProviderを監視して、表示させるBlockだけのリストを返します。
final visibleListProvider = Provider<List<Block>>((ref){
  final blockList = ref.watch(blockListProvider);

  return blockList.where((element) => element.isVisible).toList();
});

// blockListProviderを監視して、表示させないBlockだけのリストを返します。
final hiddenListProvider = Provider<List<Block>>((ref){
  final blockList = ref.watch(blockListProvider);

  return blockList.where((element) => !element.isVisible).toList();
});

// stateを反映させるウィジェットはConsumerWidgetを使う。
class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
      ),
      // Consumerのbuilderの中だけがstateによって更新される。
      body: Consumer(
        builder: (context, ref, _) {
          // watchでvisibleListProviderとhiddenListProviderを監視する。
          final visibleBlockList = ref.watch(visibleListProvider);
          final hiddenBlockList = ref.watch(hiddenListProvider);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text('表示'),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: visibleBlockList.length,
                    itemBuilder: (context, index){
                      return Dismissible(
                        key: Key(visibleBlockList[index].name),
                        onDismissed: (DismissDirection direction) {
                          //blockListProviderを介して、BlockNotifierのtoggleメソッドを呼び出し、stateを更新する。
                          ref.read(blockListProvider.notifier).toggle(visibleBlockList[index].name);
                        },
                        background: Container(
                          color: Colors.red,
                        ),
                        child: ListTile(
                          title: Text(visibleBlockList[index].name),
                        )
                      );
                    },
                  ),
                ),
                const Text('非表示'),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: hiddenBlockList.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(hiddenBlockList[index].name),
                        onTap: (){
                          ref.read(blockListProvider.notifier).toggle(hiddenBlockList[index].name);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
