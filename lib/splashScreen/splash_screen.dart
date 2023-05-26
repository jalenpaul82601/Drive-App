import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/assistants/assistant_methods.dart';
import 'package:untitled/authentication/login_screen.dart';
import 'package:untitled/global/global.dart';
import 'package:untitled/mainScreens/main_screen.dart';



class MySplashScreen extends StatefulWidget
{
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}




class _MySplashScreenState extends State<MySplashScreen>
{

  startTimer()
  {
    fAuth.currentUser!= null ? AssistantMethods.readCurrentOnlineUserInfo() : null;

    Timer(const Duration(seconds: 3),  () async
    {
      if(await fAuth.currentUser!= null)
      {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
      }
      else
        {
          Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
        }
      //send user to home screen
    });
  }

  @override
  void initState()
  {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context)
  {

    return Material (
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset("images/logo1.png"),

            const SizedBox(height: 10,),



            const Text(
                "Safe Ride App",
                style:TextStyle(
                  fontSize: 20,
                  color:Colors.white,
                  fontWeight: FontWeight.bold,
            )
            ),
          ],
        ),
      ),
    );
  }
}
