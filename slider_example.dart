import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

List<Widget> containers = [
  Container(
    color: Colors.red,
  ),
  Container(
    color: Colors.blue,
  ),
  Container(
    color: Colors.green,
  ),
  Container(
    color: Colors.yellow,
  ),
  Container(
    color: Colors.black,
  ),
];

class SliderExample extends StatelessWidget {
  const SliderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2, // 高さの指定をしない場合に使います。ここでは可能な高さの2分の1にしています
              enlargeCenterPage: false, // 表示中のスライドだけを大きくする
              autoPlay: true, // 自動スライドを動かす
              autoPlayAnimationDuration: Duration(seconds: 2), // 自動でスライドを動かす間隔
              viewportFraction: 0.8, // 表示中のスライドが占める幅。1で最大値。
            ),
            items: containers,
          )),
    );
  }
}
