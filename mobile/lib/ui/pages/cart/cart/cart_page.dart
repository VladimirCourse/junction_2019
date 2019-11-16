import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'cart_page_bloc.dart';

import '../../order/order/order_page.dart';


import '../../../widgets/containers/place/place_header_container.dart';
import '../../../widgets/containers/cart/cart_container.dart';
import '../../../widgets/buttons/main_button.dart';

import '../../../widgets/dialogs/dish/dish_dialog.dart';

import '../../../resources/app_colors.dart';

import '../../../../models/place.dart';
import '../../../../models/order.dart';
import '../../../../models/dish.dart';

class CartPage extends StatefulWidget {
  
  final Place place;

  CartPage({this.place});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {

  final formKey = GlobalKey<FormState>();

  final textController =  TextEditingController();

  CartPageBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = CartPageBloc(widget.place);
    initializeDateFormatting();
  }

  void onBack() {
    Navigator.pop(context);
  }


  void onTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
    );
    if (time != null) {
      bloc.setTime(time);
    }
  }

  void onTakeOption(String option) {
    bloc.setTakeOption(option);
  }

  void onSuccess(Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderPage(order: order)),
    );
    bloc.clear();
  }

  void onMessage(String message) {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return MessageDialog(
    //       text: message,
    //       ok: 'ОК',
    //     );
    //   }
    // );
  }

  void onFinish() async  {
    if (formKey.currentState.validate()) {
      //Dialogs.show(context, LoadingDialog());
      final order = await bloc.createOrder(textController.text);
      //Dialogs.hide(context);
      if (order != null) {
        onSuccess(order);
      } else {
        onMessage('Try to create your order later!');
      }
    }
  }

  void onDish(Dish dish) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return DishDialog(
          place: widget.place,
          dish: dish,
        );
      }
    );
    //PageManager.update[Page.cart] = true;
    if (bloc.cart.dishes(widget.place).isEmpty) {
      Navigator.pop(context);
    } else {
      bloc.update();
    }
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

  Widget buildDishes() {
    return buildCard(
      Column(
        children: [
          PlaceHeaderContainer(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
            place: widget.place,
          ),
          StreamBuilder(
            stream: bloc.cartChange.stream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return CartContainer(
                onDish: onDish,
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                dishes: bloc.cart.dishes(widget.place),
              );
            }
          )
        ]
      )
    );
  }

  Widget buildPicker(String title, Function(BuildContext context) onTap) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: AppColors.main,
        accentColor: AppColors.main,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary 
        ),
      ),
      child: Builder(   
        builder: (context) {
          return InkWell(
            onTap: () => onTap(context),
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
      )
    );
  } 

  Widget buildCheck(String title, String current, String option) {
    return Row(
      children: <Widget>[
        Checkbox(
          activeColor: AppColors.main,
          value: current == option,
          onChanged: (value)=> onTakeOption(option)
        ),
        Padding(padding: EdgeInsets.only()),
        Text(title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget buildOptions() {
    return buildCard(
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('When to take?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StreamBuilder(
                  stream: bloc.date.stream,
                  builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
                    return buildPicker(
                      DateFormat('dd MMMM yyyy').format(snapshot.data ?? DateTime.now()),
                      (d){}
                    );
                  }
                ),
                StreamBuilder(
                  stream: bloc.date.stream,
                  builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
                    return buildPicker(
                      DateFormat('HH:mm').format(snapshot.data ?? DateTime.now()),
                      onTime
                    );
                  }
                )
              ],
            ),
            Divider(),
            StreamBuilder(
              stream: bloc.takeOption,
              builder:  (BuildContext context, AsyncSnapshot<String> snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildCheck('In place', snapshot.data, TakeOption.inPlace),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: buildCheck('With me', snapshot.data, TakeOption.withMe),
                    )
                  ],
                );
              }
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 10),
              child: Form(
                key: formKey,
                child: TextFormField(
                  maxLines: 1,
                  controller: textController,
                  //validator: (value) => Validators.empty(value, condition: bloc.takeOption.value == TakeOption.inPlace),
                  decoration: InputDecoration(
                    hintText: 'Table number',
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.9)
                    ),
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(      
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),   
                    ),
                    enabledBorder: OutlineInputBorder(      
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.25)),   
                    ),      
                  ),
                )
              )
            )
          ],
        )
      ),
      padding: EdgeInsets.all(15),
    );
  }

  Widget buildFinish() {
    return MainButton(
      onPressed: onFinish,
      title: 'CREATE ORDER',
      margin: EdgeInsets.all(10),
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
          buildFinish()
        ]
      )
    );
  }
}