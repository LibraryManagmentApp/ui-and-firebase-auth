//import '../../core/ui/views/order_screen.dart' as orderscreen;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/view_model/provider/auth.dart';
import '../../utils/constant.dart';

class appdrawer extends StatelessWidget {
  static const routename = '/appdrawer';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            AppBar(
              backgroundColor:firstColor,
              title: Text("Iqra Library",
                style: TextStyle(fontSize:30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                  color:Colors.white,
                ),),
              automaticallyImplyLeading: false,
              toolbarHeight:70,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle_rounded,color:secondaryColor,),
              title: Text('My Account',style: TextStyle(color:secondaryColor,fontWeight:FontWeight.bold),),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.wallet_travel_rounded,color:secondaryColor,),
              title: Text('LIBRARY',style: TextStyle(color:secondaryColor,fontWeight:FontWeight.bold),),
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
            ListTile(
              leading: Icon(Icons.work_rounded,color: secondaryColor),
              title: Text('ORDERS',style: TextStyle(color:secondaryColor,fontWeight:FontWeight.bold),),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed('/cartScreen'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.accessibility,color:secondaryColor),
              title: Text('ABOUT US',style: TextStyle(color: secondaryColor,fontWeight:FontWeight.bold),),
              onTap: () {
              },
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app,color:secondaryColor,),
                title: Text('LOUGOUT',style: TextStyle(color: secondaryColor,fontWeight:FontWeight.bold),),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<Auth>(context, listen: false).logOut();
                }),
          ],
        ),
      ),
    );
  }
}