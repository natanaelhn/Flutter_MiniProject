import 'package:flutter_application_mini_project/utils/my_token.dart';
import 'package:flutter_application_mini_project/utils/secret.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  

  test('get clientId', () async{
    var clientId = MyToken.clientId;
    expect(clientId, Secret.clientId);
  });
}