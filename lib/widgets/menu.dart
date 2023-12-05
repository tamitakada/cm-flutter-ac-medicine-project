import 'package:flutter/material.dart';
import 'package:medicine/user.dart';

class Menu extends StatelessWidget {
  const Menu({super.key, required this.user});

  final UserStuff user;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(

      padding: const EdgeInsets.all(8.0),
      child: Container(

        height: height * 0.4,
        width: width * 0.46,

        decoration: BoxDecoration(

            border: Border.all(color: Colors.black),
            borderRadius:  BorderRadius.all(Radius.circular(20))
        ),

        child: Column(

          children: [

            Text("Information"),

            ListTile(

              leading: Icon(Icons.person),
              title: Text("First Name"),
              trailing: Text(user.firstName),
            ),

            ListTile(

              leading: Icon(Icons.person),
              title: Text("Last Name"),
              trailing: Text(user.lastName),
            ),

            ListTile(

              leading: Icon(Icons.e_mobiledata),
              title: Text("Age"),
              trailing: Text("${user.age}"),
            ),
          ],
        ),
      ),
    );
  }
}
