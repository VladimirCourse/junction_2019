import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'main_page_bloc.dart';

import '../feed/feed_page.dart';
import '../profile/profile_page.dart';
import '../place/list/place_list_page.dart';
import '../cart/list/cart_list_page.dart';
import '../order/list/order_list_page.dart';

// import '../cart/list/cart_list_page.dart';
// import '../place/list/place_list_page.dart';
// import '../order/list/order_list_page.dart';
// import '../user/profile/profile/profile_page.dart';
// import '../special/list/special_list_page.dart';

// import '../../widgets/containers/distance/distance_container.dart';
// import '../../widgets/containers/dish/dish_container.dart';
// import '../../widgets/containers/cart/cart_container.dart';
// import '../../widgets/buttons/count/count_buttons.dart';
// import '../../widgets/buttons/main_button.dart';

// import '../../widgets/animated/header/animated_header.dart';

// import '../../util/page_manager.dart';

import '../../resources/app_colors.dart';

// import '../../../models/api/place.dart';
// import '../../../models/api/dish.dart';

class MainPage extends StatefulWidget {
  
  MainPage();

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  final bloc = MainPageBloc();

  final pageController = PageController(initialPage: 2);

  @override
  void initState() {
    super.initState();
    
    bloc.update();
  }

  void onPage(int index) {
    bloc.setPage(index);
    pageController.jumpToPage(index);
    bloc.update();
  }

  BottomNavigationBarItem buildIcon(String title, IconData icon, {Stream<bool> stream}) {
    return BottomNavigationBarItem(
      icon: Container(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Icon(icon),
            StreamBuilder(
              stream: stream,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: snapshot.hasData && snapshot.data ? Colors.red : Colors.transparent,
                    shape: BoxShape.circle
                  )
                );
              }
            )
          ]
        )
      ),
      title: Text(title)
    );
  }
  
  @override
  Widget build(BuildContext context) {
    bloc.update();
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          OrderListPage(),
          CartListPage(primary: true),
          PlaceListPage(),
          FeedPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: StreamBuilder( 
        stream: bloc.page.stream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return BottomNavigationBar(
            onTap: onPage,
            currentIndex: snapshot.data ?? 2,
            showUnselectedLabels: true,
            fixedColor: AppColors.main,
            unselectedItemColor: Colors.grey.withOpacity(0.6),
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              fontSize: 12
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.grey.withOpacity(0.7)
            ),
            items: [
              buildIcon('Orders', Icons.label, stream: bloc.ordersNotify),
              buildIcon('Cart', Icons.shopping_cart, stream: bloc.cartNotify),
              buildIcon('Restaurants', Icons.restaurant),
              buildIcon('Health', Icons.favorite),
              buildIcon('Profile', Icons.person),
            ]
          );
        }
      )
    );
  }
}