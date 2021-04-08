import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:test_twitter/config/const.dart';

class AuthRepository {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  static final TwitterLogin _twitterLogin = TwitterLogin(
    consumerKey: Secrets.consumerKey,
    consumerSecret: Secrets.consumerSecret,
  );

  Future<bool> login() async {
    final TwitterLoginResult result = await _twitterLogin.authorize();
    bool isSuccess = false;
    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        isSuccess = await _saveToStorage(result.session);
        break;
      case TwitterLoginStatus.cancelledByUser:
        isSuccess = false;
        break;
      case TwitterLoginStatus.error:
        isSuccess = false;
        break;
    }
    return isSuccess;
  }

  Future<bool> _saveToStorage(TwitterSession session) async {
    try {
      await _storage.write(key: Const.userId, value: session.userId);
      await _storage.write(key: Const.userName, value: session.username);
      await _storage.write(key: Const.userSecret, value: session.secret);
      await _storage.write(key: Const.userToken, value: session.token);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> isLoggedIn() async => (await _storage.readAll()).isNotEmpty;
}
