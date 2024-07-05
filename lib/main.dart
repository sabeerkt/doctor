import 'package:doctor/controller/baseprovider.dart';
import 'package:doctor/controller/student_provider.dart';
import 'package:doctor/firebase_options.dart';
import 'package:doctor/views/screens/home.dart';
import 'package:doctor/views/screens/spalsh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StudentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BaseProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  SplashScreen(),
      ),
    );
  }
}
