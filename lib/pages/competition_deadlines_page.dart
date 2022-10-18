import 'package:fcl/core/viewmodels/device_info.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/router/router.gr.dart';
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
import 'competition_result_list_page .dart';

class CompetitionDeadlinesPage extends StatefulWidget {
  const CompetitionDeadlinesPage({Key key}) : super(key: key);

  @override
  _CompetitionDeadlinesPageState createState() =>
      _CompetitionDeadlinesPageState();
}

class _CompetitionDeadlinesPageState extends State<CompetitionDeadlinesPage> {
  DeviceInfoViewmodel deviceInfoViewmodel = DeviceInfoViewmodel();

  @override
  void initState() {
    getDeviceInfo();
    super.initState();
  }

  getDeviceInfo() async {
    await deviceInfoViewmodel.validateAndSubmitDeviceInfo(
        screenName: "Dead Lines");
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
                'Competition\'s Deadline'.tr,
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
                    return Column(
                      children: [
                        _competitionsDeadlinesHeader(),
                        Wrap(
                          children: [
                            Column(
                                children: List.generate(
                                    snapshot.data.data.data.length, (index) {
                              return _competitionListItem(
                                  onTap: () {
                                    competitionListViewModel.competitionId =
                                        snapshot.data.data.data[index].id;

                                    print(
                                        "===Trace: Compeition id is ${competitionListViewModel.competitionId}==========");
                                    NavRouter.navigator
                                        .pushNamed(NavRouter.weeksDeadlinePage);
                                  },
                                  title: snapshot.data.data.data[index].name,
                                  date: dateFormatComplete(snapshot
                                          .data.data.data[index].expiredAt)
                                      .toString(),
                                  color: index % 2 == 0
                                      ? kColorContainer
                                      : kColorContainerSimple);
                            })),
                            spacerWidget(
                                height: AppSizes.blockSizeVertical * 8.0),
                            GeneralAdssWidget(),
                          ],
                        ),
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
                "Competitions".tr,
                style: textBody(color: Colors.black),
              ),
              Text(
                "Date".tr,
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
    @required GestureTapCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
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
