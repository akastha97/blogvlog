part of 'auth_bloc.dart';

abstract class AuthBlocState {}

// Initial State 
class AuthInitialState extends AuthBlocState {}

// Loading state
class AuthLoadingState extends AuthBlocState {
  final bool isLoading;

  AuthLoadingState({required this.isLoading});
}

// Auth login successful state
class AuthLoggedInSuccessState extends AuthBlocState {
  final UserModel userModel;

  AuthLoggedInSuccessState(this.userModel);
}

// Auth login error state
class AuthErrorState extends AuthBlocState {
  final String errorMessage;

  AuthErrorState({required this.errorMessage});
}
