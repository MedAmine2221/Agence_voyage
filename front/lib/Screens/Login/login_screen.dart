import 'package:flutter/material.dart';
import 'package:agence_voyage_app/Screens/Login/components/body.dart';

class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Body(),
    );
  }
}
