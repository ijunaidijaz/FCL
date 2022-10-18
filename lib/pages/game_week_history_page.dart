import 'package:fcl/core/datamodels/weeks_datamodel.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_date_format.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_competition_adds.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
//TODO:need to be improved more

class GameWeeksHistory extends StatelessWidget {
  const GameWeeksHistory({Key key}) : super(key: key);

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
                "Weeks History".tr,
                style: textTitle(),
              ),
              spacerWidget(height: AppSizes.blockSizeVertical * 3.0),
              Column(
                children: [
                  FutureBuilder<WeeksDatamodel>(
                    future: competitionListViewModel.getCompetitionWeekData(),
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
                        return Column(
                          children: [
                            _gameHistoryHeader(),
                            Wrap(
                                children: List.generate(
                                    snapshot.data.data.data.length, (index) {
                              return _gameHistoryIUtem(
                                  week: snapshot.data.data.data[index].title,
                                  date: dateFormatComplete(
                                      snapshot.data.data.data[index].expiredAt),
                                  points: snapshot.data.data.data[index].score
                                      .toString(),
                                  ontap: () {
                                    competitionListViewModel.weekId =
                                        snapshot.data.data.data[index].id;
                                    competitionListViewModel.weekDay =
                                        snapshot.data.data.data[index].title;
                                    competitionListViewModel.weekExpiry =
                                        snapshot
                                            .data.data.data[index].expiredAt;
                                    competitionListViewModel.weekCreated =
                                        snapshot
                                            .data.data.data[index].createdAt;
                                    NavRouter.navigator.pushNamed(
                                        NavRouter.gameWeeksHistoryDetailPage);
                                  },
                                  color: index % 2 == 0
                                      ? kColorContainer
                                      : kColorContainerSimple);
                            })),
                          ],
                        );
                      } else {
                        return Container(
                            height: AppSizes.screenHeight / 2,
                            child: Center(child: progressIndicator()));
                      }
                    },
                  ),
                  CompetitionAdssWidget(),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget _gameHistoryIUtem({
    @required Color color,
    @required GestureTapCallback ontap,
    @required String week,
    @required String date,
    @required String points,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        color: color,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.blockSizeHorizontal * 4.0,
              vertical: AppSizes.blockSizeVertical * 2.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    week,
                    style: textBody(
                        color: Colors.black,
                        fontSize: AppSizes.blockSizeHorizontal * 3.5),
                  )),
                  // spacerWidget(width: AppSizes.blockSizeHorizontal * 3.0),
                  Flexible(
                    child: Text(
                      date,
                      style: textBody(
                          fontSize: AppSizes.blockSizeHorizontal * 3.5,
                          color: Colors.black),
                    ),
                  ),
                  spacerWidget(width: AppSizes.blockSizeHorizontal * 5.0),
                  Text(
                    points,
                    style: textBody(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gameHistoryHeader() {
    return Container(
      color: kColorAccent,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.blockSizeHorizontal * 4.0,
            vertical: AppSizes.blockSizeVertical * 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Week".tr,
              style: textBody(color: Colors.black),
            ),
            Text(
              "Date".tr,
              style: textBody(color: Colors.black),
            ),
            Text(
              "Week Points".tr,
              style: textBody(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
