import 'package:flutter_application_mini_project/model/secret.dart';

class MyToken{

  static String authorizationUrl = 'https://myanimelist.net/v1/oauth2/authorize?response_type=code&client_id=2020f5a11581ee0b4f2f80fabe78642c&code_challenge=$codeVerifier';
  static String clientId = Secret.clientId;
  static String? accessToken;

  // unused
  // static String codeChallenge = 'biQ2VsX3fR2p4CKbih9jVHF6SLc0AgixcUIFxL8I-X8';
  static String codeVerifier = 'y24M6c9h1pNGW7tezGa18T1wTBH83f3j_wiRiuuE9Dop918ESVhG8bfhrq_492NQnSdEFJDjnMXcADSntv4LvfBduIn6DEXIQOC-MBYhI_dOQfiz3GTsWG5EHTssvgVf';
  
  static String authorizationCodeKey = 'AUTHORIZATION_CODE';
  static String refreshTokenKey = 'REFRESH_TOKEN';
}