import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileSubmitPage extends StatelessWidget {
  const EditProfileSubmitPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Password have been changed successfully. Thank you for following required steps"
                .tr,
            textAlign: TextAlign.center,
            style: textSubTitle(fontSize: AppSizes.blockSizeVertical * 2.1),
          ),
          spacerWidget(height: AppSizes.blockSizeVertical * 5.0),
          raisedBtnLg(
              onPressed: () =>
                  NavRouter.navigator.pushNamed(NavRouter.mainPage),
              text: "OK".tr)
        ],
      ),
    ));
  }
}
