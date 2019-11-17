import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../../../widgets/containers/place/place_header_container.dart';
import '../../../widgets/containers/cart/cart_container.dart';
import '../../../widgets/buttons/main_button.dart';

import '../../../resources/app_colors.dart';

import '../../../../models/place.dart';
import '../../../../models/dish.dart';
import '../../../../models/order.dart';

class OrderPage extends StatefulWidget {
  
  final Order order;

  OrderPage({this.order});

  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
  }

  void onBack() {
    Navigator.pop(context);
  }

  static String duration(Duration duration){
    final days = duration.inDays;
    final hours = (duration.inSeconds - days * Duration.secondsPerDay) ~/ Duration.secondsPerHour; 
    final minutes = (duration.inSeconds - days * Duration.secondsPerDay - hours * Duration.secondsPerHour) ~/ Duration.minutesPerHour;
    
    return '${days > 0 ? '$days days ' : ''}$hours h $minutes min';
  }

  Widget buildAppBar() {
    return PreferredSize(
      preferredSize: Size(50, 50),
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: onBack,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text('Order',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: <Widget>[
        ],
      )
    );
  }

  Widget buildCard(Widget child, {BorderRadius borderRadius, EdgeInsets padding}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 15),
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.075),
            blurRadius: 3,
            spreadRadius: 0.5,
            offset: Offset(0.0, 1.0),
          )
        ],
      ),
      child: child
    );
  }

  Widget buildTimer() {
    final current = DateTime.now();
    if (widget.order.serveAt.isAfter(current)) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text('Ready in',
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 7),
              child: Text(duration(widget.order.serveAt.difference(current)),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.main
                ),
              )
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.check,
              color: AppColors.main,
              size: 20,
            ),
            Padding(padding: EdgeInsets.only(left: 3)),
            Text('Ready',
              style: TextStyle(
                color: Colors.grey
              ),
            ),
          ],
        )
      );
    }
  }

  Widget buildText() {
    return Text('Order ${widget.order.id.substring(0, 8)}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.main
      ),
    );
  }

  Widget buildDate() {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(DateFormat('dd.MM.yyyy, HH:mm').format(widget.order.serveAt.toLocal()),
        style: TextStyle(
          color: Colors.grey
        ),
      )
    );
  }

  Widget buildStatus() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildText(),
                buildTimer()
              ]
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 3, top: 3, left: 7, right: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: AppColors.mainGradient,
                    )
                  ),
                  child: Text('Purchased',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
                buildDate(),
              ]
            )
          ]
        )
      )
    );
  }

  Widget buildDishes() {
    return buildCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStatus(),
          Divider(),
          PlaceHeaderContainer(
            padding: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
            place: widget.order.place,
          ),
          CartContainer(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            dishes: Map.fromIterable(widget.order.orderDishes, key: (o) => o, value: (o) => o.count),
          )
        ]
      )
    );
  }

  Widget buildPicker(String title, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 15),
        child: Text(title,
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 16,
            fontWeight: FontWeight.w400
          ),
        )
      ),
    );
  } 

  Widget buildOptions() {
    return buildCard(
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Order served ',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                Text(widget.order.takeOption == TakeOption.inPlace ? 'with me' : 'in place',
                  style: TextStyle(
                    color: AppColors.main
                  ),
                )
              ],
            ),
            widget.order.table != null && widget.order.table.isNotEmpty ?
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text('Table number: ${widget.order.table}',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ) : 
            Container(),
          ],
        ),
      ),
      padding: EdgeInsets.all(15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildDishes(),
                  //buildSplit(),
                  buildOptions()
                ],
              ),
            )
          ),
        ]
      )
    );
  }
}