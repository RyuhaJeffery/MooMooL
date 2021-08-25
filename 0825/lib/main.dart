import 'package:agora_flutter_quickstart/agorafunc/thank.dart';
import 'package:agora_flutter_quickstart/app/modules/home/views/anything.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Future<void> _backMessage(RemoteMessage message) async {
//   print('background message ${message.notification}');
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   //await Firebase.initializeApp();
//   //FirebaseMessaging.onBackgroundMessage(_backMessage);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: 'anything', home: Thank());
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HomeBinding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(376, 812),
      builder: () => GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          accentColor: Colors.yellow,
          primaryColor: Color(0xff141A31),
          primaryColorDark: Color(0xff081029),
          scaffoldBackgroundColor: Color(0xffffffff),
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: Colors.yellow),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.yellowAccent),
                padding: MaterialStateProperty.all(EdgeInsets.all(14))),
          ),
        ),
      ),
    );
  }
}
