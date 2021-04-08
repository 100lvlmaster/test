part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  final int index;
  const HomeInitial(this.index);
}

class RenderTimeline extends HomeState {
  final List<Tweet> timelineTweets;
  final int index = 0;
  const RenderTimeline(this.timelineTweets);
}

class RenderProfile extends HomeState {
  final int index = 1;
  final List<Tweet> tweets;
  const RenderProfile(this.tweets);
}

class LogoutProfile extends HomeState {
  final int index = 1;
  const LogoutProfile();
}
