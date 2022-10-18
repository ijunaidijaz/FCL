import 'package:fcl/core/datamodels/weeks_datamodel.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';

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

class WeeksDeadlinePage extends StatelessWidget {
  const WeeksDeadlinePage({Key key}) : super(key: key);

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
                "Weeks Deadlines".tr,
                style: textTitle(),
              ),
              spacerWidget(height: AppSizes.blockSizeVertical * 3.0),
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
                    return Wrap(
                      children: [
                        _competitionsDeadlinesHeader(),
                        Column(
                            children: List.generate(
                                snapshot.data.data.data.length, (index) {
                          return _competitionListItem(
                              title: snapshot.data.data.data[index].title ?? "",
                              date: dateFormatComplete(
                                  snapshot.data.data.data[index].expiredAt),
                              time: timeFormat(
                                  snapshot.data.data.data[index].expiredAt),
                              color: index % 2 == 0
                                  ? kColorContainer
                                  : kColorContainerSimple);
                        }))
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
          ),
        ),
      ),
    ));
  }

  Widget _competitionsDeadlinesHeader() {
    return Container(
      color: kColorAccent,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.blockSizeHorizontal * 4.0,
            vertical: AppSizes.blockSizeVertical * 2.0),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppSizes.blockSizeHorizontal),
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
                "Time".tr,
                style: textBody(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _competitionListItem({
    @required Color color,
    @required String title,
    @required String date,
    @required String time,
  }) {
    return Container(
      color: color,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.blockSizeHorizontal * 4.0,
            vertical: AppSizes.blockSizeVertical * 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style: textBody(color: Colors.black),
              ),
            ),
            Flexible(
              child: Text(
                date,
                style: textBody(color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                time,
                style: textBody(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
