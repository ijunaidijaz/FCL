import 'package:fcl/core/datamodels/leagueScore_datamodel.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/core/viewmodels/device_info.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_competition_adds.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:fcl/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeagueDetailPage extends StatefulWidget {
  final int competittionId;

  LeagueDetailPage({this.competittionId});

  @override
  _LeagueDetailPageState createState() => _LeagueDetailPageState();
}

class _LeagueDetailPageState extends State<LeagueDetailPage> {
  DeviceInfoViewmodel deviceInfoViewmodel = DeviceInfoViewmodel();
  CompetitionListViewModel competitionListViewModel =
      CompetitionListViewModel();

  Future<LeagueScoreDatamodel> _leagueScoreFuture;
  List<LeagueData> _searchResults = [];
  List<LeagueData> _allLeagueScores = [];
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  String searchText = "Search";

  @override
  void initState() {
    loadData();
    getDeviceInfo();
    super.initState();
  }

  getDeviceInfo() async {
    await deviceInfoViewmodel.validateAndSubmitDeviceInfo(
        screenName: "FCL league page");
  }

  void loadData() async {
    _leagueScoreFuture = competitionListViewModel.getCompetitionLeagueData(
        comId: widget.competittionId);
  }

  void searchListener(String text, List<LeagueData> leagueScores) async {
    _searchResults.clear();
    if (text.isEmpty) {
      setState(() {}
      );
      return;
    }

    leagueScores.forEach((leagueScores) {
      if (leagueScores.user.username
          .toLowerCase()
          .contains(text.toLowerCase())) {
        _searchResults.add(leagueScores);
      }
    });
    Future.delayed(const Duration(milliseconds: 3000), () {
// Here you can write your code

      setState(() {
        // Here you can write your code for open new view
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.blockSizeVertical * 5.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TxtField(
                titletxt: "Search...".tr,
                hinttxt: searchText.tr,
                validationerrortxt: null,
                keyboardtype: null,
                onOnChange: (val) => searchListener(val, _allLeagueScores),
                onsaved: null,
                validator: null),
            spacerWidget(height: AppSizes.blockSizeVertical * 2.0),
            _tableData(),
            // _table(),
            spacerWidget(height: AppSizes.blockSizeVertical * 3.0),
            // GeneralAdssWidget(),
            CompetitionAdssWidget(),
          ],
        ),
      ),
    ));
  }

  _tableData() {
    return Center(
      child: FutureBuilder<LeagueScoreDatamodel>(
        future: _leagueScoreFuture,
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
            _allLeagueScores = snapshot.data.data.data;
            return Column(
              children: [
                _competitionsDeadlinesHeader(),
                Container(
                  child: ValueListenableBuilder<int>(
                    builder: (BuildContext context, int value, Widget child) {
                      // This builder will only get called when the _counter
                      // is updated.
                      return Wrap(
                        children: [
                          Column(
                              children: List.generate(
                                  _searchResults.isNotEmpty
                                      ? _searchResults.length
                                      : _allLeagueScores.length, (index) {
                            bool isSearch = _searchResults.isNotEmpty;
                            LeagueData leagueData = isSearch
                                ? _searchResults[index]
                                : _allLeagueScores[index];
                            return _competitionListItem(
                                index: (index + 1).toString(),
                                userName: leagueData.user.username,
                                currentWeekScore:
                                    leagueData.currentWeekScore.toString(),
                                totalScore: leagueData.overAllTotal.toString(),
                                color: index % 2 == 0
                                    ? kColorContainer
                                    : kColorContainerSimple);
                          }))
                        ],
                      );
                    },
                    valueListenable: _counter,
                  ),
                )
              ],
            );
          } else {
            return Container(
                height: AppSizes.screenHeight / 2,
                child: Center(child: progressIndicator()));
          }
        },
      ),
    );
  }

  Widget _competitionListItem({
    @required Color color,
    @required String index,
    @required String userName,
    @required String currentWeekScore,
    @required String totalScore,
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
            Expanded(
              child: Text(
                index,
                style: textBody(
                    fontSize: AppSizes.blockSizeVertical * 1.7,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  userName,
                  style: textBody(
                      // fontSize: AppSizes.blockSizeVertical * 1.7,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Text(
                currentWeekScore,
                textAlign: TextAlign.center,
                style: textBody(
                    fontSize: AppSizes.blockSizeVertical * 1.7,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                totalScore,
                textAlign: TextAlign.center,
                style: textBody(
                    fontSize: AppSizes.blockSizeVertical * 1.7,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
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
                "Position".tr,
                style: textSubTitle(
                    fontSize: AppSizes.blockSizeVertical * 1.5,
                    color: Colors.black),
              ),
              Text(
                "Username".tr,
                style: textSubTitle(
                    fontSize: AppSizes.blockSizeVertical * 1.5,
                    color: Colors.black),
              ),
              Text(
                "current week".tr,
                style: textSubTitle(
                    fontSize: AppSizes.blockSizeVertical * 1.5,
                    color: Colors.black),
              ),
              Text(
                "Total".tr,
                style: textSubTitle(
                    fontSize: AppSizes.blockSizeVertical * 1.5,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Widget _table() {
//   return FutureBuilder(
//     future: _leagueScoreFuture,
//     builder: (BuildContext context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.done) {
//         if (snapshot.data == null || !snapshot.hasData) {
//           return Center(
//             child: Text(
//               "No data",
//               style: textBody(),
//             ),
//           );
//         }
//         _allLeagueScores = snapshot.data.data.data;
//         return Container(
//             child: Column(children: <Widget>[
//           Table(
//             columnWidths: {
//               0: FlexColumnWidth(1),
//               1: FlexColumnWidth(1.2),
//               2: FlexColumnWidth(1.5),
//               3: FlexColumnWidth(1),
//             },
//             defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//             children: [
//               _tableHeader(),
//               for (var data in _allLeagueScores)
//                 _tableDataRow(
//                     userName: data.user.username,
//                     index: "1",
//                     totalScore: data.overAllTotal.toString(),
//                     currentWeekScore: data.currentWeekScore.toString()),
//             ],
//           ),
//         ]));
//       } else {
//         return Container(
//             height: AppSizes.screenHeight / 2,
//             child: Center(child: CircularProgressIndicator()));
//       }
//     },
//   );
// }

// TableRow _tableHeader() {
//   return TableRow(
//       decoration: BoxDecoration(
//         color: kColorAccent,
//       ),
//       children: [
//         Container(
//           height: AppSizes.blockSizeVertical * 7.0,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Position",
//                   style: textSubTitle(
//                       fontSize: AppSizes.blockSizeVertical * 1.5,
//                       color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Username",
//               style: textSubTitle(
//                   fontSize: AppSizes.blockSizeVertical * 1.5,
//                   color: Colors.black),
//             ),
//           ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Current Week",
//               style: textSubTitle(
//                   fontSize: AppSizes.blockSizeVertical * 1.5,
//                   color: Colors.black),
//             ),
//           ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Total",
//               style: textSubTitle(
//                   fontSize: AppSizes.blockSizeVertical * 1.5,
//                   color: Colors.black),
//             ),
//           ],
//         ),
//       ]);
// }

// TableRow _tableDataRow(
//     {@required String userName,
//     @required String index,
//     @required String currentWeekScore,
//     @required String totalScore}) {
//   return TableRow(children: [
//     Container(
//         height: AppSizes.blockSizeVertical * 4.0,
//         color: kColorContainerSimple,
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Text(
//             index,
//             style: textBody(
//                 fontSize: AppSizes.blockSizeVertical * 1.7,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold),
//           )
//         ])),
//     Container(
//         height: AppSizes.blockSizeVertical * 4.0,
//         color: kColorContainer,
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Text(
//             userName,
//             style: textBody(
//                 fontSize: AppSizes.blockSizeVertical * 1.7,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold),
//           )
//         ])),
//     Container(
//         height: AppSizes.blockSizeVertical * 4.0,
//         color: kColorContainerSimple,
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Text(
//             currentWeekScore,
//             style: textBody(
//                 fontSize: AppSizes.blockSizeVertical * 1.7,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold),
//           )
//         ])),
//     Container(
//         height: AppSizes.blockSizeVertical * 4.0,
//         color: kColorContainer,
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Text(
//             totalScore,
//             style: textBody(
//                 fontSize: AppSizes.blockSizeVertical * 1.7,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold),
//           )
//         ])),
//   ]);
// }
}
