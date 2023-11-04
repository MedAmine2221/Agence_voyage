/*import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/bck.png",
              width: size.width * 0.35,
            ),
          ),
          child,
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand, // L'image s'étend sur toute la page
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(0), // Ajustez le rayon du coin arrondi selon vos préférences
          child: Image.asset(
            "assets/images/bck.png",
            height: size.height * 0.4,
            fit: BoxFit.cover, // Assurez-vous que l'image s'adapte correctement au coin arrondi
          ),
        ),
        child,
      ],
    );
  }
}