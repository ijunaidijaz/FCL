import 'package:fcl/core/datamodels/subscribtionDetail_datamodel.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/core/viewmodels/subscribtionDetails_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/pages/web_views/payment_webview_page.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_date_format.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SubscriptionDetailPage extends StatelessWidget {
  const SubscriptionDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SubscribtionDetailsViewModel>(context);
    final competitionListViewModel =
        Provider.of<CompetitionListViewModel>(context);
    return BaseScaffold(
        isAction: false,
        isDrawer: false,
        isCenterLogo: false,
        centerTitle: "Subscriptions".tr,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: AppSizes.blockSizeVertical * 3.0),
                child: FutureBuilder<SubscribtionDetailDatamodel>(
                  future: model.getSubscribtionData(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null || !snapshot.hasData) {
                        return Center(
                          child: Text(
                            "No data".tr,
                            style: textBody(),
                          ),
                        );
                      }
                      return Wrap(
                          children: List.generate(
                        snapshot.data.data.data.length,
                        (index) => _subscriptionItem(
                            competitionName:
                                snapshot.data.data.data[index].competition.name,
                            amount: snapshot
                                .data.data.data[index].competition.subAmount,
                            expiry: snapshot.data.data.data[index].expireAt,
                            onTab: () async {
                              competitionListViewModel.competitionId =
                                  snapshot.data.data.data[index].competitionId;
                              competitionListViewModel.competitionName =
                                  snapshot
                                      .data.data.data[index].competition.name;
                              competitionListViewModel.competitionAmount =
                                  snapshot.data.data.data[index].competition
                                      .subAmount;

                              // NavRouter.navigator
                              //     .pushNamed(NavRouter.paymentPage);

                              await competitionListViewModel
                                  .validateAndSendPayment();
                              if (competitionListViewModel.isPaymentProcessed) {
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PaymentWebViewPage(
                                              title: "Payment".tr,
                                              selectedUrl:
                                                  competitionListViewModel
                                                      .paymentUrl,
                                            )));
                              }
                            }),
                      ));
                    } else {
                      return Container(
                          height: AppSizes.screenHeight / 2,
                          child: Center(child: progressIndicator()));
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget _subscriptionItem({
    @required String competitionName,
    @required String amount,
    @required DateTime expiry,
    @required GestureTapCallback onTab,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.blockSizeVertical * 1.8),
      child: Wrap(
        children: [
          Container(
            width: AppSizes.blockSizeHorizontal * 100.0,
            decoration: BoxDecoration(
                color: HexColor("#3A589E"),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.blockSizeVertical * 1.2),
                  topRight: Radius.circular(AppSizes.blockSizeVertical * 1.2),
                )),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.blockSizeVertical * 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      "$competitionName ($amount " + "KD".tr + ")",
                      textAlign: TextAlign.center,
                      style: textBody(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: AppSizes.blockSizeHorizontal * 100.0,
            decoration: BoxDecoration(
                color: kColorContainer,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppSizes.blockSizeVertical * 1.2),
                  bottomRight:
                      Radius.circular(AppSizes.blockSizeVertical * 1.2),
                )),
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.blockSizeHorizontal * 4.0,
                  vertical: AppSizes.blockSizeVertical * 2.0,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.blockSizeHorizontal * 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expiry.isBefore(DateTime.now())
                            ? "Your subscription is expired at" +
                                " ${dateFormatMonthName(expiry)}"
                            : "Your subscription will end in" +
                                " ${dateFormatMonthName(expiry)}",
                        style: textBody(
                            fontSize: AppSizes.blockSizeVertical * 1.8,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: AppSizes.blockSizeHorizontal * 4.0),
                      //   child: expiry.isBefore(DateTime.now())
                      //       ? raisedBtnLg(
                      //           btnHeight: 5.5,
                      //           borderRadius: 1.0,
                      //           onPressed: onTab,
                      //           text: "BUY".tr)
                      //       : emptyWidget,
                      // )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
