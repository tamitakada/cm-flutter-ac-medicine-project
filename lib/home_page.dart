import 'package:flutter/material.dart';
import 'api_stuff.dart';
import 'medicine_listing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? medicine;

  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: Container(

        child: Column(

          children: [

            TextField(



              onSubmitted: (change){

                setState((){

                  medicine = change;
                });
              },
            ),

            FutureBuilder<List<MedicineListing>?>(
              future: apiStuff.find(medicine ?? ""), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<List<MedicineListing>?> snapshot) {
                List<Widget> children;

                //if statement for null

                if(snapshot.hasData){

                  return Expanded(
                    child: ListView.builder(


                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index){

                          return Container(

                            color: Colors.white60,
                            child: Text(snapshot.data?[index].brandName ?? "default value"),
                          );
                        }

                    ),
                  ) ;

                }else {
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

                  ),
                );
              },
            ),


            Text(

              "Reminders:" ,

              style: TextStyle(fontSize: 40),
            ),

            Expanded(
              child: ListView(

                children: [

                  ListTile(

                    title: Text("Medicine1"),
                  ),

                  ListTile(

                    title: Text("Medicine2"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
