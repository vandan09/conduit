import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_app/Screens/Drawer/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageHelper extends StatelessWidget {
  final List<String> imgList = [
    'assets/images/a.jpg',
    'assets/images/c2.jpg',
    'assets/images/c3.jpg',
    'assets/images/c4.jpg',
    'assets/images/c5.jpg'
  ];

  TabController? _tabController;

  Widget carouselWidget(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          viewportFraction: 1,
          aspectRatio: 16 / 9,
          autoPlay: true,
          autoPlayAnimationDuration: Duration(seconds: 1)),
      items: imgList.map((item) => Image.asset(item, width: 1500)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
