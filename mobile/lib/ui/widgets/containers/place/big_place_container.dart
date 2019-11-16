import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../pages/place/place/place_page.dart';

// import '../../../widgets/containers/rating/rating_container.dart';
// import '../../../widgets/containers/distance/distance_container.dart';
// import '../../../widgets/containers/open/open_container.dart';
import '../../../widgets/containers/image/image_container.dart';

import '../../../resources/app_colors.dart';

//import '../../../util/formatter.dart';

import '../../../../models/place.dart';


class BigPlaceContainer extends StatelessWidget {

  final Place place;
  final EdgeInsets margin;

  BigPlaceContainer({this.place, this.margin});

  void onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlacePage(place)),
    );
  }

   String distance(int distance){
    if (distance < 1000){
      return '${distance} m';
    }else{
      return '${distance ~/ 1000} km ${distance % 1000} m';
    }
  }


  Widget buildImage() {
    return ImageContainer(
      id: place.imageId,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    );
  }

  Widget buildTop() {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(0.1),
            Colors.transparent,
            Colors.transparent
          ]
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
           Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 2),
                child:  Icon(Icons.star,
                  color: Colors.white,
                  size: 18
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 3)),
              Text('${place.score}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              )
            ]
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 2),
                child: Transform.rotate(
                  angle: 0.7,
                  child: Icon(Icons.navigation,
                    color: Colors.white,
                    size: 18
                  ),
                )
              ),
              Padding(padding: EdgeInsets.only(left: 3)),
              Text(distance(place.distance),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              )
            ]
          )
        ]
      ),
    );
  }

  Widget buildName() {
    return Flexible(
      child: Container(
        child: Text(place.name,
          maxLines: 2,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600
          ),
        ),
      )
    );
  }


  Widget buildAddress() {
    if (place.address != null) {
      return Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(place.address,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  // Widget buildAveragePrice() {
  //   if (place.averagePrice != null) { 
  //     return Container(
  //       margin: EdgeInsets.only(top: 7),
  //       child: Row(
  //         children: [ 
  //           Text('${Translation.current.averageCheck}: ',
  //             style: TextStyle(
  //               fontSize: 14,
  //               color: Colors.black
  //             ),
  //           ),
  //           Text(Formatter.price(place.averagePrice, place.currency),
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w500,
  //               color: AppColors.lightGreen
  //             ),
  //           ),
  //         ]
  //       )
  //     );
  //   } else {
  //     return Container();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        margin: margin,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.01),
              blurRadius: 3,
              spreadRadius: 0.5,
              offset: Offset(0.0, 1.0,),
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  buildImage(),
                  buildTop()
                ]
              )
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      buildName(),
                    ],
                  ),
                  buildAddress(),
                  //buildAveragePrice()
                ]
              )
            )
          ],
        ),
      )
    );
  }
}