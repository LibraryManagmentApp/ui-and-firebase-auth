import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:two2/core/view_model/provider/homeprovider.dart';
import 'package:two2/ui/views/home_page.dart';
import 'package:two2/ui/views/homescreen.dart';
import 'package:two2/ui/views/order_screen.dart';
import 'package:two2/ui/views/splash_screen2.dart';
import 'package:two2/ui/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'core/view_model/provider/auth.dart';
import 'core/view_model/provider/cart.dart';
import 'core/view_model/provider/order.dart';
import 'ui/views/cart_screen.dart';

late SharedPreferences sharedPre;

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  sharedPre = await SharedPreferences.getInstance();
  runApp(MyApp());}



class MyApp extends StatelessWidget {
  //static const routeName = '/MyApp';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider.value(value: cart()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth,order?>(
          create: (_)=>order(),
          update: (ctx,authvalue,previousorder)=>previousorder!
            ..getdata(
                authvalue.token,
                authvalue.userId,
                // ignore: unnecessary_null_comparison
                previousorder==null?null:previousorder.orders
            ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home:auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx,AsyncSnapshot authSnapShot) =>
            authSnapShot.connectionState == ConnectionState.waiting
                ? mainsplashscreen()
                :mainsplashscreen(),
          ),
          routes: {
            //MyApp.routeName:(_)=>MyApp(),
           // HomePage.routeName:(_) => HomePage(),
            cartScreen.routeName:(_)=>cartScreen(),
            orderscreen.routename:(_)=>orderscreen(),
            appdrawer.routename:(_)=>appdrawer(),
            //HomeScreen.routname:(_)=>HomeScreen(),
          },
        ),
      ),
    );
  }
}