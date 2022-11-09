import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold_provider.dart';
import 'package:flutter_application_mini_project/screen/authorization/authorization_provider.dart';
import 'package:flutter_application_mini_project/screen/detail_anime/widgets/top_detail_container/top_detail_container_provider.dart';
import 'package:flutter_application_mini_project/screen/edit_my_list_anime/edit_my_list_anime_provider.dart';
import 'package:flutter_application_mini_project/screen/main/main_provider.dart';
import 'package:flutter_application_mini_project/screen/my_list_anime/my_list_anime_provider.dart';
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
      ChangeNotifierProvider(create: (context) => MainProvider(),),
      ChangeNotifierProvider(create: (context) => TopDetailContainerProvider(),),
      ChangeNotifierProvider(create: (context) => MyListAnimeProvider(),),
      ChangeNotifierProvider(create: (context) => EditMyListAnimeProvider(),),
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

      
      home: const SplashScreen()
      // home: const MyHomeScreen()
    );
  }
}
