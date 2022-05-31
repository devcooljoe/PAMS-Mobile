import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pams/views/authentication/auth.dart';
import 'package:pams/views/onboarding/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((val) {
    runApp(ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 700),
        builder: () => GetMaterialApp(
            theme: ThemeData(fontFamily: 'Rubik-Medium'),
            debugShowCheckedModeBanner: false,
            home: SplashScreen()));
  }
}