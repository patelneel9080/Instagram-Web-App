import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Pages/loginpage.dart';
import 'package:instagram/firebase_options.dart';
import 'package:instagram/responsive_layout/mobilescreen_layout.dart';
import 'package:instagram/responsive_layout/responsive_layout.dart';
import 'package:instagram/responsive_layout/webscreen_layout.dart';
import 'package:instagram/splashscreen.dart';
import 'package:instagram/utils/colors.dart';

import 'Pages/continue_page.dart';

/*
web       1:645408821072:web:dabc590a0f9d2d6a312655
android   1:645408821072:android:908adc9bd4fb58df312655
ios       1:645408821072:ios:020bde6339357605312655
macos     1:645408821072:ios:c4ef6297aa538733312655
 */

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // if (kIsWeb) {
  //   Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //     apiKey: "AIzaSyA14YrexcMteujwJ4XuGee0rOFvWzAGc7s",
  //     authDomain: "instagram-7dc7a.firebaseapp.com",
  //     projectId: "instagram-7dc7a",
  //     storageBucket: "instagram-7dc7a.appspot.com",
  //     messagingSenderId: "645408821072",
  //     appId: "1:645408821072:web:dabc590a0f9d2d6a312655",
  //   ));
  // } else {
  //   Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA14YrexcMteujwJ4XuGee0rOFvWzAGc7s",
      appId: "1:645408821072:web:dabc590a0f9d2d6a312655",
      messagingSenderId: "645408821072",
      storageBucket: "instagram-7dc7a.appspot.com",
      projectId: "instagram-7dc7a",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showingSplash = true;
  LoadHome() {
    Future.delayed(const Duration(seconds: 12), () {
      setState(() {
        showingSplash = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadHome();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.active) {
            if (snapShot.hasData) {
              return  ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),);
            } else if (snapShot.hasError) {
              return LoginPage();
            } else {
              return ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),);
            }
          } else if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapShot.hasData) {
            return  LoginPage();
          } else {
            return Text(
              snapShot.error.toString(),
            );
          }
        },
      ),
    );
  }
}
