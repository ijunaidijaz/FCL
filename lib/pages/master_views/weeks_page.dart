import 'package:fcl/core/datamodels/weeks_datamodel.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/pages/question_game_page.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_competition_adds.dart';
import 'package:fcl/widgets/app_general_adds.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/empty_widget.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class WeeksPage extends StatelessWidget {
  const WeeksPage({Key key}) : super(key: key);

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
                "Weeks List".tr,
                style: textTitle(),
              ),
              spacerWidget(height: AppSizes.blockSizeVertical * 3.0),
              FutureBuilder<WeeksDatamodel>(
                future: competitionListViewModel.getCompetitionWeekData(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null ||
                        !snapshot.hasData ||
                        snapshot.data.data.data.isEmpty) {
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
                              isExpired: snapshot
                                      .data.data.data[index].expiredAt
                                      .isAfter(DateTime.now())
                                  ? false
                                  : true,
                              desc: snapshot.data.data.data[index].title ?? "",
                              ontap: () async {
                                print(snapshot.data.data.data[index].expiredAt);
                                if (snapshot.data.data.data[index].expiredAt
                                    .isAfter(DateTime.now())) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuestionGamePage(
                                              weekId: snapshot
                                                  .data.data.data[index].id,
                                            )),
                                  );
                                }
                              },
                              color: index % 2 == 0
                                  ? kColorContainer
                                  : kColorContainerSimple);
                        })),
                        spacerWidget(height: AppSizes.blockSizeVertical * 8.0),
                        CompetitionAdssWidget(),
                      ],
                    );
                  } else {
                    return Container(
                        height: AppSizes.screenHeight / 2,
                        child: Center(child: progressIndicator()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget _competitionListItem({
    @required Color color,
    @required GestureTapCallback ontap,
    @required bool isExpired,
    @required String desc,
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
                desc,
                style: textBody(color: Colors.black),
              ),
              isExpired
                  ? Text(
                      "Expired".tr,
                      style: textBody(color: Colors.black),
                    )
                  : emptyWidget,
            ],
          ),
        ),
      ),
    );
  }
}
