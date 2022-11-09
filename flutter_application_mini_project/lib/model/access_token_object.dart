class AccessTokenObject{

  const AccessTokenObject({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  factory AccessTokenObject.fromJSON(Map<String, dynamic> json){

    return AccessTokenObject(
      accessToken: json['access_token'], 
      refreshToken: json['refresh_token'],
    );
  }

}