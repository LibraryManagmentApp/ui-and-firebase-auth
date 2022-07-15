import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two2/core/view_model/provider/cart.dart';
import 'package:two2/core/view_model/provider/homeprovider.dart';
import 'package:two2/utils/constant.dart';

class BookSelector extends StatelessWidget {
  final Listenable myanimation;
  final int index;
  BookSelector({required this.index,required this.myanimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:myanimation,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 500.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Container(
              child: Hero(
                  tag: Provider.of<HomeProvider>(context,listen: false).book[index].imageUrl,//book[index].imageUrl,
                  child: Container(
                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(16),),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 25),
                    child: Image(
                      image: AssetImage('assets/images/ph$index.jpg'),
                      width: 300,
                      height: 450,
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 30,
              child: RawMaterialButton(
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(),
                  elevation:3,
                  //fillColor: Colors.black,
                  fillColor:firstColor,
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    // cart().addItem('1',10,'nihoi');
                    // print('add to cart');
                    
                  })
          ),
          Positioned(
              bottom: 0,
              right: 30,
              child: RawMaterialButton(
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(),
                  elevation: 3,
                  //fillColor: Colors.black,
                  fillColor: Color.fromRGBO(153, 77, 0, 1),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    //print('add to favo');
                  })),
        ],
      ),
    );
  }
}