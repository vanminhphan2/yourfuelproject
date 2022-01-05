import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourfuel/firebase_options.dart';
import 'package:yourfuel/provider/base_provider.dart';
import 'package:yourfuel/provider/main_provider.dart';
import 'package:yourfuel/ui/root_page.dart';
import 'package:yourfuel/utils/app_config.dart';
import 'package:yourfuel/utils/app_utils.dart';
import 'package:yourfuel/widgets/app_loading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';
import 'ui/login/login.dart';

void main() async {
  AppConfig.build(Environment.dev);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoadingProvider()),
    ChangeNotifierProvider(create: (context) => MainProvider()),
  ], child: const MyApp()));
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
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('vi',"VN"),
      navigatorKey: AppConstants.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        setContext(context);
        return Stack(
          children: [
            child!,
            Consumer<LoadingProvider>(builder: (_, loadingProvider, __) {
              return loadingProvider.isLoading
                  ? const AppLoading()
                  : SizedBox();
            })
          ],
        );
      },
      theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          primaryColorDark: AppColors.primaryColorDark,
          primaryColorLight: AppColors.primaryColorLight),
      home: Scaffold(
        backgroundColor: AppColors.pinkLightPurple,
        body: isLogin ? RootPage() : const LoginPage(),
      ),
    );
  }
}
