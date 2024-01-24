import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final FirebaseAuth _auth;

  AuthBlocBloc(this._auth) : super(AuthInitialState()) {
    on<ManualLoginEvent>(_onManualLoginEvent);
    on<GoogleLoginEvent>(_onGoogleLoginEvent);
    on<FacebookLoginEvent>(_onFacebookLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onManualLoginEvent(
      ManualLoginEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState(isLoading: true));
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
              email: event.email, password: event.password);
      final UserModel userModel = UserModel(
          email: userCredential.user!.email!, uid: userCredential.user!.uid);
      emit(AuthLoggedInSuccessState(userModel));
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> _onGoogleLoginEvent(
      GoogleLoginEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState(isLoading: true));
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final UserModel userModel = UserModel(
          email: userCredential.user!.email!, uid: userCredential.user!.uid);
      emit(AuthLoggedInSuccessState(userModel));
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> _onFacebookLoginEvent(
      FacebookLoginEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState(isLoading: true));
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);
      final UserModel userModel = UserModel(
          email: userCredential.user!.email!, uid: userCredential.user!.uid);
      emit(AuthLoggedInSuccessState(userModel));
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState(isLoading: true));
    try {
      await _auth.signOut();
      emit(AuthInitialState());
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }
}
