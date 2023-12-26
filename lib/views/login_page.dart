import 'package:aym_news/constants/app_routes.dart';
import 'package:aym_news/views/home_view.dart';
import 'package:aym_news/widgets/continue_with_line.dart';
import 'package:aym_news/widgets/custom_alert_dialog.dart';
import 'package:aym_news/widgets/forget_password.dart';
import 'package:aym_news/widgets/google_apple_signin.dart';
import 'package:aym_news/widgets/logo_welcomed_message.dart';
import 'package:aym_news/widgets/my_button.dart';
import 'package:aym_news/widgets/my_textfield.dart';
import 'package:aym_news/widgets/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // text editing controllers
    final email = TextEditingController();
    final password = TextEditingController();
    GlobalKey<FormState> formState = GlobalKey<FormState>();

    loginAsGuest() async {
      try {
        await FirebaseAuth.instance.signInAnonymously();
        print("Signed in with temporary account.");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeView(),
        ));
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "operation-not-allowed":
            customAlertDialog(context,
                "Anonymous auth hasn't been enabled for this project.");
            break;
          default:
            customAlertDialog(context, "Not Valid");
        }
      }
    }

    // Future signUserIn() async {
    //   try {
    //     UserCredential userCredential =
    //         await FirebaseAuth.instance.signInWithEmailAndPassword(
    //       email: email.text,
    //       password: password.text,
    //     );

    //     Navigator.of(context).pushReplacementNamed(AppRoutes.homeView);
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'user-not-found') {
    //       customAlertDialog(context, 'No user found for that email.');
    //     } else if (e.code == 'wrong-password') {
    //       customAlertDialog(context, 'Wrong password provided for that user.');
    //     } else {
    //       customAlertDialog(context, 'Not valid');
    //     }
    //   }
    // }
    Future<void> signUserIn() async {
      if (formState.currentState!.validate()) {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );

          Navigator.of(context).pushReplacementNamed(AppRoutes.homeView);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            customAlertDialog(context, 'No user found for that email.');
          } else if (e.code == 'wrong-password') {
            customAlertDialog(
                context, 'Wrong password provided for that user.');
          } else {
            customAlertDialog(
                context, 'Not valid , try again with a verified email');
          }
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
                  const SizedBox(height: 40),

                  //logo and welcomed messsage
                  const LogoAndWelcomedMessage(),

                  const SizedBox(height: 25),
                  // Email textfield
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

                  const SizedBox(height: 10),

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

                  const SizedBox(height: 10),

                  // forgot password?
                  const ForgetPassword(),

                  const SizedBox(height: 25),

                  // sign in and a Guest button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        onTap: loginAsGuest,
                        text: 'Guest',
                      ),
                      Expanded(
                        flex: 2,
                        child: MyButton(
                          onTap: signUserIn,
                          text: 'Sign In',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // or continue with
                  const ContinueWith(),

                  const SizedBox(height: 20),

                  // google + apple sign in buttons
                  const GoogleAndAppleSignIn(),

                  const SizedBox(height: 20),

                  // not a member? register now
                  const Register(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
