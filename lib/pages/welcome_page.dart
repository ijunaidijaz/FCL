import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  final Function onSubmit;

  const WelcomePage({Key key, @required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int count = 0;
    return BaseScaffold(
        isAppbar: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thank you for your".tr + " ",
                    style: textBody(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Registration".tr,
                    style: textBody(
                        color: kColorAccent, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              spacerWidget(height: AppSizes.blockSizeVertical * 3.0),
              Text(
                "Welcome to".tr,
                style: textTitle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.blockSizeVertical * 4.3),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppSizes.blockSizeVertical * 3.0),
                child: Image(
                    width: AppSizes.blockSizeHorizontal * 35.0,
                    image: AssetImage('assets/images/Group 2 copy 5@1X.png')),
              ),
              raisedBtnLg(
                  onPressed: () {
                    onSubmit();
                    // NavRouter.navigator.pushNamedAndRemoveUntil(
                    //     NavRouter.loginPage, (route) => false);

                    // Navigator.of(context).popUntil((_) => count++ >= 3);
                  },
                  text: "Continue".tr)
            ],
          ),
        ));
  }
}
