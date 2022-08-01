import 'package:flutter/material.dart';
import 'package:record/record.dart';// 音声を録音するプラグイン
import 'package:audioplayers/audioplayers.dart';//音声を再生するプラグイン
import 'package:path_provider/path_provider.dart';//端末のファイルにアクセスするプラグイン

class Sound extends StatefulWidget {
  const Sound({Key? key}) : super(key: key);

  @override
  State<Sound> createState() => _SoundState();
}

class _SoundState extends State<Sound> {

  Record record = Record(); //Recordクラスのインスタンスを通して録音の処理をする
  AudioPlayer audioPlayer = AudioPlayer(); //AudioPlayerクラスのインスタンスを通して音声の再生の処理をする
  String pathToDirectory = '';//端末のフォルダへのパスを保存する
  bool isRecording = false;
  bool isPlaying = false;

  void getPathToDirectory()async{
    //端末のフォルダへのパスを取得する。path_providerの関数。
    final directory = await getApplicationDocumentsDirectory();
    pathToDirectory = directory.path;
    print(pathToDirectory);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPathToDirectory();
  }

  void startRecording() async {

    setState(() {
      isRecording = true;
    });

    if (await record.hasPermission()) {//録音の許可を要請
      // 録音を開始
      await record.start(
        path: '$pathToDirectory/myAudio.m4a',//保存する場所。pathToDirectoryのフォルダにmyAudio.m4aという音声ファイルが作られる。
        encoder: AudioEncoder.aacLc, // 圧縮方式
        bitRate: 128000, // ビットレート
        samplingRate: 44100, // サンプリング周波数
      );
    }
  }


  void stopRecording() async {

    setState(() {
      isRecording = false;
    });

    // 録音を停止
    await record.stop();
  }

  void startPlaying() async {

    setState(() {
      isPlaying = true;
    });

    //デバイスから音声を取得。録音して保存したものを読み込んでいる。
    //UrlSourceでインターネットのURLから、AssetSourceてアセットから音声を取得できる。
    await audioPlayer.setSource(DeviceFileSource('$pathToDirectory/myAudio.m4a'));

    //取得した音声を再生
    await audioPlayer.resume();
  }

  void stopPlaying() async {
    setState(() {
      isPlaying = false;
    });

    //音声の再生を止める
    await audioPlayer.stop();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              isRecording?ElevatedButton(
                child: const Icon(Icons.stop_circle,), onPressed: (){stopRecording();}
              ): ElevatedButton(
                  onPressed: (){startRecording();}, child: const Icon(Icons.mic)
              ),
              const Spacer(),
              isPlaying?ElevatedButton(
                  child: const Icon(Icons.stop_circle,), onPressed: (){stopPlaying();}
              ): ElevatedButton(
                  onPressed: (){startPlaying();}, child: const Icon(Icons.play_arrow)
              ),
              const Spacer(),
            ],
          )
      ),
    );
  }
}
