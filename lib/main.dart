import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_fuel_app/provider/base_provider.dart';
import 'package:your_fuel_app/provider/main_provider.dart';
import 'package:your_fuel_app/ui/root_page.dart';
import 'package:your_fuel_app/utils/app_config.dart';
import 'package:your_fuel_app/utils/app_utils.dart';
import 'package:your_fuel_app/widgets/app_loading.dart';

import 'ui/login/login.dart';

void main() {
  AppConfig.build(Environment.dev);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>LoadingProvider()),
        ChangeNotifierProvider(create: (context) => MainProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final isLogin = context.watch<MainProvider>().isLogin;

    return MaterialApp(
      title: "Test UI App",
      navigatorKey: AppConstants.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child){
        setContext(context);
        return Stack(children: [
          child!,
          Consumer<LoadingProvider>(builder: (_,loadingProvider,__){
            return loadingProvider.isLoading? const AppLoading(): SizedBox();
          })
        ],);
      },
      theme: ThemeData(primaryColor: AppColors.primaryColor,
          primaryColorDark: AppColors.primaryColorDark,
          primaryColorLight: AppColors.primaryColorLight),
      home: Scaffold(
        body: isLogin ? RootPage() : const LoginPage(),
      ),
    );
  }
}