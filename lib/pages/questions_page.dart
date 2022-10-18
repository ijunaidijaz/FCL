import 'package:fcl/core/viewmodels/device_info.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/pages/web_views/payment_webview_page.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/core/datamodels/competitionList_datamodel.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/utils/app_date_format.dart';
import 'package:fcl/widgets/app_alerts.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/app_general_adds.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:fcl/widgets/empty_widget.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key key}) : super(key: key);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int groupval = 0;
  DeviceInfoViewmodel deviceInfoViewmodel = DeviceInfoViewmodel();

  @override
  void initState() {
    getDeviceInfo();
    super.initState();
  }

  getDeviceInfo() async {
    await deviceInfoViewmodel.validateAndSubmitDeviceInfo(
        screenName: "FCL competition List Page");
  }

  @override
  Widget build(BuildContext context) {
    final competitionListViewModel =
    Provider.of<CompetitionListViewModel>(context);
    return BaseScaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding:
              EdgeInsets.symmetric(vertical: AppSizes.blockSizeVertical * 5.0),
              child: Column(
                children: [
                  Text(
                    "Competitions List".tr,
                    style: textTitle(),
                  ),
                  spacerWidget(height: AppSizes.blockSizeVertical * 3.0),
                  FutureBuilder<CompetitionListDatamodel>(
                    future: competitionListViewModel.getCompetitionData(
                        allCompetitions: true),
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
                          children: [
                            Column(
                              children: List.generate(
                                  snapshot.data.data.data.length, (index) {
                                return _competitionListItem(
                                    title: snapshot.data.data.data[index].name,
                                    date: dateFormatMonthName(snapshot
                                        .data.data.data[index].expiredAt)
                                        .toString(),
                                    ontap: () {
                                      // competitionListViewModel.competitionId =
                                      //     snapshot.data.data.data[index].id;
                                      // NavRouter.navigator
                                      //     .pushNamed(NavRouter.weeksPage);
                                      // print(snapshot.data.data.data[index].createdAt);
                                      //==============start=================
                                      if (snapshot.data.data.data[index].expiredAt
                                          .isAfter(DateTime.now())) {
                                        competitionListViewModel.competitionId =
                                            snapshot.data.data.data[index].id;
                                        if (snapshot
                                            .data.data.data[index].subscribe !=
                                            null) {
                                          NavRouter.navigator
                                              .pushNamed(NavRouter.weeksPage);
                                        } else {

                                          //Assign it to use it further

                                          competitionListViewModel.competitionStartDate=snapshot.data.data
                                              .data[index].startDate;
                                          competitionListViewModel.competitionEndDate=snapshot.data.data
                                              .data[index].expiredAt;




                                          showDialog(
                                              context: context,
                                              builder: (_) {
                                                return PaymentConfirmationDialog(
                                                    startDate: snapshot.data.data
                                                        .data[index].startDate,
                                                    endDate: snapshot.data.data
                                                        .data[index].expiredAt,
                                                    competitionName: snapshot
                                                        .data.data.data[index].name,
                                                    model: competitionListViewModel,
                                                    context: context,
                                                    amount: snapshot.data.data
                                                        .data[index].subAmount);
                                              });
                                        }
                                      } else {
                                        showAlertDialogMessge(
                                          context,
                                          "Competition is already expired".tr,
                                              () {
                                            NavRouter.navigator.pop(context);
                                          },
                                        );
                                      }
                                    },
                                    color: index % 2 == 0
                                        ? kColorContainer
                                        : kColorContainerSimple);
                              }),
                            ),
                            spacerWidget(height: AppSizes.blockSizeVertical * 10.0),
                            GeneralAdssWidget(),
                          ],
                        );
                      } else {
                        return Container(
                            height: AppSizes.screenHeight / 2,
                            child: Center(child: progressIndicator()));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _competitionListItem({
    @required Color color,
    @required String title,
    @required String date,
    @required GestureTapCallback ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        color: color,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.blockSizeHorizontal * 4.0,
              vertical: AppSizes.blockSizeVertical * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textBody(color: Colors.black),
              ),
              Text(
                date,
                style: textBody(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentConfirmationDialog extends StatefulWidget {
  final DateTime startDate, endDate;
  final CompetitionListViewModel model;
  final BuildContext context;
  final String amount;
  final String competitionName;
  PaymentConfirmationDialog(
      {Key key,
        this.amount,
        this.competitionName,
        this.context,
        this.endDate,
        this.model,
        this.startDate})
      : super(key: key);

  @override
  _PaymentConfirmationDialogState createState() =>
      _PaymentConfirmationDialogState();
}

class _PaymentConfirmationDialogState extends State<PaymentConfirmationDialog> {
  int groupval = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.blockSizeHorizontal * 0.0,
      ),
      child: Center(
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(AppSizes.blockSizeVertical * 1.2)),
          child: Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: HexColor("#3A589E"),
                    borderRadius: BorderRadius.only(
                      topLeft:
                      Radius.circular(AppSizes.blockSizeVertical * 1.2),
                      topRight:
                      Radius.circular(AppSizes.blockSizeVertical * 1.2),
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizes.blockSizeVertical * 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        double.parse(widget.amount) <= 0
                            ? "(Free)".tr
                            : "${dateDifference(endDate: widget.endDate, startDate: widget.startDate)}"
                            " (${widget.amount} " +
                            "KD".tr +
                            ")",
                        style: textBody(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                      Radius.circular(AppSizes.blockSizeVertical * 1.2),
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
                            double.parse(widget.amount) <= 0
                                ? "Please subscribe to join this competition".tr
                                : "Please subscribe to join this competition by paying"
                                .tr +
                                " ${widget.amount} " +
                                "KD".tr +
                                " only".tr,
                            style: textBody(
                                fontSize: AppSizes.blockSizeVertical * 1.8,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          double.parse(widget.amount) <= 0
                              ? emptyWidget
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              spacerWidget(
                                  height:
                                  AppSizes.blockSizeVertical * 3.0),
                              Text(
                                "Select Payment Method",
                                style: textBody(
                                    fontSize:
                                    AppSizes.blockSizeVertical * 1.6,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              RadioListTile(
                                  value: 0,
                                  groupValue: groupval,
                                  title: Text(
                                    "KNET",
                                    style: textBody(
                                        color: Colors.black,
                                        fontSize:
                                        AppSizes.blockSizeHorizontal *
                                            3.8),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      groupval = val;

                                      print("group value is $groupval");
                                    });
                                  }),
                              RadioListTile(
                                  value: 1,
                                  groupValue: groupval,
                                  title: Text(
                                    "CREDIT CARD",
                                    style: textBody(
                                        color: Colors.black,
                                        fontSize:
                                        AppSizes.blockSizeHorizontal *
                                            3.8),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      groupval = val;

                                      print("group value is $groupval");
                                    });
                                  }),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.blockSizeHorizontal * 4.0),
                            child: widget.model.state == ViewState.kBusy
                                ? progressIndicator()
                                : raisedBtnLg(
                                btnHeight: 5.5,
                                borderRadius: 1.0,
                                onPressed: () async {
                                  widget.model.competitionName =
                                      widget.competitionName;
                                  widget.model.competitionAmount =
                                      widget.amount;

                                  if (double.parse(widget.amount) <= 0) {
                                    await widget.model
                                        .validateAndSubmitSubscribeFreeCompetition();
                                    Navigator.pop(context);
                                    if (widget.model
                                        .isFreeCompetitionSubscribed) {
                                      showToast(msg: widget.model.authMsg);
                                    } else {
                                      showToast(msg: widget.model.authMsg);
                                    }
                                  } else {
                                    await widget.model
                                        .validateAndSendPayment(
                                        paymentMethodType: groupval);
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder:
                                                (BuildContext context) =>
                                                PaymentWebViewPage(
                                                  title: "Payment".tr,
                                                  selectedUrl: widget
                                                      .model.paymentUrl,
                                                )));
                                  }

                                  // if (model.isPaymentProcessed) {}
                                },
                                text: double.parse(widget.amount) <= 0
                                    ? "Subscribe".tr
                                    : "CHECK OUT".tr),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
