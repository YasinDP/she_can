import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:she_can/providers/auth.dart';
import 'package:she_can/providers/courses.dart';
import 'package:she_can/providers/news.dart';
import 'package:she_can/screens/courses/add_course_screen.dart';
import 'package:she_can/screens/dashboard.dart';

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
      ],
      child: MaterialApp(
        title: 'SheCan',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const SplashScreen(),
        home: const Dashboard(),
        routes: {
          AddCourseScreen.routeName: (context) => const AddCourseScreen(),
        },
      ),
    );
  }
}



// class sheCanMain extends StatefulWidget {
//   const sheCanMain({Key? key}) : super(key: key);

//   @override
//   State<sheCanMain> createState() => _sheCanMainState();
// }

// class _sheCanMainState extends State<sheCanMain> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'sheCan',
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: SplashScreen(),
//     );
//   }
// }
