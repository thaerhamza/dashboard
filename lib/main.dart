import 'package:dashboard/pages/account/login.dart';
import 'package:dashboard/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:dashboard/pages/config.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}
//343434
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      routeName: "/",
      navigateAfterSeconds: new Login(),
      title: new Text(
        'مرحبا بكم في تطبيق ادارة المطعم',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
      ),
      /*image: new Image.network(
          'https://flutter.io/images/catalog-widget-placeholder.png'),*/
      backgroundColor: primaryColor,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("restaurant"),
      loaderColor: Colors.white,
    );
  }
}
