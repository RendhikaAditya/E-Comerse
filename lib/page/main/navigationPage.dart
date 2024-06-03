import 'package:ecomerse/page/main/homePage.dart';
import 'package:ecomerse/page/main/myFavoritePage.dart';
import 'package:ecomerse/page/main/myOrderPage.dart';
import 'package:ecomerse/page/main/profilePage.dart';
import 'package:flutter/material.dart';

class PageBottomBar extends StatefulWidget {
  const PageBottomBar({Key? key}) : super(key: key);

  @override
  State<PageBottomBar> createState() => _PageBottomBarState();
}

class _PageBottomBarState extends State<PageBottomBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const[
          HomePage(),
          MyFavoritePage(),
          MyOrderPage(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          labelColor: Colors.blue,
          indicator: BoxDecoration(),
          indicatorColor: Colors.grey[100],
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          tabs: const [
            Tab(
              text: "Home",
              icon: Icon(Icons.home_outlined),
            ),
            Tab(
              text: "Favorite",
              icon: Icon(Icons.favorite_border),
            ),
            Tab(
              text: "My Order",
              icon: Icon(Icons.local_shipping_outlined),
            ),
            Tab(
              text: "Profile",
              icon: Icon(Icons.person_outline),
            ),
          ],
        ),
      ),
    );
  }
}
