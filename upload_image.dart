import 'package:flutter/material.dart';
import 'dart:io'; //ファイルの入出力ができるようにする
import 'package:image_picker/image_picker.dart';//image_pickerをインポート
import 'package:firebase_storage/firebase_storage.dart';//firebase_storageをインポート

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  File? _image;//画像ファイルを保存する変数

  String _imageUrl = '';//アップロードした画像のURLを保存する変数

  //端末の画像を選択する
  Future<void> openImagePicker() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {

      _image = File(pickedImage.path);

      uploadFile();
    }
  }

  //画像のアップロード
  Future<void> uploadFile()async{
    //現在の時刻をミリ秒単位で取得。画像のidとして使用
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    //ストレージ上のパスを設定できる。この場合/images/にidの名前で画像が格納される。
    Reference reference = FirebaseStorage.instance.ref().child('images').child(id);

    //画像のアップロード
    await reference.putFile(_image!);

    //アップロードした画像のURLを取得
    _imageUrl =  await reference.getDownloadURL();

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _imageUrl==''?const Icon(Icons.image):Image.network(_imageUrl),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              openImagePicker();
            },
            child: const Text('画像のアップロード', style: TextStyle(color: Colors.white),),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
            ),
          ),
        ],
      ),
    );
  }
}
