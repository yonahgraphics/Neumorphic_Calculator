import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final performAction;

  Button({required this.buttonText, required this.buttonColor, required this.textColor, this.performAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: performAction,
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: buttonColor,
              color: Colors.grey[300],
            boxShadow:  [
              BoxShadow(
                color: Colors.grey[500]??Colors.grey,
                offset: const Offset(4.0, 4.0),
                blurRadius: 8.0,
                spreadRadius: 1.0
              ),
              const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 8.0,
                  spreadRadius: 1.0
              )
                   ]
          ),
          child: Center(
            child: Text(buttonText!, style: TextStyle(color: textColor, fontSize: 25, fontWeight: FontWeight.bold),),
          ),
        ),
      ),
    );
  }
}
