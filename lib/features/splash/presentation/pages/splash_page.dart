import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/params_constant.dart';
import '../../../../core/router/routes.dart';
import '../../../../ui/assets/app_assets.dart';
import '../../../../ui/colors/app_colors.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    unawaited(_checkSplash());
    super.initState();
  }

  Future<void> _checkSplash() async {
    await Future.delayed(const Duration(seconds: kTimerSplashScreen), () {
      context.go(AppRoutes.home.routePath);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImagePaths.appLogo,
                width: MediaQuery.of(context).size.width / 3.5,
              ),
              const SizedBox(height: 20),
              Text(
                kAppName,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      );
}
