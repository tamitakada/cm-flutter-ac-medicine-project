import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';
import 'database.dart';
import 'widgets/menu.dart';

//https://open.fda.gov/apis/
//https://api.fda.gov/drug/label.json?search=openfda.generic_name:”ibuprofen”&limit=1

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Widget MedID(double height){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

        height: height * 0.3,

        decoration: BoxDecoration(

          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    //MediaQuery.of(context).size.height or width;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<UserStuff>(
        future: Database.getUser(FirebaseAuth.instance.currentUser?.email ?? "Default Value"), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<UserStuff> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            return Container(

              child: Column(

                children: [

                  MedID(height),

                  Row(
                    children: [

                      Menu(user: snapshot.data!),
                    ],
                  ),

                  SizedBox(

                    width: width * 0.9,
                    height: height * 0.1,

                    child: OutlinedButton(

                      onPressed: null,
                      child: ListTile(

                        title: Text("Conflicts", style: TextStyle(color: Colors.black),),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),

                      style: OutlinedButton.styleFrom(

                        side: BorderSide(

                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
