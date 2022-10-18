import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordSuccessPage extends StatelessWidget {
  const PasswordSuccessPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return BaseScaffold(
        isAction: false,
        isDrawer: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Password have been changed successfully. Thank you for following required steps"
                    .tr,
                style: textSubTitle(fontSize: AppSizes.blockSizeVertical * 2.1),
                textAlign: TextAlign.center,
              ),
              spacerWidget(height: AppSizes.blockSizeVertical * 7.0),
              raisedBtnLg(
                  onPressed: () {
                    Navigator.of(context).popUntil((_) => count++ >= 4);
                    showToast(
                        msg: "Please login with your new password to continue"
                            .tr);
                  },
                  text: "OK".tr)
            ],
          ),
        ));
  }
}
