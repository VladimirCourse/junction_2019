import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class SecondButton extends StatelessWidget {
  final double height;
  final double fontSize;
  final String title;
  final EdgeInsets margin;
  final Function onPressed;

  SecondButton({this.title, this.height = 50, this.fontSize = 16, this.margin, this.onPressed});

  Widget build(BuildContext context) { 
    return Container(
      margin: margin,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey.withOpacity(0.7))
            ),
            child: FlatButton(
              onPressed: onPressed,
              color: Colors.transparent,
              child: Container(
                height: height,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                    fontSize: fontSize
                  )
                ),
              ),
            )
          )
        )
      )
    );
  }
}