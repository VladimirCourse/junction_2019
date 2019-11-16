import 'package:flutter/material.dart';

import 'package:mobile/ui/widgets/containers/dish/big_dish_container.dart';

import 'feed_page_bloc.dart';

import '../../resources/app_colors.dart';

import '../../../models/recommendation.dart';
import '../../../models/settings.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key key}) : super(key: key);

  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> with SingleTickerProviderStateMixin {

  final bloc = FeedPageBloc();

  final searchController = TextEditingController();

  final icons = {
    'restaurant': Icons.restaurant,
    'shop': Icons.shop
  };

  @override
  void initState() {
    super.initState();

    bloc.init();
  }

  void onChange(int index, bool value) {
    bloc.change(index, value);
  }

  Widget buildAppBar() {
    return null;
  }

  Widget buildHeader() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // Image(
        //   width: width,
        //   height: height * 0.25,
        //   fit: BoxFit.cover,
        //   image: AssetImage(
        //     'assets/images/feed.jpg'
        //   )
        // ),
        Container(
          width: width,
          height: height * 0.2 + MediaQuery.of(context).padding.top,
          //color: Colors.black.withOpacity(0.5),\
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.mainGradient
            )
          ),
        ),
        Container(
          width: width,
          height: height * 0.2,
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: StreamBuilder(
            stream: bloc.chaanged.stream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              int kcal = 0;
              int count = 0;
              if (bloc.recomenndations.hasValue) {
                for (int i = 0; i < bloc.recomenndations.value.length; i++) {
                  if (bloc.status.status(i)) {
                    count++;
                    for (final dish in bloc.recomenndations.value[i].places.first.dishes) {
                      kcal += dish.calories;
                    }
                  }
                }
              }
              double maxKcal  = 2700;
              final settings = Settings();
              //magic equation
              if (settings.gender.isNotEmpty && settings.gender.first == 'Female') {
                maxKcal = 1.25 * (10 * settings.weight + 6.25 * settings.height - 5 * settings.age - 161);
              } else {
                maxKcal = 1.25 * (10 * settings.weight + 6.25 * settings.height - 5 * settings.age + 5);
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('${kcal} ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32
                          )
                        ),
                        Text('/ ${maxKcal.toInt()} kcal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32
                          )
                        )
                      ],
                    )
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Divider(color: Colors.white, height: 25),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('$count ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17
                          )
                        ),
                        Text('/ 5 eatings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17
                          )
                        )
                      ],
                    )
                  ),
                ],
              );
            }
          )
        )
      ]
    );
  }

  Widget buildRecommendations() {
    return StreamBuilder(
      stream: bloc.recomenndations.stream,
      builder: (BuildContext context, AsyncSnapshot<List<Recommendations>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 5),
            child: Column(
              children: List.generate(data.length,
                (index) {
                  final recommend = data[index];
                  final place = recommend.places.first;
                  final calories = place.dishes.map((p) => p.calories).reduce((p1, p2) => p1 + p2);
                  final price = place.dishes.map((p) => p.price).reduce((p1, p2) => p1 + p2);
                  final salePrice = place.dishes.map((p) => p.salePrice).reduce((p1, p2) => p1 + p2);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(icons[place.place.category],
                                  color: AppColors.main,
                                  size: 16,
                                ),
                                Padding(padding: EdgeInsets.only(left: 5)),
                                Text(place.place.name,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400
                                  ),
                                )
                              ]
                            ),
                            Container(
                              child: StreamBuilder(
                                stream: bloc.chaanged.stream,
                                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                  return Checkbox(
                                    activeColor: AppColors.main,
                                    value: bloc.status.status(index),
                                    onChanged: (value) {
                                      onChange(index, value);
                                    },
                                  );
                                }
                              )
                   )
            ]
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.4,
                        margin: EdgeInsets.only(top: 5),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(place.dishes.length, 
                            (index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: BigDishContainer(
                                  margin: EdgeInsets.only(left: 15),
                                  dish: place.dishes[index],
                                ),
                              );
                            }
                          )
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                      //    child: Text('Total',
                      //     style: TextStyle(
                      //       fontSize: 16
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text('$calories kcal',
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
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
                            )
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Divider(),
                    ],
                  );
                }
              )
            ),
          );
        } else {
          return Container();
        }
      }
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        buildHeader(),
        buildRecommendations()
      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: buildBody(),
      )
    );
  }
}

  