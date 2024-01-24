// ignore_for_file: prefer_const_constructors
// ignore: prefer_const_literals_to_create_immutables

// Class for Login screen

import 'package:blog_vlog/custom_components/custom_richtext.dart';
import 'package:blog_vlog/custom_components/custom_textfield.dart';
import 'package:blog_vlog/custom_components/oauth_box.dart';
import 'package:blog_vlog/routes/app_routes.dart';
import 'package:blog_vlog/util/consts.dart';
import 'package:blog_vlog/util/login_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../bloc/auth_bloc.dart';
import '../custom_components/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisible = true;
  LoginPreferences preferences = LoginPreferences();
  bool isLoggedIn = false;

  void signInManual() {
    context
        .read<AuthBlocBloc>()
        .add(ManualLoginEvent(emailController.text, passwordController.text));
  }

  void loginWithGoogle() {
    context.read<AuthBlocBloc>().add(GoogleLoginEvent());
  }

  void loginWithFacebook() {
    context.read<AuthBlocBloc>().add(FacebookLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    // To display the Oauth boxes UI in a row.
    Widget displayOauthBoxes() {
      return Wrap(
        children: [
          OuathBox(
            onclick: () {
              loginWithGoogle();
            },
            child: Image.network(
                'http://pngimg.com/uploads/google/google_PNG19635.png',
                fit: BoxFit.cover),
          ),
          SizedBox(
            width: 20,
          ),
          OuathBox(
            onclick: () {
              loginWithFacebook();
              print("login with facebook");
            },
            child: Icon(
              Icons.facebook,
              size: 40,
            ),
          ),
        ],
      );
    }

    // To build the login form
    Widget buildLoginForm() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Image.asset("lib/assets/logo-2.png"),
          SizedBox(
            height: 20,
          ),
          Text(
            "Login",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            maxlines: 1,
            suffix: Text(""),
            obscure: false,
            hint: "Email",
            label: "Email",
            controller: emailController,
          ),
          CustomTextField(
            maxlines: 1,
            suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: isVisible
                    ? Icon(
                        Icons.visibility,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black,
                      )),
            obscure: isVisible,
            hint: "Password",
            label: "Password",
            controller: passwordController,
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton(
            buttonText: 'Login',
            onPressed: signInManual,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(children: const [
              Expanded(
                  child: Divider(
                thickness: 1,
              )),
              Text("or"),
              Expanded(child: Divider(thickness: 1)),
            ]),
          ),
          displayOauthBoxes(),
          SizedBox(
            height: 40,
          ),
          CustomRichText(
            subtext1: "Don't have an account? ",
            subtext2: "Create an account!",
            onTap: () => Get.toNamed(AppRoutes.signupScreenRoute),
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff84A98C),
        body: SingleChildScrollView(
            child: Center(
          child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is AuthLoggedInSuccessState) {
                Future.delayed(Duration(milliseconds: 100), () async {
                  setState(() {
                    isLoggedIn = true;
                    preferences.saveLoginVal(isLoggedIn);
                    preferences.getLoginValue();
                  });
                  await Get.toNamed(AppRoutes.dashboardScreenRoute);
                });
              } else if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return AppConstants().displayLoading(context);
              } else {
                return buildLoginForm();
              }
            },
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
