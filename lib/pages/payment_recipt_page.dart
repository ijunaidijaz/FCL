import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:fcl/widgets/empty_widget.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:fcl/utils/app_date_format.dart';
class PaymentReciptPage extends StatefulWidget {
  const PaymentReciptPage({Key key}) : super(key: key);

  @override
  _PaymentReciptPageState createState() => _PaymentReciptPageState();
}

class _PaymentReciptPageState extends State<PaymentReciptPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CompetitionListViewModel>(context);
    return BaseScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.isPaymentSuccessfull && model.isPAymentPaid
                      ? "Success".tr
                      : "Not Success".tr,
                  style: textTitle(fontSize: AppSizes.blockSizeVertical * 3.5),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizes.blockSizeVertical * 3.0),
                  child: Text(
                    model.isPaymentSuccessfull && model.isPAymentPaid
                        ? "You Have Successfully Subscribed to the monthly offer."
                        .tr
                        : "You Have Not Subscribed to the monthly offer. Please try again later."
                        .tr,
                    style: textBody(),
                    textAlign: TextAlign.center,
                  ),
                ),
                model.isPaymentSuccessfull && model.isPAymentPaid
                    ? Stack(
                  children: [
                    Container(
                      height: AppSizes.blockSizeVertical * 25.0,
                      decoration: BoxDecoration(
                          color: kColorContainer,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(
                              AppSizes.blockSizeHorizontal * 7.0)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: AppSizes.blockSizeVertical * 3.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Subscription Fee:" +
                                    " ${model.competitionAmount} KD",
                                style: textBody(color: Colors.black),
                              ),
                              spacerWidget(
                                  height:
                                  AppSizes.blockSizeVertical * 2.0),
                              // Text(
                              //   "Subscription Period: 1 Month".tr,
                              //   style: textBody(color: Colors.black),
                              // ),


                              Text(
                                "Subscription Period: "+ dateDifference(endDate: model.competitionEndDate, startDate: model.competitionStartDate),
                                style: textBody(color: Colors.black),
                              ),


                              spacerWidget(
                                  height:
                                  AppSizes.blockSizeVertical * 2.0),
                              Text(
                                "Competition Name:" +
                                    " ${model.competitionName}",
                                style: textBody(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: AppSizes.blockSizeHorizontal * 12.0,
                      decoration: BoxDecoration(
                          color: kColorAccent,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                  AppSizes.blockSizeHorizontal * 7.0),
                              topLeft: Radius.circular(
                                AppSizes.blockSizeHorizontal * 7.0,
                              ))),
                      child: Center(
                          child: Text(
                            "Recipt".tr,
                            style: textBody(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ],
                )
                    : emptyWidget,
                raisedBtnLg(
                    onPressed: () {
                      if (model.isPaymentSuccessfull && model.isPAymentPaid) {
                        // Navigator.of(context).popUntil((_) => count++ >= 3);
                        NavRouter.navigator.popAndPushNamed(NavRouter.questionsPage);
                      } else {
                        // Navigator.of(context).popUntil((_) => count++ >= 3);
                        NavRouter.navigator.popAndPushNamed(NavRouter.questionsPage);
                      }
                    },
                    text: "OK".tr),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
