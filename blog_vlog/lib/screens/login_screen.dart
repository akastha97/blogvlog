// ignore_for_file: prefer_const_constructors
// ignore: prefer_const_literals_to_create_immutables
import 'package:blog_vlog/custom_components/custom_textfield.dart';
import 'package:blog_vlog/custom_components/oauth_box.dart';
import 'package:blog_vlog/services/account_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff84A98C),
        body: Center(
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
                suffix: Text(""),
                obscure: false,
                hint: "Email",
                label: "Email",
                controller: emailController,
              ),
              CustomTextField(
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
              SizedBox(
                height: 48,
                width: 100,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      // login button action
                      signInManual();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black),
                    )),
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
              Wrap(
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
              ),
              SizedBox(
                height: 40,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Dont have an account? ",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //  debugPrint("tapped");
                        // navigate to registration page
                        Navigator.pushNamed(context, "/signup_screen");
                      },
                    text: "Create an Account!",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ])),
            ],
          ),
        ),
      ),
    );
  }

  // Method to sign in with google account
  Future<void> loginWithGoogle() async {
    AccountServices().signInWithGoogle().then((value) {
      debugPrint("logged in with google, move to dashboard");
      Navigator.pushNamed(context, "/dashboard_screen");
    });
  }

  // Method to sign in with google account
  Future<void> loginWithFacebook() async {
    AccountServices().signInWithFacebook().then((value) {
      debugPrint("logged in with facebook, move to dashboard");
      Navigator.pushNamed(context, "/dashboard_screen");
    });
  }

  // Method to sign in to the app manually with email and password.
  Future<void> signInManual() async {
    AccountServices()
        .loginToAccount(emailController.text, passwordController.text)
        .then((value) {
      debugPrint("logged in, move to dashboard");
      Navigator.pushNamed(context, "/dashboard_screen");
    });
  }
}
