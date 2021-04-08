part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

class SelectPage extends HomeEvent {
  final int index;
  const SelectPage(this.index);
}

class FetchTimeline extends HomeEvent {}

class FetchProfile extends HomeEvent {}

class TapBottomNav extends HomeEvent {
  final int index;
  const TapBottomNav(this.index);
}
