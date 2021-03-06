import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_twitter/respository/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is InitLogin) {
      final bool result = await AuthRepository().login();
      if (result) {
        yield AuthSuccessful();
      } else {
        yield AuthFailed();
      }
    }
  }
}
