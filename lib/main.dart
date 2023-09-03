
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/edit/edit.dart';
import 'package:todo/screens/login/login.dart';
import 'package:todo/screens/setting.dart';
import 'package:todo/screens/signUp/signup.dart';
import 'package:todo/shared/style/theming/my_theme.dart';

import 'firebase_options.dart';
import 'layout/home_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => MyProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      initialRoute:provider.firebaseUser!=null?Homelyout.routeName
          :LoginScreen.routeName,
      routes: {
       Homelyout.routeName:(context) => Homelyout(),
        LoginScreen.routeName:(context) => LoginScreen(),
        SignUpScreen.routeName:(context) => SignUpScreen(),
        EditScreen.routeName:(context) => EditScreen(),
        settingTab.routeName:(context) => settingTab()

      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
     // themeMode: MyThemeData.lightTheme,
    );
  }
}
