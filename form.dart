import 'package:flutter/material.dart';


class ValidationExample extends StatefulWidget {
  const ValidationExample({Key? key}) : super(key: key);

  @override
  _ValidationExampleState createState() => _ValidationExampleState();
}

class _ValidationExampleState extends State<ValidationExample> {

  TextEditingController passwordEditingController = TextEditingController();

  //フォームのキーを作成する
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  //フォームに条件を指定する
                  validator: (val) {
                    return val!.length < 6
                        ? "パスワードは6文字以上必要です"
                        : null;
                  },
                  obscureText: true,
                  controller: passwordEditingController,
                  decoration: const InputDecoration(labelText: 'パスワード', border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: (){
              setState(() {
                if(_formKey.currentState!.validate()){
                  //正しい形式で入力された場合のみif文の中の処理を実行
                }
              });
            },
            child: const Text('決定'),
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

