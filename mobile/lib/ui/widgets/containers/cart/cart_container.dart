import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../resources/app_colors.dart';

import '../../../../models/dish.dart';
import '../../../../models/place.dart';

class CartContainer extends StatelessWidget {

  final bool total;
  final EdgeInsets padding;
  final Map<Dish, int> dishes;
  final Function(Dish) onDish;

  CartContainer({this.padding, this.dishes, this.onDish, this.total = true});

  Widget buildDishes() {
    return Column(
      children: List.generate(dishes.length, 
        (index) { 
          final dish = dishes.keys.elementAt(index);
          final count = dishes[dish];
          return InkWell(
            onTap: () {
              if (onDish != null) {
                onDish(dish);
              }
            },
            child: Container(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(count.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: Text('x',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          )
                        ),
                        Flexible(
                          child: Text(dish.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          )
                        ),
                        Padding(padding: EdgeInsets.only(right: 15))
                      ]
                    ),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${dish.price * count}€',
                          style: TextStyle(
                            fontSize: dish.price != dish.salePrice ? 13 : 16,
                            color: Colors.black,
                            decoration: dish.price != dish.salePrice ? TextDecoration.lineThrough : TextDecoration.none
                          ),
                        ),
                        dish.price != dish.salePrice ? 
                        Text(' ${dish.salePrice * count}€',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red
                          ),
                        ) : 
                        Container()
                      ]
                    )
                  ),
                ],
              ),
            )
          );
        } 
      )
    );
  }

  Widget buildTotal() {
    final price = dishes.isNotEmpty ? dishes.keys.map((d) => d.price * dishes[d]).reduce((d1, d2) => d1 + d2) : 0;
    final calories = dishes.isNotEmpty ? dishes.keys.map((d) => d.calories * dishes[d]).reduce((d1, d2) => d1 + d2) : 0;
    final proteins = dishes.isNotEmpty ? dishes.keys.map((d) => d.proteins * dishes[d]).reduce((d1, d2) => d1 + d2) : 0;
    final carbohydrates = dishes.isNotEmpty ? dishes.keys.map((d) => d.carbohydrates * dishes[d]).reduce((d1, d2) => d1 + d2) : 0;
    final fats = dishes.isNotEmpty ? dishes.keys.map((d) => d.fats * dishes[d]).reduce((d1, d2) => d1 + d2) : 0;
    final salePrice = dishes.isNotEmpty ? dishes.keys.map((d) => d.salePrice * dishes[d]).reduce((d1, d2) => d1 + d2) : 0;

    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text('Proteins',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w400
                    ),
                  )
                ),
                Text('$proteins',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w400
                  ),
                )
              ]
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text('Carbohydrates',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w400
                    ),
                  )
                ),
                Text('$carbohydrates',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w400
                  ),
                )
              ]
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text('Fats',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w400
                    ),
                  )
                ),
                Text('$fats',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w400
                  ),
                )
              ]
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text('Calories',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w400
                    ),
                  )
                ),
                Text('$calories kcal',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w400
                  ),
                )
              ]
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text('Total price',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                )
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${price}€',
                    style: TextStyle(
                      fontSize: price != salePrice ? 13 : 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      decoration: price != salePrice ? TextDecoration.lineThrough : TextDecoration.none
                    ),
                  ),
                  price != salePrice ? 
                  Text(' ${salePrice}€',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red
                    ),
                  ) : 
                  Container()
                ]
              )
            ]
          ),
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          Divider(),
          buildDishes(),
          Divider(),
          total ? 
          buildTotal() :
          Container(),
        ]
      ),
    );
  }
}