import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:she_can/providers/auth.dart';
import 'package:she_can/providers/courses.dart';
import 'package:she_can/providers/news.dart';
import 'package:she_can/providers/notifications.dart';
import 'package:she_can/screens/courses/add_course_screen.dart';
import 'package:she_can/screens/courses/course_detail_screen.dart';
import 'package:she_can/screens/courses/edit_course_screen.dart';
import 'package:she_can/screens/dashboard.dart';
import 'package:she_can/screens/login/login_screen.dart';
import 'package:she_can/screens/splash_screen.dart';
import 'package:she_can/screens/video_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: kIsWeb || Platform.isAndroid
      //     ? const FirebaseOptions(
      //         apiKey: "my-app-key",
      //         appId: "1:292868887256:android:b8bdbf3ae391f18b65bdad",
      //         messagingSenderId: "292868887256",
      //         projectId: "she-can",
      //         storageBucket: "she-can.appspot.com",
      //       )
      //     : null,
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => NewsNotifier(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CoursesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => NotificationsNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'SheCan',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
            stream: AuthNotifier().userStatus(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                bool userLoggedIn = snapshot.data as bool;
                print("user status is $userLoggedIn");
                if (userLoggedIn) {
                  return const Dashboard();
                } else {
                  return const SplashScreen();
                }
              }
              return const SplashScreen();
            }),
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          AddCourseScreen.routeName: (context) => const AddCourseScreen(),
          CourseDetailsScreen.routeName: (context) =>
              const CourseDetailsScreen(),
          UpdateCourseScreen.routeName: (context) => const UpdateCourseScreen(),
          VideoScreen.routeName: (context) => const VideoScreen(),
        },
      ),
    );
  }
}
