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
    return Container(
        width: MediaQuery.of(context).size.width,
        child: CarouselSlider(
          options: CarouselOptions(
              autoPlay: true, autoPlayAnimationDuration: Duration(seconds: 1)),
          items: imgList.map((item) => Image.asset(item, width: 1500)).toList(),
        ));
  }

  Widget tabBarWidget() {
    return TabBar(

        // overlayColor: Colors.orange,
        labelColor: constantColors.greenColor,
        unselectedLabelColor: constantColors.greyColor,
        indicatorColor: Colors.green,
        controller: _tabController,
        tabs: const <Widget>[
          Tab(
            child: Text(
              'Your Feed',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Tab(
            child: Text(
              'Global Feed',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
