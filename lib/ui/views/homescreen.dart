import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:two2/core/view_model/provider/cart.dart';
import 'package:two2/core/view_model/provider/homeprovider.dart';
import 'package:two2/ui/views/cart_screen.dart';
import 'package:two2/ui/widgets/app_drawer.dart';
import 'package:two2/ui/widgets/badge.dart';
import 'package:two2/ui/widgets/home/tapbar.dart';
import 'package:two2/ui/widgets/home/tapbarview.dart';
import 'package:two2/utils/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: firstColor,
              fontFamily: "Pacifico",
            )),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(appdrawer.routename);
          },
          icon: Icon(
            Icons.menu,
            size: 30,
            color: firstColor,
          ),
        ),
        elevation: 0.0,
        actions: [
          Consumer<cart>(
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
                color: firstColor,
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(cartScreen.routeName),
            ),
            builder: (context, cart, child) =>
                badge(value: cart.itemcount.toString(), child: child),
          ),
        ],
        //backgroundColor: thirdColor,
      ),
      //backgroundColor: thirdColor,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle,
        child: ListView(
            // padding: EdgeInsets.symmetric(
            //   vertical: 50.0,
            // ),
            children: [
              CustomTapBar(mytabController: _tabController,),
              SizedBox(height: 20),
              CustomTapBarView(mytabController: _tabController,),
            ]),
      ),
    );
  }
}