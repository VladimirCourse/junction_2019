import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../pages/place/place/place_page.dart';

import '../../../resources/app_colors.dart';

//import '../../../util/formatter.dart';

import '../../../../models/place.dart';

class PlaceHeaderContainer extends StatelessWidget {

  final Place place;
  final EdgeInsets padding;
  final Widget child;
  final bool tapped;

  PlaceHeaderContainer({this.place, this.padding, this.child, this.tapped = true});

  void onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlacePage(place)),
    );
  }

  Widget buildName() {
    return Flexible(
      child: Text(place.name,
        maxLines: 2,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600
        ),
      )
    );
  }

  Widget buildAddress() {
    if (place.address != null) {
      return Container(
        margin: EdgeInsets.only(top: 7),
        child: Text(place.address,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapped ? () => onTap(context) : null,
      child: Container(
        padding: padding ?? EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildName(),
                child ?? Container()
              ]
            ),
            buildAddress(),
          ]
        ),
      )
    );
  }
}