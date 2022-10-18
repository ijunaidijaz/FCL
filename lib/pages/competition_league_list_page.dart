import 'package:fcl/core/viewmodels/device_info.dart';
import 'package:fcl/pages/competition_result_list_page%20.dart';
import 'package:fcl/pages/league_detail_page.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';

import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/core/datamodels/competitionList_datamodel.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/utils/app_date_format.dart';
import 'package:fcl/widgets/app_general_adds.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class CompetitionLeagueListPage extends StatefulWidget {
  const CompetitionLeagueListPage({Key key}) : super(key: key);

  @override
  _CompetitionLeagueListPageState createState() =>
      _CompetitionLeagueListPageState();
}

class _CompetitionLeagueListPageState extends State<CompetitionLeagueListPage> {
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
                future: competitionListViewModel.getCompetitionData(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null ||
                        !snapshot.hasData ||
                        snapshot.data.data.data.isEmpty) {
                      return notSubscribeCompetitionWidget(context: context);
                    }

                    return Wrap(
                      children: [
                        Column(
                            children: List.generate(
                                snapshot.data.data.data.length, (index) {
                          return _competitionListItem(
                              title: snapshot.data.data.data[index].name,
                              date: dateFormatMonthName(
                                      snapshot.data.data.data[index].expiredAt)
                                  .toString(),
                              ontap: () {
                                competitionListViewModel.competitionId =
                                    snapshot.data.data.data[index].id;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LeagueDetailPage(
                                            competittionId: snapshot
                                                .data.data.data[index].id,
                                          )),
                                );

                                // NavRouter.navigator
                                //     .pushNamed(NavRouter.leagueDetailPage);
                              },
                              color: index % 2 == 0
                                  ? kColorContainer
                                  : kColorContainerSimple);
                        })),
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
