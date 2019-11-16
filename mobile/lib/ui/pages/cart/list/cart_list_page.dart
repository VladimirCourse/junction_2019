import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'cart_list_page_bloc.dart';

import '../cart/cart_page.dart';

import '../../../widgets/containers/place/place_header_container.dart';
import '../../../widgets/containers/cart/cart_container.dart';
import '../../../widgets/buttons/main_button.dart';
import '../../../widgets/cards/main_card.dart';
//import '../../../widgets/dialogs/accept/accept_dialog.dart';

//import '../../../util/page_manager.dart';

import '../../../resources/app_colors.dart';

import '../../../../models/place.dart';
import '../../../../models/dish.dart';

class CartListPage extends StatefulWidget {
  final bool primary;
  CartListPage({this.primary = false});

  @override
  CartListPageState createState() => CartListPageState();
}

class CartListPageState extends State<CartListPage> with SingleTickerProviderStateMixin {

  final bloc = CartListPageBloc();

  @override
  void initState() {
    super.initState();
  }

  void onBack() {
    Navigator.pop(context);
  }

  void onCart(Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(place: place)),
    );
  }

  void onClearAll() {
    bloc.clearAll();
  }

  void onClearPlace(Place place) {
    bloc.clearPlace(place);
  }

  Widget buildAppBar() {
    return PreferredSize(
      preferredSize: Size(50, 50),
      child: AppBar(
        leading: !widget.primary ? 
        IconButton(
          icon: Icon(Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: onBack,
        ) : 
        null,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text('Cart',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: onClearAll,
            icon: Icon(Icons.delete,
              color: AppColors.main,
            ),
          )
        ],
      )
    );
  }

  Widget buildDishes() {
    return StreamBuilder(
      stream: bloc.change.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) { 
        final restaurants = bloc.cart.restaurants();
        if (restaurants.isNotEmpty) {
          return ListView(
            children: List.generate(restaurants.length,
              (index) {
                final place = restaurants.elementAt(index);
                return InkWell(
                  onTap: () => onCart(place),
                  child: MainCard(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: PlaceHeaderContainer(
                                padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
                                place: place,
                                tapped: false,
                              )
                            ),
                            IconButton(
                              onPressed: () => onClearPlace(place),
                              icon: Icon(
                                Icons.close
                              ),
                            )
                          ]
                        ),
                        CartContainer(
                          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          dishes: bloc.cart.dishes(place),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text('FINISH',
                            style: TextStyle(
                              color: AppColors.main,
                              fontSize: 15
                            ),
                          ),
                        )
                      ]
                    )
                  )
                );
              }
            )
          );
        } else {
          return Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text('Cart is empty',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                ),
              ),
            )
          ); 
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (PageManager.update[Page.cart]) {
    //   PageManager.update[Page.cart] = false;
    //   bloc.update();
    // }
    return Scaffold(
      appBar: buildAppBar(),
      body: buildDishes()
    );
  }
}