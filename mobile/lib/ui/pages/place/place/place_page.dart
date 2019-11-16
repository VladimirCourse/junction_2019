import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import 'place_page_bloc.dart';

import '../../cart/cart/cart_page.dart';

import '../../../widgets/containers/image/image_container.dart';
import '../../../widgets/containers/dish/big_dish_container.dart';
import '../../../widgets/dialogs/dish/dish_dialog.dart';
import '../../../widgets/buttons/main_button.dart';

import '../../../resources/app_colors.dart';

import '../../../../models/place.dart';
import '../../../../models/dish.dart';

class PlacePage extends StatefulWidget {
  final Place place;

  const PlacePage(this.place, {Key key}) : super(key: key);

  @override
  PlacePageState createState() => PlacePageState();
}

class PlacePageState extends State<PlacePage> with SingleTickerProviderStateMixin {

  final bloc = PlacePageBloc();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    //bloc.init(widget.place);
  }

  void onBack() {
    Navigator.pop(context);
  }

  void onFinish() {
    if (bloc.cart.dishes(widget.place).isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartPage(place: widget.place)),
      );
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
  }

  Widget buildHeaderIcons() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon:  Icon(Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: onBack,
          ),
          // IconButton(
          //   icon:  Icon(Icons.favorite_border,
          //     color: Colors.white,
          //   ),
          // )
        ],
      )
    );
  }

  Widget buildHeader() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 0.3,
      child: Stack(
        children: [
          ImageContainer(
            id: widget.place.imageId,
          ),
          Container(
            width: width,
            height: height * 0.3,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5)
            ),
          ),
          Container(
            height: height * 0.3,
            //padding: EdgeInsets.all(20),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildHeaderIcons(),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(widget.place.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(widget.place.address,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    )
                  )
                )
              ],
            ),
          )
        ]
      )
    );
  }

  Widget buildInfoText(IconData icon, String text) {
    if (text != null) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Icon(icon,
              color: Colors.grey.withOpacity(0.6),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Flexible(
              child: Text(text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14
                ),
              )
            )
          ],
        )
      );
    } else {
      return Container();
    }
  }

  Widget buildDescription() {
    if (widget.place.description != null) {
      return Container(
        margin: EdgeInsets.only(top: 15),
        child: Text(widget.place.description,
          style: TextStyle(
            fontSize: 14
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildLoader() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation(AppColors.main)
      ),
    ); 
  }

  Widget buildMenu() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final categories = Map<String, List<Dish>>();
    for (final dish in widget.place.dishes) {
      if (!categories.containsKey(dish.categories.first)) {
        categories[dish.categories.first] = [];
      }
      categories[dish.categories.first].add(dish);
    }
    final keys = categories.keys.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(keys.length,
        (index) {
          final key = keys[index];
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Text(keys[index],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                    ),
                  ),
                ),
                Container(
                  height: height * 0.2,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(categories[key].length,
                      (index) {
                        return InkWell(
                          onTap: () {
                            onDish(categories[key][index]);
                          },
                          child: Container(
                            width: width * 0.5,
                            child: BigDishContainer(
                              margin: EdgeInsets.only(left: 10, right: 5),
                              dish: categories[key][index]
                            )
                          )
                        );
                      }
                    )
                  ),
                )
              ],
            ),
          );
        }
      )
    );
  }

  Widget buildFinish() {
    return MainButton(
      title: 'NEXT',
      margin: EdgeInsets.all(10),
      onPressed: onFinish,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: <Widget>[
              buildHeader(),
              buildMenu(), 
            ],
          ),
          buildFinish() 
        ]
      )
    );
  }
}