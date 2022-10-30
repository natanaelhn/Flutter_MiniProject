import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold_provider.dart';
import 'package:flutter_application_mini_project/screen/authorization/authorization_provider.dart';
import 'package:flutter_application_mini_project/screen/pick_favorite/pick_favorite.dart';
import 'package:flutter_application_mini_project/screen/pick_favorite/pick_favorite_provider.dart';
import 'package:flutter_application_mini_project/screen/splash_screen/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MyScaffoldProvider()),
      ChangeNotifierProvider(create: (context) => AuthorizationProvider()),
      ChangeNotifierProvider(create: (context) => PickFavoriteProvider()),
    ],
    child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.touch,
          PointerDeviceKind.unknown
        }
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        //Abel. Open Font License
        textTheme: GoogleFonts.abelTextTheme(Theme.of(context).textTheme),
      ),

      
      home: const PickFavorite()
      // home: const SplashScreen(),
    );
  }
}
