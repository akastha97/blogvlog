import 'package:blog_vlog/routes/app_routes.dart';
import 'package:blog_vlog/screens/add_blogpost_screen.dart';
import 'package:blog_vlog/screens/dashboard_screen.dart';
import 'package:blog_vlog/screens/home_screen.dart';
import 'package:blog_vlog/screens/login_screen.dart';
import 'package:blog_vlog/screens/signup_screen.dart';
import 'package:get/get.dart';

import '../screens/view_blogpost.dart';

class AppScreens {
  final List<GetPage> screens = [
    GetPage(name: AppRoutes.homeScreenRoute, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.loginScreenRoute, page: () => const LoginScreen()),
    GetPage(
        name: AppRoutes.signupScreenRoute, page: () => const SignupScreen()),
    GetPage(
        name: AppRoutes.dashboardScreenRoute, page: () => DashboardScreen()),
    GetPage(
        name: AppRoutes.viewBlogScreenRoute,
        page: () => ShowBlogScreen(
              argsData: "",
            )),
    GetPage(
        name: AppRoutes.addBlogScreenRoute, page: () => const BlogPostScreen())
  ];
}
