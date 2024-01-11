// ignore_for_file: prefer_const_constructors
// ignore: prefer_const_literals_to_create_immutables

// Class for Login screen

import 'package:blog_vlog/custom_components/custom_richtext.dart';
import 'package:blog_vlog/custom_components/custom_textfield.dart';
import 'package:blog_vlog/custom_components/oauth_box.dart';
import 'package:blog_vlog/routes/app_routes.dart';
import 'package:blog_vlog/services/account_services.dart';
import 'package:blog_vlog/util/login_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff84A98C),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
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
                  onTap: () => Navigator.pushNamed(context, "/signup_screen"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  // To save the login value to shared preferences.
  void saveLoginValues() async {
    setState(() {
      isLoggedIn = true;
      preferences.saveLoginVal(isLoggedIn);
      preferences.getLoginValue();
    });
  }

  // // Method to sign in with google account
  Future<void> loginWithGoogle() async {
    AccountServices().signInWithGoogle().then((value) {
      debugPrint("logged in with google, move to dashboard");
      saveLoginValues();
      Get.toNamed(AppRoutes.dashboardScreenRoute);
    });
  }

  // Method to sign in with google account
  Future<void> loginWithFacebook() async {
    AccountServices().signInWithFacebook().then((value) {
      debugPrint("logged in with facebook, move to dashboard");
      saveLoginValues();
      Get.toNamed(AppRoutes.dashboardScreenRoute);
    });
  }

  // Method to sign in to the app manually with email and password.
  Future<void> signInManual() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      AccountServices()
          .loginToAccount(emailController.text, passwordController.text)
          .then((value) {
        debugPrint("logged in, move to dashboard");
        saveLoginValues();

        Get.toNamed(AppRoutes.dashboardScreenRoute);
      });
    } else {
      debugPrint("Show error for textfields");
      // form validations can be done
      // for now not doing any
    }
  }
}
