import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//import '../../../pages/place/place/place_page.dart';

// import '../../../widgets/containers/rating/rating_container.dart';
// import '../../../widgets/containers/distance/distance_container.dart';
// import '../../../widgets/containers/open/open_container.dart';
import '../../../widgets/containers/image/image_container.dart';

import '../../../resources/app_colors.dart';

//import '../../../util/formatter.dart';

import '../../../../models/dish.dart';

class BigDishContainer extends StatelessWidget {

  final Dish dish;
  final EdgeInsets margin;

  BigDishContainer({this.dish, this.margin});

  void onTap(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => PlacePage(place)),
    // );
  }

  Widget buildImage() {
    return ImageContainer(
      id: dish.imageId,
      borderRadius: BorderRadius.all(Radius.circular(10)),
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
          // RatingContainer(
          //   rating: place.rating,
          // ),
          // DistanceContainer(
          //   place: place,
          // )
        ]
      ),
    );
  }

  Widget buildName() {
    return Flexible(
      child: Container(
        child: Text(dish.name,
          maxLines: 2,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: () => onTap(context),
      child: Container(
        margin: margin,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.0),
              blurRadius: 3,
              spreadRadius: 0.5,
              offset: Offset(0.0, 1.0,),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              margin: EdgeInsets.only(top: 5, right: 2, left: 2),
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
                ]
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 3, right: 2, left: 2),
                      child: Row(
                        children: <Widget>[
                          // Text('${dish.proteins}',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     color: Colors.blueAccent
                          //   ),
                          // ),
                          // Text('/',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     color: Colors.black
                          //   ),
                          // ),
                          // Text('${dish.fats}',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     color: Colors.green
                          //   ),
                          // ),
                          // Text('/',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     color: Colors.black
                          //   ),
                          // ),
                          // Text('${dish.carbohydrates}',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     color: Colors.orange
                          //   ),
                          // ),
                    
                        ],
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5, right: 2, left: 3),
                      child: Text('${dish.calories} kcal',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black
                        ),
                      )
                    )
                  ]
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5, right: 2, left: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${dish.price.toStringAsFixed(2)}€',
                        style: TextStyle(
                          fontSize: dish.price != dish.salePrice ? 13 : 16,
                          color: Colors.black,
                          decoration: dish.price != dish.salePrice ? TextDecoration.lineThrough : TextDecoration.none
                        ),
                      ),
                      dish.price != dish.salePrice ? 
                      Text(' ${dish.salePrice.toStringAsFixed(2)}€',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red
                        ),
                      ) : 
                      Container()
                    ]
                  )
                )
              ]
            )
          ],
        ),
      )
    );
  }
}