import 'package:flutter/material.dart';
import 'package:agence_voyage_app/Screens/Register/components/body.dart';

class RegisterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Body(),
    );
  }
}
