part of 'auth_bloc.dart';

abstract class AuthBlocEvent {}

class ManualLoginEvent extends AuthBlocEvent {
  final String email;
  final String password;

  ManualLoginEvent(this.email, this.password);
}

class GoogleLoginEvent extends AuthBlocEvent {}

class FacebookLoginEvent extends AuthBlocEvent {}

class LogoutEvent extends AuthBlocEvent {}
