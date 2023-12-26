import 'package:aym_news/constants/app_routes.dart';
import 'package:aym_news/views/home_view.dart';
import 'package:aym_news/views/login_page.dart';
import 'package:aym_news/views/sign_up.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.loginPage: (context) => const LoginPage(),
  AppRoutes.signUpPage: (context) => const SignUp(),
  AppRoutes.homeView: (context) => const HomeView(),
};
