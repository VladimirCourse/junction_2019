import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MainCard extends StatelessWidget {

  final Widget child;
  final EdgeInsets padding;

  MainCard({this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 0.5,
            offset: Offset(0, 1),
          )
        ],
      ),
      margin: EdgeInsets.only(left: 10, right: 10, top: 12),
      padding: padding,
      child: child
    );
  }
}