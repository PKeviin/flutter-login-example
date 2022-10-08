import 'package:flutter/widgets.dart';
import '../../features/commons/pages/errors/error_connection_page.dart';
import '../../features/feature1/presentation/pages/home_page.dart';
import '../../features/forget_password/presentation/pages/forget_password_page.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/signup/presentation/pages/signup_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

enum AppRoutes {
  login(
    '/login',
    'login',
    LoginPage(),
  ),
  home(
    '/',
    'home',
    HomePage(),
  ),
  signup(
    '/signup',
    'signup',
    SignupPage(),
  ),
  forgetPassword(
    '/forget_password',
    'forget_password',
    ForgetPasswordPage(),
  ),
  errorConnection(
    '/error_connection',
    'error_connection',
    ErrorConnectionPage(),
  ),
  splash(
    '/splash',
    'splash',
    SplashPage(),
  );

  const AppRoutes(
    this.routePath,
    this.routeName,
    this.routeView,
  );

  final String routePath;
  final String routeName;
  final Widget routeView;

  @override
  String toString() => '$name: [$routePath][$routeName][$routeView]';
}
