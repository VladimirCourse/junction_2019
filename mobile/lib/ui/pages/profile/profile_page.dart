import 'package:flutter/material.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:charts_flutter/flutter.dart' as c;

import '../settings/settings_page.dart';

import '../../resources/app_colors.dart';

import '../../widgets/cards/main_card.dart';
import '../../widgets/containers/image/image_container.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();

  }

  void onSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }


  Widget buildTitle(String title) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w300
        ),
      )
    );
  }

  Widget buildInk(String title) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w300,
            decoration: TextDecoration.underline
          ),
        )
      )
    );
  }

  Widget buildBackground(Widget child) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: width,
          height: height * 0.4,
          child: Arc(
            arcType: ArcType.CONVEX,
            height: height * 0.06,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                gradient: LinearGradient(
                  colors: AppColors.mainGradient
                )
              ),
            ),
          )
        ),
        child
      ]
    );
  }

  Widget buildHeader() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w700
            ),
          ),
          InkWell(
            onTap: onSettings,
            child: Icon(Icons.settings,
              color: Colors.white,
            ),
          )
        ],
      )
    );
  }

  Widget buildUser() {
    final width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Column(
          children: <Widget>[
            Container(
              width: width * 0.25,
              height: width * 0.25,
              child: ClipOval(
                child:  ImageContainer(
                  placeholderWidget: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.main.withOpacity(0.75))
                    ),
                    child: Icon(Icons.person,
                      size: 50,
                      color: AppColors.main.withOpacity(0.75)
                    ),
                  ),
                ),
              )
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
            Text( 'Username',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Text('7xxxxxxxx',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
          ],
        );
      },
    );
  }

  Widget buildUserStatistics() {
    final names = ['Places', 'Orders', 'Points'];
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        final stats = [0, 0, 0];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(stats.length, 
            (index) {
              return Expanded(
                child: Column(
                  children: <Widget>[
                    Text('${stats[index]}',
                      style: TextStyle(
                        color: AppColors.main,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 3)),
                    Text(names[index],
                      style: TextStyle(
                        fontSize: 15
                      ),
                    ),
                  ],
                )
              );
            }
          )
        );
      }
    );
  }

  Widget buildProfile() {
    final width = MediaQuery.of(context).size.width;
    return MainCard(
      padding: EdgeInsets.all(25),
      child: Container(
        width: width,
        child: Column(
          children: <Widget>[
            buildUser(),
            buildUserStatistics()
          ],
        )
      )
    );
  }

  Widget buildStatisticLabel(String title, Color color) {
    return Row(
      children: <Widget>[
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(title,
            style: TextStyle(
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTabs() {
    final statistics = ['Today', 'Week', 'Month', 'Year'];
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        final selected = snapshot.data ?? 0;
        return Container(
          height: 25,
          margin: EdgeInsets.only(top: 15, left: 17),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(statistics.length, 
              (index) {
                return InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.only(top: 4, bottom: 5, right: 9, left: 9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      gradient: LinearGradient(
                        colors: index == selected ? AppColors.mainGradient : [Colors.white, Colors.white]
                      )
                    ),
                    child: Text(statistics[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: index == selected ? Colors.white : Colors.black
                      ),
                    ),
                  )
                );
              }
            )
          )
        );
      },
    );
  }
  
  Widget buildPie() {
    final width = MediaQuery.of(context).size.width;
    final colors = {'spent' : AppColors.main, 'saved': AppColors.main.withOpacity(0.75)};
    final data = [
      {
        'data': 1.001,
        'type': 'spent'
      }, 
      {
        'data':  1,
        'type': 'saved'
      }
    ];
    return Row(
      children: [
        Container(
          width: width * 0.35,
          height: width * 0.35,
          child: c.PieChart(
            [
              c.Series( 
                id: '1',
                domainFn: (x, _) => x['data'],
                measureFn: (x, _) => x['data'],
                colorFn: (x, _) {
                  final color = colors[x['type']];
                  return c.Color(r:color.red, g: color.green, b: color.blue, a: color.alpha);
                },
                data: data
              )
            ],
            animationDuration: Duration(milliseconds: 700),
          )
        )
      ]
    );
  }

  Widget buildDishStatistics() {
    final width = MediaQuery.of(context).size.width;
    return MainCard(
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, left: 20),
              child: Text('Статистика',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            buildTabs(),
            StreamBuilder(
              builder: (BuildContext context, AsyncSnapshot<int> chartSnapshot) {
                return StreamBuilder(
                  builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
                    return Row(
                      children: [
                        buildPie(),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text('Total: 0',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              buildStatisticLabel('Spent: 0', AppColors.main),
                              Padding(padding: EdgeInsets.only(top: 7)),
                              buildStatisticLabel('Saved: 0', AppColors.main),
                            ],
                          )
                        )
                      ]
                    );
                  }
                );
              }
            )
          ]
        )
      )
    );
  }

  Widget buildPage() {
    return buildBackground(
      Container(
        margin: EdgeInsets.only(left: 5, right: 5, top: MediaQuery.of(context).padding.top + 15),
        child: Column(
          children: <Widget>[
            buildHeader(),
            buildProfile(),
            buildDishStatistics()
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: buildPage()
    );
  }
}