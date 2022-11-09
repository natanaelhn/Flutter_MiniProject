import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/model/access_token_object.dart';
import 'package:flutter_application_mini_project/services/access_token_service.dart';
import 'package:flutter_application_mini_project/utils/my_loading_state.dart';
import 'package:flutter_application_mini_project/utils/my_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthorizationProvider with ChangeNotifier, MyLoadingState{
  
  final String _url = MyToken.authorizationUrl;
  String get url{
    return _url;
  }

  // String gainAuthorizationCode(String url){
  //   String authorizationCode = url.replaceFirstMapped('http://localhost/oauth?code=', (match) => '');
  //   return authorizationCode;
  // }

  Future<bool> gainAccessCode(String url) async {
    String authorizationCode = url.replaceFirstMapped('https://trudav.flutter/?code=', (match) => '');
    
    try{
      AccessTokenService accessTokenService = AccessTokenService();
      AccessTokenObject accessTokenObject = await accessTokenService.fetchPostAccessToken(
        authorizationCode: authorizationCode
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(MyToken.refreshTokenKey, accessTokenObject.refreshToken);

      MyToken.accessToken = accessTokenObject.accessToken;
      return true;
    }
    catch(e){
      return false;
    }

    


  }


  @override
  void setIsLoading(bool isLoading){
    super.setIsLoading(isLoading);
    notifyListeners();
  }
  
}