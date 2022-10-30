import 'package:flutter_application_mini_project/model/access_token_service/access_token_object.dart';
import 'package:flutter_application_mini_project/model/access_token_service/access_token_service.dart';
import 'package:flutter_application_mini_project/model/my_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel{
  
  //refresh an old access token to new access token
  Future<bool> gainRefreshToken({required String refreshToken}) async{

    AccessTokenService accessTokenService = AccessTokenService();

    try{
      AccessTokenObject accessTokenObject = await accessTokenService.fetchPostRefreshToken(
        refreshToken: refreshToken
      );
      MyToken.accessToken = accessTokenObject.accessToken;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(MyToken.refreshTokenKey, accessTokenObject.refreshToken);
      
      return true;
    }
    catch(e){
      return false;
    }
  }

}