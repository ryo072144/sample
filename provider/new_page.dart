import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/main.dart';

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){

                // context.read<クラス名>()でChangeNotifierを付けたクラスにアクセスします。
                var counter = context.read<Counter>();

                // addメソッドでは、notifyListenersを実行するので、MyHomePageの外からでも画面更新を要求できる。
                counter.add();
              },
              child: const Icon(Icons.plus_one),
            ),
            const SizedBox(width: 10,),
            ElevatedButton(
              onPressed: (){
                var counter = context.read<Counter>();
                counter.reset();
              },
              child: const Text('0'),
            ),
            const SizedBox(width: 10,),
            ElevatedButton(
              onPressed: (){
                var counter = context.read<Counter>();
                counter.subtract();
              },
              child: const Icon(Icons.exposure_minus_1),
            ),
          ],
        ),
      ),
    );
  }
}
