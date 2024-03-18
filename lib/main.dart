import 'package:amazon_clone/Features/Auth/Screens/auth_screen.dart';
import 'package:amazon_clone/Features/Auth/Services/auth_services.dart';

import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
            //i have used Global variable in color scheme because (refer appbar gradientScheme in Global_variables ) i cant give gradient color to app bar and hence i am giving this color to primary Scheme so that everything that appears with this at first
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          )),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Amazon clone')),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Home page'),
            ),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AuthScreen.routeName);
                },
                child: Text('Click'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
