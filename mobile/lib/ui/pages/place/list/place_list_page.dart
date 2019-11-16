import 'package:flutter/material.dart';

import 'place_list_page_bloc.dart';

// import '../filters/filters_page.dart';

import '../../../resources/app_colors.dart';

// import '../../../util/markers.dart';

import '../../../widgets/containers/place/big_place_container.dart';

import '../../../../models/place.dart';

class PlaceListPage extends StatefulWidget {
  const PlaceListPage({Key key}) : super(key: key);

  @override
  PlaceListPageState createState() => PlaceListPageState();
}

class PlaceListPageState extends State<PlaceListPage> with SingleTickerProviderStateMixin {

  final bloc = PlaceListPageBloc();

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    bloc.init();
  }

  Widget buildAppBar() {
    return PreferredSize(
      preferredSize: Size(50, 50),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text('Places',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: <Widget>[
          
        ],
      )
    );
  }

  Widget buildList(List<Place> restaurants) {
    if (restaurants.isNotEmpty) {
      return ListView(
        children: List.generate(restaurants.length, 
          (index) {
            return BigPlaceContainer(
              place: restaurants[index],
              margin: EdgeInsets.only(left: 10, right: 10, top: 12),
            );
          } 
        )
      );
    } else {
      return Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Text('Не найдено',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16
            ),
          ),
        )
      ); 
    }
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
      body: StreamBuilder(
        stream: bloc.places.stream,
        builder: (BuildContext context, AsyncSnapshot<List<Place>> restaurantsSnapshot) {
          if (restaurantsSnapshot.hasData) {
            return buildList(restaurantsSnapshot.data);
          } else {
            return buildLoader();
          }
        }
      )
    );
  }
}