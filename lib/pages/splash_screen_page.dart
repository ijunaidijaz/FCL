import 'package:fcl/pages/login_page.dart';

import 'package:fcl/pages/main_page.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    _delay();
  }

  Future _delay() async {
    await Future.delayed(Duration(milliseconds: 9100)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return StatupLogic();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Image(fit: BoxFit.cover, image: AssetImage('assets/images/my.gif'));
  }
}

class StatupLogic extends StatelessWidget {
  const StatupLogic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (_, prefs) {
        if (prefs.hasData) {
          if (prefs.data.getString("data") != null) {
            return MainPage();
          } else {
            return LoginPage();

            // return LanguagePage();
          }
        }
        return Material(child: Center(child: progressIndicator()));
      },
    );
  }
}
