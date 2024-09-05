import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/entry_point.dart';
import 'package:se_project/features/auth/auth_screen.dart';
import 'package:se_project/providers/user_provider.dart';
import 'package:se_project/router.dart';
import 'package:se_project/services/auth_service.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
    ],
    child: const MyApp()));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        primarySwatch: Colors.blue,
        fontFamily: "Intel",
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ) ,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black,
          ),
        ),
        

        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty 
          ? Provider.of<UserProvider>(context).user.type == 'admin' 
              ? const EntryPoint()
              : const EntryPoint()
          : const AuthScreen(),
    );
  }
}

