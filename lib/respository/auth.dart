import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:test_twitter/config/const.dart';

class Auth {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: Const.consumerKey,
    consumerSecret: Const.consumerSecret,
  );

  static void login() async {
    final TwitterLoginResult result = await twitterLogin.authorize();
    String newMessage;
    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        newMessage = 'Logged in! username: ${result.session.username}';
        break;
      case TwitterLoginStatus.cancelledByUser:
        newMessage = 'Login cancelled by user.';
        break;
      case TwitterLoginStatus.error:
        newMessage = 'Login error: ${result.errorMessage}';
        break;
    }
    // storage.write(key: 'name', value: result.session.)
  }
  // Future<UserCredential> signInWithTwitter() async {
  //   // Create a TwitterLogin instance
  //   final TwitterLogin twitterLogin = new TwitterLogin(
  //     consumerKey: '<your consumer key>',
  //     consumerSecret: ' <your consumer secret>',
  //   );

  //   // Trigger the sign-in flow
  //   final TwitterLoginResult loginResult = await twitterLogin.authorize();

  //   // Get the Logged In session
  //   final TwitterSession twitterSession = loginResult.session;

  //   // Create a credential from the access token
  //   final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
  //       accessToken: twitterSession.token, secret: twitterSession.secret);

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance
  //       .signInWithCredential(twitterAuthCredential);
  // }
}
