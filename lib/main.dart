
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/infoHandler/app_info.dart';
import 'package:untitled/splashScreen/splash_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(
      child: ChangeNotifierProvider(
        create: (context) => AppInfo(),
        child: MaterialApp(
        title: 'Safe Ride',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
          home: const MySplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget
{
  final Widget? child;

  MyApp({this.child});

  static void restartApp(BuildContext context)
  {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{

  Key key = UniqueKey();
  void restartApp()
  {
    setState(() {
      key= UniqueKey();
    });
  }
  @override
  Widget build(BuildContext context){
    return KeyedSubtree(
  key: key,
  child: widget.child!,
  );
  }
}
