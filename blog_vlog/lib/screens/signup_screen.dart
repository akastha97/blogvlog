import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Color(0xff84A98C),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Image.asset("lib/assets/logo-2.png"),
          SizedBox(
            height: 20,
          ),
          Text(
            "Create Account",
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
          SizedBox(
            height: 48,
            width: 200,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  createAccount();
                  debugPrint("account created successfully");
                  Navigator.pushNamed(context, "/login_screen");
                },
                child: const Text(
                  "Create Account",
                  style: TextStyle(color: Colors.black),
                )),
          ),
          const SizedBox(height: 40),
          RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: "Already have an account? ",
                style: TextStyle(color: Colors.black)),
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //  debugPrint("tapped");
                    // navigate to registration page
                    Navigator.pushNamed(context, "/login_screen");
                  },
                text: "Login here!",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ]))
        ],
      )),
    );
  }

  Future<void> createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
