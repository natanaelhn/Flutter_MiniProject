import 'package:dio/dio.dart';
import 'package:flutter_application_mini_project/model/access_token_service/access_token_object.dart';
import 'package:flutter_application_mini_project/model/my_token.dart';

class AccessTokenService{

  AccessTokenService(){
    _dio = Dio();
  }

  late final Dio _dio;

  final String _url = 'https://myanimelist.net/v1/oauth2/token';
  


  //Gain an access token for a limited time
  Future<AccessTokenObject> fetchPostAccessToken({required String authorizationCode}) async{
    
    final Response response = await _dio.post(
      'https://myanimelist.net/v1/oauth2/token',
      options: Options(
        contentType: Headers.formUrlEncodedContentType
      ),
      data: {
        'client_id' : MyToken.clientId,
        'grant_type' : 'authorization_code',
        'code' : authorizationCode,
        'code_verifier' : MyToken.codeVerifier,
      }
    );

    return AccessTokenObject.fromJSON(response.data);
  }


  //Refresh an old access token to a new access token
  Future<AccessTokenObject> fetchPostRefreshToken({required String refreshToken}) async{
    final Response response = await _dio.post(
      _url,
      options: Options(
        contentType: Headers.formUrlEncodedContentType
      ),
      data: {
        'client_id' : MyToken.clientId,
        'grant_type' : 'refresh_token',
        'refresh_token' : refreshToken,
      }
    );

    return AccessTokenObject.fromJSON(response.data);
  }
  
}