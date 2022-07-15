import 'package:flutter/material.dart';
import 'package:two2/ui/views/category_page.dart';
import 'package:two2/ui/views/favorite.dart';
import 'package:two2/ui/widgets/top.dart';

class CustomTapBarView extends StatelessWidget {
  const CustomTapBarView({Key? key, this.mytabController}) : super(key: key);

  final TabController? mytabController;

  @override
  Widget build(BuildContext context) {
    return Container(
                width: 200,
                height: double.maxFinite,
                child: TabBarView(
                    controller: mytabController,
                    children: [
                      Top(),
                      CategoryPage(),
                      FavoritePage(),
                    ]),
              );
  }
}