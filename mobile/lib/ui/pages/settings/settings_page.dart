import 'dart:math';

import 'package:flutter/material.dart';

import 'settings_page_bloc.dart';

import '../../resources/app_colors.dart';


import '../../widgets/buttons/main_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  final bloc = SettingsPageBloc();

  final restrictions = [
    'Vegan',
    'Vegetarian',
    'No sugar',
    'Gluten-Free',
    'Kosher',
    'Halal'
  ];

  final gender = [
    'Male',
    'Female'
  ];

  @override
  void initState() {
    super.initState();
  }

  void onBack() {
    Navigator.pop(context);
  }

  void onChange(Set<String> values, String category) {
    if (values.contains(category)) {
      values.remove(category);
    } else {
      values.add(category);
    }
    bloc.notify();
  }

  void onRestriction(String restriction) {
    onChange(bloc.settings.restrictions, restriction);
  }

  void onGender(String gender) {
    bloc.settings.gender.clear();
    bloc.settings.gender.add(gender);
    bloc.notify();
  }

  void onAge(double age) {
    bloc.settings.age = age.toInt();
    bloc.notify();
  }

  void onHeight(double h) {
    bloc.settings.height = h.toInt();
    bloc.notify();
  }

  void onWeight(double weight) {
    bloc.settings.weight = weight.toInt();
    bloc.notify();
  }

  void onApply() {
    //bloc.apply();
    Navigator.pop(context);
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
        title: Text('Settings',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: <Widget>[

        ],
      )
    );
  }

  Widget buildTitle(String title) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15, bottom: 10),
      child: Text(title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500
        )
      ),
    );
  }

  Widget buildCheck(String title, bool value, Function(bool) onTap) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(title,
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
          Checkbox(
            value: value,
            activeColor: AppColors.main,
            onChanged: onTap
          )
        ],
      )
    );
  }

  Widget buildSlider(String title, double min, double max, int value, Function(double) onChange) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text('$title: ${value}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),
              ),
            ),
            Container(
              child: SliderTheme(
                data: SliderThemeData(),
                child: Slider(
                  min: min,
                  max: max,
                  activeColor: AppColors.main,
                  inactiveColor: Colors.grey.withOpacity(0.75),
                  value: value.toDouble(),
                  onChanged: onChange,
                )
              )
            )
          ]
        );
      }
    );
  }

  Widget buildChecks(String title, List<String> values, Set<String> selected, Function(String) onTap) {
    return StreamBuilder(
      stream: bloc.changed.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
         return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildTitle(title),
            Column(
              children: List.generate(values.length, 
                (index) {
                  final object = values[index];
                  return buildCheck(object, selected.contains(object), (t)=> onTap(object));
                }
              )
            )
          ],
        );
      },
    );
  }

  Widget buildDivider() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Divider(),
    );
  }

  Widget buildPage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 15)),
                buildSlider('Age', 14, 120, bloc.settings.age, onAge),
                buildSlider('Weight', 40, 150, bloc.settings.weight, onWeight),
                buildSlider('Height', 120, 250, bloc.settings.height, onHeight),
                buildChecks('Gender', gender, bloc.settings.gender, onGender),
                buildChecks('Food restriction', restrictions, bloc.settings.restrictions, onRestriction),
              ],
            )
          )
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: MainButton(
            title: 'APPLY',
            onPressed: onApply,
          )
        )
      ]
    );
  }

  Widget buildLoader() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation(AppColors.main)
      ),
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: StreamBuilder(
        stream: bloc.changed.stream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return buildPage();
        }
      )
    );
  }
}