import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  bool darkModeOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SettingsList(
        sections: [SettingsSection(
          title: Text('Settings',
              style: TextStyle(

                fontSize: 30,
                color: Colors.black,
              )),


          tiles: <SettingsTile>[
            /*SettingsTile.navigation(
                  leading: Icon(Icons.menu),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('General'),
                  value: Text('Time, Language, Storage, etc.'),
                ),

                SettingsTile.navigation(
                  leading: Icon(Icons.screenshot),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Display'),
                  value: Text('Font, Button Size, etc.'),
                ),

                SettingsTile.navigation(
                  leading: Icon(Icons.accessibility_new_rounded),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Accessibility'),
                  value: Text('Zoom, Voice Over, Reverse Constrast, etc.'),
                ),*/

            SettingsTile.switchTile(

              onToggle: (value) {
                setState(() {
                  darkModeOn = value;
                });
              },

              initialValue: darkModeOn,
              leading: Icon(Icons.format_paint),
              title: Text('Darkmode'),
            ),

            SettingsTile.navigation(
              leading: Icon(Icons.perm_device_information),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Information'),
              value: Text('Version, Updates, Credits, etc.'),
            ),

          ],
        ),
        ],
      ),

    );

  }

}
