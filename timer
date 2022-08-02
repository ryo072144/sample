import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class SimpleTimer extends StatefulWidget {
  const SimpleTimer({Key? key}) : super(key: key);

  @override
  State<SimpleTimer> createState() => _SimpleTimerState();
}

class _SimpleTimerState extends State<SimpleTimer> {

  late Timer timer; //一定時間ごとに処理を実行するTimerクラスのインスタンス。
  bool isCounting = false;
  DateTime time = DateTime(0); //日時データ型


  startTimer(){
    if(time.hour==0&&time.minute==0&&time.second==0){
      return;
    }
    //一定時間ごとに処理を実行する。
    timer = Timer.periodic(
      //処理を実行する間隔を決める。
      const Duration(seconds: 1),
          (Timer timer) {
        //残り時間が0の時にカウントダウンをストップ
        if(time.hour==0&&time.minute==0&&time.second==0){
          stopTimer();
          return;
        }
        setState(() {
          //カウントダウン
          time = time.add(Duration(seconds: -1));
          isCounting =true;
        });
      },
    );
  }

  stopTimer(){
    // periodicを中止する
    timer.cancel();
    setState(() {
      isCounting = false;
    });
  }

  //カウントする秒数を追加
  addSecond(){
    setState(() {
      time = time.add(Duration(seconds: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //DateFormat.Hms()で日時データを、時：分：秒の形にできる。DateFormatクラスをつかうにはintlというプラグインが必要です。
            Text(DateFormat.Hms().format(time), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 30,),
            isCounting?ElevatedButton(onPressed: stopTimer, child: const Text('ストップ')):ElevatedButton(onPressed: startTimer, child: const Text('スタート')),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: addSecond, child: const Text('秒'))
          ],
        ),
      ),
    );
  }
}
