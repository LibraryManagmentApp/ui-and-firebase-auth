import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two2/core/view_model/provider/homeprovider.dart';
import 'package:two2/ui/widgets/home/book_selector.dart';
import '../../utils/constant.dart';

class Top extends StatelessWidget {
//   @override
//   State<Top> createState() => _TopState();
// }

// class _TopState extends State<Top>{
  // PageController? pageController;
  // int selectedPage = 0;
  HomeProvider obj = HomeProvider();
//   @override
  // void initState() {
  //   super.initState();
  //   obj.pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  // }

  Widget build(BuildContext context) {
    //PageController? pageController = Provider.of<HomeProvider>(context,listen: false).pageController;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 440,
            width: double.infinity,
            child: PageView.builder(
                controller: Provider.of<HomeProvider>(context, listen: false)
                    .pageController,
                onPageChanged: (index) {
                  Provider.of<HomeProvider>(context, listen: false)
                      .onPageChanged(index);
                },
                itemCount: Provider.of<HomeProvider>(context, listen: false)
                    .book
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return BookSelector(
                    index: index,
                    myanimation: obj.pageController,
                  );
                })),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                //context.watch<HomeProvider>().selectedPageNum,
                Provider.of<HomeProvider>(context)
                    .book[context.watch<HomeProvider>().selectedPage]
                    .description, //book[_selectedPage].description,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              )
            ],
          ),
        ),
      ],
    );
  }

//Widget BookSelector(int index){
  // return AnimatedBuilder(
  //     animation: Provider.of<HomeProvider>(context).pageController!,
  //     builder: (BuildContext context, Widget? widget) {
  //       double value = 1;
  //       return Center(
  //         child: SizedBox(
  //           height: Curves.easeInOut.transform(value) * 500.0,
  //           width: Curves.easeInOut.transform(value) * 400.0,
  //           child: widget,
  //         ),
  //       );
  //     },
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(60),
  //           child: Container(
  //             child: Hero(
  //                 tag: Provider.of<HomeProvider>(context,listen: false).book[index].imageUrl,//book[index].imageUrl,
  //                 child: Container(
  //                   decoration: BoxDecoration(borderRadius:BorderRadius.circular(16),),
  //                   margin: EdgeInsets.fromLTRB(10, 10, 10, 25),
  //                   child: Image(
  //                     image: AssetImage('assets/images/ph$index.jpg'),
  //                     width: 300,
  //                     height: 450,
  //                     fit: BoxFit.fill,
  //                   ),
  //                 )),
  //           ),
  //         ),
  //         Positioned(
  //             bottom: 0,
  //             left: 30,
  //             child: RawMaterialButton(
  //                 padding: EdgeInsets.all(15),
  //                 shape: CircleBorder(),
  //                 elevation:3,
  //                 //fillColor: Colors.black,
  //                 fillColor:firstColor,
  //                 child: Icon(
  //                   Icons.add_shopping_cart,
  //                   color: Colors.white,
  //                   size: 30,
  //                 ),
  //                 onPressed: () {
  //                   // cart().addItem('1',10,'nihoi');
  //                   // print('add to cart');

  //                 })
  //         ),
  //         Positioned(
  //             bottom: 0,
  //             right: 30,
  //             child: RawMaterialButton(
  //                 padding: EdgeInsets.all(15),
  //                 shape: CircleBorder(),
  //                 elevation: 3,
  //                 //fillColor: Colors.black,
  //                 fillColor: Color.fromRGBO(153, 77, 0, 1),
  //                 child: Icon(
  //                   Icons.favorite_border,
  //                   color: Colors.white,
  //                   size: 30,
  //                 ),
  //                 onPressed: () {
  //                   //print('add to favo');
  //                 })),
  //       ],
  //     ),
  //   );
//}
}
