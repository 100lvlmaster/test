import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_twitter/config/const.dart';

class TwitterRepository {
  const TwitterRepository();

  ///
  Future<TwitterApi> _fetchClient() async {
    final FlutterSecureStorage _storage = FlutterSecureStorage();
    TwitterClient _twitterClient = TwitterClient(
      consumerKey: Secrets.consumerKey,
      consumerSecret: Secrets.consumerSecret,
      token: await _storage.read(key: Const.userToken),
      secret: await _storage.read(key: Const.userSecret),
    );
    return TwitterApi(client: _twitterClient);
  }

  /// ` Data fetching `
  Future<List<Tweet>> fetchTimeline() async {
    List<Tweet> tweets;
    try {
      final client = await _fetchClient();
      tweets = await client.timelineService.homeTimeline();
    } catch (e) {
      throw e;
    }
    return tweets;
  }

  Future<List<Tweet>> fetchProfile() async {
    List<Tweet> tweets;
    try {
      final client = await _fetchClient();
      tweets = await client.timelineService.userTimeline();
    } catch (e) {
      throw e;
    }
    return tweets;
  }
}
