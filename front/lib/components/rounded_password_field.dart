import 'package:flutter/material.dart';
import 'package:agence_voyage_app/components/text_field_container.dart';
import 'package:agence_voyage_app/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _obscureText = true;
  String _password = ''; // Ajout de cette variable

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldContainer(
          child: TextField(
            obscureText: _obscureText,
            onChanged: (value) {
              setState(() {
                _password = value; // Mettre à jour le mot de passe
              });
              widget.onChanged(value);
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              icon: Icon(
                Icons.lock,
                color: kPrimaryColor,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: kPrimaryColor,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          _password.length == 0 ? "" : _passwordStrength(),
          style: TextStyle(
            color: _passwordColor(),
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  String _passwordStrength() {
    if (_password.length >= 8 &&
        RegExp(r'[0-9]').hasMatch(_password) &&
        RegExp(r'[a-zA-Z]').hasMatch(_password)) {
      return "strong password";
    } else {
      return "weak password";
    }
  }

  Color _passwordColor() {
    if (_password.length >= 8 &&
        RegExp(r'[0-9]').hasMatch(_password) &&
        RegExp(r'[a-zA-Z]').hasMatch(_password)) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}