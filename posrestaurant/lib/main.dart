import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posrestaurant/bloc/app_providers.dart';

import 'core/routes/router_config.dart';
import 'cubit/theme/theme_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: AppProviders.getBothProviders(),
        child: BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, theme){
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Restaurant',
                theme: theme,
                routerConfig: AppRouterConfig.routerConfig,
              );
            }
        )
    );
  }
}