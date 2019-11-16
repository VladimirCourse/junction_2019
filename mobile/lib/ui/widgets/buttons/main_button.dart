import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class MainButton extends StatelessWidget {
  final double height;
  final double fontSize;
  final String title;
  final EdgeInsets margin;
  final Function onPressed;

  MainButton({this.title, this.height = 50, this.fontSize = 16, this.margin, this.onPressed});

  Widget build(BuildContext context) { 
    return Container(
      margin: margin,
      //padding: EdgeInsets.only(bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.075),
              blurRadius: 5,
              spreadRadius: 0.5,
              offset: Offset(0.0, 1.0,),
            )
          ],
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: AppColors.mainGradient
              )
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
                    color: Colors.white,
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