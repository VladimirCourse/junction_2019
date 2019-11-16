import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'order_list_page_bloc.dart';
import '../order/order_page.dart';

import '../../../widgets/containers/place/place_header_container.dart';
import '../../../widgets/containers/cart/cart_container.dart';
import '../../../widgets/cards/main_card.dart';

import '../../../resources/app_colors.dart';

import '../../../../models/place.dart';
import '../../../../models/dish.dart';
import '../../../../models/order.dart';

class OrderListPage extends StatefulWidget {
  final bool primary;
  OrderListPage({this.primary = false});

  @override
  OrderListPageState createState() => OrderListPageState();
}

class OrderListPageState extends State<OrderListPage> with SingleTickerProviderStateMixin {

  final bloc = OrderListPageBloc();
  
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    bloc.init();
  }

  void onBack() {
    Navigator.pop(context);
  }

  Future onRefresh() async {
  }

  void onOrder(Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderPage(order: order)),
    );
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
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text('Orders',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: <Widget>[
        ],
      )
    );
  }

  Widget buildRow(Icon icon, String title1, String title2, String title3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon,
        Padding(padding: EdgeInsets.only(left: 3)),
        Text(title1,
          style: TextStyle(
            color: Colors.grey
          ),
        ),
        Text(' $title2 ',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.main
          ),
        ),
        Text(title3,
          style: TextStyle(
            color: Colors.grey
          ),
        )
      ],
    );
  }

  Widget buildTimer(Order order) {
    final current = DateTime.now();
    if (order.serveAt.isAfter(current)) {
      return Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            buildRow(
              Icon(Icons.timer,
                color: AppColors.main,
                size: 17,
              ), 'Order', order.id.substring(0, 8), 'will be ready'
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(duration(order.serveAt.difference(current)),
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
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: buildRow(
          Icon(
            Icons.check,
            color: AppColors.main,
            size: 20,
          ), 'Order', order.id.substring(0, 8), 'ready'
        ),
      );
    }
  }

  Widget buildEmpty() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Text('No orders',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16
          ),
        ),
      )
    ); 
  }

  Widget buildLoader() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation(AppColors.main)
      ),
    ); 
  }


  Widget buildOrders(List<Order> orders) {
    return Container(
      child: ListView(
        children: List.generate(orders.length,
          (index) {
            final order = orders[index];
            return InkWell(
              onTap: ()=> onOrder(order),
              child: MainCard(
                child: Column(
                  children: [
                    PlaceHeaderContainer(
                      padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
                      place: order.place,
                      child:Container(
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
                      tapped: false,
                    ),
                    CartContainer(
                      total: false,
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      dishes: Map.fromIterable(order.orderDishes, key: (o) => o, value: (o) => o.count),
                    ),
                    buildTimer(order)
                    // OrderContainer(
                    //   order: order,
                    //   //dishes: Map.fromIterable(order.dishes, key: (o) => o.dish, value: (o) => o.count),
                    // ),
                  ]
                )
              )
            );
          }
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: RefreshIndicator(
        color: AppColors.main,
        onRefresh: onRefresh,
        child: StreamBuilder(
          stream: bloc.orders.stream,
          builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                return buildOrders(snapshot.data);
              } else {
                return buildEmpty();
              }
            } else {
              return buildLoader();
            }
          }
        )
      )
    );
  }
}