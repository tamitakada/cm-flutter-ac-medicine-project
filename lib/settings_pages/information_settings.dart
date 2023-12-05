import 'package:flutter/material.dart';

class InformationSetting extends StatefulWidget {
  const InformationSetting({super.key});

  @override
  State<InformationSetting> createState() => _InformationSettingState();
}

class _InformationSettingState extends State<InformationSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(

        children: [

          Text("Information",
            style: TextStyle(fontSize: 10),
          ),

          ListView(

            children: [

              ListTile(title: Text("Version: 1.0.0")),
              ListTile(title: Text("Insert later")),

            ],

          ),
        ],
      ),
    );
  }
}
