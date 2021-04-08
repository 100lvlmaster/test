import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_twitter/respository/auth.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    //
    if (state is SplashInitial) {
      final bool isLoggedIn = await AuthRepository().isLoggedIn();
      if (isLoggedIn) {
        yield Authenticated();
      } else {
        yield UnAuthenticated();
      }
    }
    //
  }
}
