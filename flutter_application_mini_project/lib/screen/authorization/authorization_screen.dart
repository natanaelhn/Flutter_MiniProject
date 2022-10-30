import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_loading/my_loading.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold.dart';
import 'package:flutter_application_mini_project/screen/authorization/authorization_provider.dart';
import 'package:flutter_application_mini_project/screen/%5BEXAMPLE%5Dmy_home_screen.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {

  // final Completer<WebViewController> _webViewController = Completer<WebViewController>();
  final Completer<WebViewController> _webViewController = Completer<WebViewController>();

  @override
  void initState() {

    super.initState();
    if(Platform.isAndroid){
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {

    AuthorizationProvider authorizationProvider = Provider.of<AuthorizationProvider>(context, listen: false);

    return Stack(
      children: [
        MyScaffold(
          backButton: false,
          scrollable: false,
          colorPrimary: MyColor.primaryColor,
          child: (isPortrait) {
            return WebView(
              initialUrl: authorizationProvider.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                if(!_webViewController.isCompleted){
                  _webViewController.complete(controller);
                }
              },
              onPageStarted: (url) {   
                authorizationProvider.setIsLoading(true);
              },
              onPageFinished: (url) {
                authorizationProvider.setIsLoading(false);
              },
              onWebResourceError: (error) {
                authorizationProvider.setIsLoading(false);
              },
              navigationDelegate: (navigationRequest) async{

                authorizationProvider.setIsLoading(true);
                
                //if redirected to 'http://trudav.flutter'
                if(navigationRequest.url.startsWith('https://trudav.flutter')) {
                  // String authorizationCode = authorizationProvider.gainAuthorizationCode(navigationRequest.url);
                  

                  bool validAccess = await authorizationProvider.gainAccessCode(navigationRequest.url);
                  
                  if(validAccess && mounted){
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => const MyHomeScreen(),
                    ));
                  }
                  
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Unexpected error. Please try again'))
                    );

                    Navigator.pushReplacement(context,MaterialPageRoute(
                      builder: (context) => const AuthorizationScreen(),
                    ));
                  }
                  
                  authorizationProvider.setIsLoading(false);
                  return NavigationDecision.navigate;
                }

                authorizationProvider.setIsLoading(false);
                return NavigationDecision.navigate;
              },

            );
          },
        ),


        //Loading Widget
        Consumer<AuthorizationProvider>(
          builder: (context, value, child) => 
            MyLoading(isLoading: value.isLoading, color: MyColor.primaryColor,)
        )
      ],
    );
  }
}