import 'package:flutter/material.dart';
import 'details_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {

  int selectedIndex = 0;
  static List<Widget>? widgetoption;

  @override
  void initState() {

    widgetoption = [

      HomePage(),
      ProfilePage(),
      DetailsPage(),
    ];
  }

  void onItemTap(int index){

    setState(() {

      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: widgetoption!.elementAt(selectedIndex),

      bottomNavigationBar: BottomNavigationBar(

        items: <BottomNavigationBarItem>[

          BottomNavigationBarItem(

            icon: Icon(Icons.house),
            label: "Home",
          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.person),
            label: "Profile",
          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.lightBlueAccent,

        onTap: onItemTap,

      ),
    );
  }
}
