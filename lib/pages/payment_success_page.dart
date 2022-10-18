import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Padding(
          padding: EdgeInsets.only(top: AppSizes.blockSizeVertical * 5.0),
          child: Column(
            children: [
              Text(
                "Success".tr,
                style: textBody(fontSize: AppSizes.blockSizeVertical * 3.5),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppSizes.blockSizeVertical * 4.0),
                child: Text(
                  "You have successfully subscribed to\nthe monthly offer".tr,
                  textAlign: TextAlign.center,
                  style: textBody(fontSize: AppSizes.blockSizeVertical * 1.8),
                ),
              ),
              _successMsg(),
              raisedBtnLg(
                  onPressed: () =>
                      NavRouter.navigator.pushNamed(NavRouter.mainPage),
                  text: "OK".tr)
            ],
          ),
        ));
  }

  Widget _successMsg() {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
              color: kColorAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.blockSizeVertical * 3.0),
                topRight: Radius.circular(AppSizes.blockSizeVertical * 3.0),
              )),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSizes.blockSizeVertical * 2.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Recipt".tr,
                  style: textBody(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: kColorContainer,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSizes.blockSizeVertical * 3.0),
                bottomRight: Radius.circular(AppSizes.blockSizeVertical * 3.0),
              )),
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.blockSizeHorizontal * 4.0,
                vertical: AppSizes.blockSizeVertical * 2.0,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppSizes.blockSizeVertical * 3.0,
                    horizontal: AppSizes.blockSizeHorizontal * 2.0),
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Subscription Fee :".tr,
                          style: textBody(
                              fontSize: AppSizes.blockSizeVertical * 1.8,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "300 " "KD",
                          style: textBody(
                              fontSize: AppSizes.blockSizeVertical * 1.8,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    spacerWidget(height: AppSizes.blockSizeVertical * 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Subscription Period :".tr,
                          style: textBody(
                              fontSize: AppSizes.blockSizeVertical * 1.8,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "3 Months".tr,
                          style: textBody(
                              fontSize: AppSizes.blockSizeVertical * 1.8,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
