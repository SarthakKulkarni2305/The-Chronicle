import 'package:aym_news/constants/app_routes.dart';
import 'package:aym_news/widgets/continue_with_line.dart';
import 'package:aym_news/widgets/custom_alert_dialog.dart';
import 'package:aym_news/widgets/google_apple_signin.dart';
import 'package:aym_news/widgets/my_button.dart';
import 'package:aym_news/widgets/my_textfield.dart';
import 'package:aym_news/widgets/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();
    GlobalKey<FormState> formState = GlobalKey<FormState>();

    Future createUserWithEmailAndPassword() async {
      if (formState.currentState!.validate()) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
                backgroundColor: Colors.black,
                content: Text(
                  'Check you email for verification',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.loginPage);
                    },
                    child: Text(
                      'Ok',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            customAlertDialog(context, 'The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            customAlertDialog(
                context, 'The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // username textfield
                  MyTextField(
                    controller: userName,
                    hintText: 'Username',
                    obscureText: false,
                    validator: (val) {
                      if (val == '') {
                        return 'Please enter your name';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // password textfield
                  MyTextField(
                    controller: email,
                    hintText: 'Email',
                    obscureText: false,
                    validator: (val) {
                      if (val == '') {
                        return 'Please enter your email';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // password textfield
                  MyTextField(
                    controller: password,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (val) {
                      if (val == '') {
                        return 'Please enter your password';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 60),

                  MyButton(
                    onTap: createUserWithEmailAndPassword,
                    text: 'Sign Up',
                  ),
                  const SizedBox(height: 30),

                  // or continue with
                  const ContinueWith(),

                  const SizedBox(height: 30),

                  // google + apple sign in buttons
                  const GoogleAndAppleSignIn(),

                  const SizedBox(height: 20),

                  // not a member? register now
                  const SignIn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
