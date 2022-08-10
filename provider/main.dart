import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/new_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // ChangeNotifierProviderのcreateにCounterを渡すと、child以下の全ての部分でCounterにアクセスできるようになります。
    // 複数のChangeNotifierを使いたい場合は、ChangeNotifierProviderの代わりにMultiProviderを使います。
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

// with ChangeNotifierを付けたクラスで、画面更新の必要がある変数の変更を管理します。
class Counter with ChangeNotifier {
  int counter = 0;

  void add() {
    counter += 1;

    // Stateful WidgetのsetStateのようなもの。
    // Consumerで囲んだ部分の画面を更新。　61行目を参照。
    notifyListeners();
  }

  void subtract(){
    counter -= 1;
    notifyListeners();
  }

  void reset(){
    counter = 0;
    notifyListeners();
  }
}

// StatelessWidgetを使っていても画面更新ができます！
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Consumerで囲った部分がnotifyListenersで画面更新される
            Consumer<Counter>(
                builder: (context, counter, child) {// counterはCounterクラスのインスタンスです。　
                  return Text(
                    '${counter.counter}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
            ),


            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const NewPage()));}, child: const Text('入力画面へ'))
          ],
        ),
      ),
    );
  }

}
