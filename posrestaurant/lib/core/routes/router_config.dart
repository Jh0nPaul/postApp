import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/account/loging_screen.dart';
import '../../presentation/home/home_screen.dart';

class AppRouterConfig{
  AppRouterConfig._();

  static final routerConfig = GoRouter(
    initialLocation: '/LoginScreen',
      routes: [
        GoRoute(
            path: '/LoginScreen',
            pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
        ),
        GoRoute(
            path: '/HomeScreen',
          pageBuilder: (context, state) => MaterialPage(child: HomeScreen())
        ),
      ],
  );
}