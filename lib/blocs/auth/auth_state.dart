part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingAuth extends AuthState {}

class AuthSuccessful extends AuthState {}

class AuthFailed extends AuthState {}
