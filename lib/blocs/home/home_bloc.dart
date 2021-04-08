import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_twitter_api/api/tweets/data/tweet.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:test_twitter/respository/twitter.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(0));
  final TwitterRepository _twitterRepository = TwitterRepository();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    //
    if (event is SelectPage) {
      yield HomeInitial(event.index);
      if (event.index == 0) {
        List<Tweet> tweets = await _twitterRepository.fetchTimeline();
        yield RenderTimeline(tweets);
      }
      if (event.index == 1) {
        List<Tweet> tweets = await _twitterRepository.fetchProfile();
        yield RenderProfile(tweets);
      }
      if (event.index == 2) {
        await FlutterSecureStorage().deleteAll();
        yield LogoutProfile();
      }
    }
    //
  }
}
