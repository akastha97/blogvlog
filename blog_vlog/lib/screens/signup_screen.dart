// Class for Signup screen

import 'package:blog_vlog/routes/app_routes.dart';
import 'package:blog_vlog/util/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_components/custom_button.dart';
import '../custom_components/custom_richtext.dart';
import '../custom_components/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPass = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff84A98C),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset("lib/assets/logo-2.png"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Create Account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
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
                        showPass = !showPass;
                      });
                    },
                    child: showPass
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black,
                          )),
                obscure: showPass,
                hint: "Password",
                label: "Password",
                controller: passwordController,
              ),
              const SizedBox(
                height: 40,
              ),
              // login button
              CustomButton(
                buttonText: 'Create Account',
                onPressed: () {
                  AppConstants().displayLoading(context);
                  createAccount();
                  // To pop the dialog
                  Get.back();
                },
              ),
              const SizedBox(height: 40),
              CustomRichText(
                subtext1: 'Already have an account?',
                subtext2: ' Login here!',
                onTap: () => Get.toNamed(AppRoutes.loginScreenRoute),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Future<void> createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      debugPrint("Account created successfully");
      AppConstants().displaySnackBar("Account created succesfully");
      Get.toNamed(AppRoutes.loginScreenRoute);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        AppConstants()
            .displaySnackBar("The account already exists for that email");

        Get.back();
      }
    } catch (e) {
      print(e);
    }
  }
}
