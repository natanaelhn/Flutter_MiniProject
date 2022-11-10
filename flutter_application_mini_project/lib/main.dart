import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold_provider.dart';
import 'package:flutter_application_mini_project/screen/authorization/authorization_provider.dart';
import 'package:flutter_application_mini_project/screen/detail_anime/widgets/top_detail_container/top_detail_container_provider.dart';
import 'package:flutter_application_mini_project/screen/edit_my_list_anime/edit_my_list_anime_provider.dart';
import 'package:flutter_application_mini_project/screen/main/main_provider.dart';
import 'package:flutter_application_mini_project/screen/more_list/more_list_provider.dart';
import 'package:flutter_application_mini_project/screen/my_list_anime/my_list_anime_provider.dart';
import 'package:flutter_application_mini_project/screen/pick_favorite/pick_favorite_provider.dart';
import 'package:flutter_application_mini_project/screen/splash_screen/splash_screen.dart';
import 'package:flutter_application_mini_project/utils/notification_controller.dart';
import 'package:flutter_application_mini_project/utils/my_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {

  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
        channelGroupKey: MyNotification.channelGroupKey,
        channelKey: MyNotification.channelKey,
        channelName: 'MAL TruDav notification',
        channelDescription: 'Notification Description',
        // defaultColor: MyColor.primaryColor,
        ledColor: Colors.green,
        importance: NotificationImportance.High,
        playSound: true
      )
    
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: MyNotification.channelGroupKey,
        channelGroupName: 'MAL TruDav group notification',
      )
    ],
    debug: true,
  );


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MyScaffoldProvider()),
      ChangeNotifierProvider(create: (context) => AuthorizationProvider()),
      ChangeNotifierProvider(create: (context) => PickFavoriteProvider()),
      ChangeNotifierProvider(create: (context) => MainProvider(),),
      ChangeNotifierProvider(create: (context) => TopDetailContainerProvider(),),
      ChangeNotifierProvider(create: (context) => MyListAnimeProvider(),),
      ChangeNotifierProvider(create: (context) => EditMyListAnimeProvider(),),
      ChangeNotifierProvider(create: (context) => MoreListProvider(),),
    ],
    child: const MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {

    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: (ReceivedAction receivedAction){
            return NotificationController.onActionReceivedMethod(receivedAction);
        },
        onNotificationCreatedMethod: (ReceivedNotification receivedNotification){
            return NotificationController.onNotificationCreatedMethod(receivedNotification);
        },
        onNotificationDisplayedMethod: (ReceivedNotification receivedNotification){
            return NotificationController.onNotificationDisplayedMethod(receivedNotification);
        },
        onDismissActionReceivedMethod: (ReceivedAction receivedAction){
            return NotificationController.onDismissActionReceivedMethod(receivedAction);
        },
    );

    super.initState();
  }

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
