import 'package:appmove/api/Api.dart';
import 'package:appmove/screen/home/NavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingScreen extends StatefulWidget {
  // SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF47932),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffF47932),
            title: Text('Setting'),
          ),
          body: Container(
            child: SettingsList(
              shrinkWrap: false,
              sections: [
                SettingsSection(
                  title: 'Section',
                  tiles: [
                    SettingsTile(
                      title: 'Language',
                      subtitle: 'English',
                      leading: Icon(Icons.language),
                      onPressed: (BuildContext context) {},
                    ),
                    SettingsTile(
                      title: 'Logout',
                      // subtitle: 'English',
                      leading: Icon(Icons.logout),
                      onPressed: (BuildContext context) async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: Text('logout?🤷🏻‍♂️'),
                                children: <Widget>[
                                  SimpleDialogOption(
                                    onPressed: () async {
                                      await Api.logout();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          CupertinoPageRoute(
                                              builder: (BuildContext context) =>
                                                  Appbar()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Text('Yes👌🏻'),
                                  ),
                                  // SimpleDialogOption(
                                  //   onPressed: handleImageSelecting,
                                  //   child: Text('select a pic'),
                                  // ),
                                  SimpleDialogOption(
                                    child: Text('cancel🙅🏻‍♂️'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    ),
                    // SettingsTile.switchTile(
                    //   title: 'Use fingerprint',
                    //   leading: Icon(Icons.fingerprint),
                    //   switchValue: value,
                    //   onToggle: (bool value) {},
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
