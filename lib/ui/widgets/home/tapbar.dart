import 'package:flutter/material.dart';
import 'package:two2/utils/constant.dart';

class CustomTapBar extends StatelessWidget {
  const CustomTapBar({Key? key,this.mytabController}) : super(key: key);

  final TabController? mytabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: mytabController,
        indicatorColor: Colors.transparent,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey.withOpacity(.6),
        labelPadding: EdgeInsets.symmetric(horizontal: 29),
        isScrollable: true,
        tabs: [
          Tab(
              child: Text(
            'Top',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: secondaryColor),
          )),
          Tab(
            child: Text(
              'Categories',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor),
            ),
          ),
          Tab(
            child: Text(
              'favorite',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor),
            ),
          )
        ]);
  }
}
