import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/screen/authorization/authorization_screen.dart';
import 'package:flutter_application_mini_project/screen/pick_favorite/pick_favorite.dart';
import 'package:flutter_application_mini_project/screen/splash_screen/splash_provider.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';
import 'package:flutter_application_mini_project/utils/my_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Timer? timer;

  @override
  void initState() {

    super.initState();
    timer = Timer(const Duration(milliseconds: 1500), () async{

      final prefs = await SharedPreferences.getInstance();

      Widget? pageScreen;
      String? refreshToken = prefs.getString(MyToken.refreshTokenKey);

      if(refreshToken == null){
        pageScreen = const AuthorizationScreen();
      }
      else{
        SplashProvider splashViewModel = SplashProvider();

        bool validAccess = await splashViewModel.gainRefreshToken(refreshToken: refreshToken);
        if(validAccess){

          // pageScreen = const MyHomeScreen();
          pageScreen = const PickFavorite(backButton: false,);
        }
        else{
          pageScreen = const AuthorizationScreen();
        }
      }

      if (mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => pageScreen!,));
      }
    },);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    double minSize = min(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width) /2;

    return Scaffold(
      backgroundColor: MyColor.primaryColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: minSize,
              maxWidth: minSize,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Image(image: AssetImage('assets/MAL logo cropped.png')),
                  Text('TruDav UI' ,style: TextStyle(color: Colors.white, fontSize: 120),)
                ],
              ),
            )
          )
        )
      ),
    );
  }
}