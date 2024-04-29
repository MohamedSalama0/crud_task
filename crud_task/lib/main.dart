import 'dart:io';

import 'package:crud_task/presentation/pages/home%20screen/home_screen.dart';
import 'package:crud_task/utils/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isWindows){
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(
        child: MaterialApp(
          title: 'CRUD Task',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              color: kPrimaryColor,
              iconTheme: const IconThemeData(color: kWhite),
            ),
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
