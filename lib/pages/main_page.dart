import 'package:fcl/core/viewmodels/device_info.dart';
import 'package:fcl/core/viewmodels/liveScore_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/pages/web_views/liveScore_webview_page.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_alerts.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LiveScoreViewModel liveScoreViewModel = LiveScoreViewModel();
  DeviceInfoViewmodel deviceInfoViewmodel = DeviceInfoViewmodel();

  var url;

  @override
  void initState() {
    getLiveScore();
    getDeviceInfo();

    super.initState();
  }

  getDeviceInfo() async {
    await deviceInfoViewmodel.validateAndSubmitDeviceInfo(
        screenName: "Application Main page");
  }

  getLiveScore() async {
    url = await liveScoreViewModel.getLiveScoreData();
    print("url is $url");
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return WillPopScope(
      onWillPop: () => null,
      child: BaseScaffold(
          isDrawer: true,
          body: ListView(
            children: [
              spacerWidget(height: AppSizes.blockSizeVertical * 3.0),
              _firstRow(
                  myScoreOnTap: () => NavRouter.navigator
                      .pushNamed(NavRouter.competitionResultListPage),
                  deadlinesTap: () => NavRouter.navigator
                      .pushNamed(NavRouter.competitionDeadlinesPage),
                  isBotoomLabel: true),
              spacerWidget(height: AppSizes.blockSizeVertical * 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconMenuItem(
                      onTap: () => NavRouter.navigator
                          .pushNamed(NavRouter.competitionLeagueListPage),
                      iconName: 'league',
                      text: "Standings".tr),
                  _iconMenuItem(
                      onTap: () => NavRouter.navigator
                          .pushNamed(NavRouter.questionsPage),
                      iconName: 'questions',
                      text: "Questions".tr),
                ],
              ),
              spacerWidget(height: AppSizes.blockSizeVertical * 1.5),
              _iconMenuItem(
                  iconName: 'gifts',
                  onTap: () => NavRouter.navigator
                      .pushNamed(NavRouter.competitionGiftListPage),
                  text: "Gifts and Prizes".tr),
              spacerWidget(height: AppSizes.blockSizeVertical * 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconMenuItem(
                      iconName: 'contact-us',
                      onTap: () => NavRouter.navigator
                          .pushNamed(NavRouter.contactUsPage),
                      text: "Contact US".tr),
                  _iconMenuItem(
                      iconName: 'score',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LiveScoreWebViewPage(
                                  title: "Live Score".tr,
                                  selectedUrl: url,
                                )));
                      },
                      text: "Live Score".tr),
                ],
              ),
            ],
          )),
    );
  }

  Widget _firstRow(
      {bool isBotoomLabel = false,
      GestureTapCallback myScoreOnTap,
      GestureTapCallback deadlinesTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: myScoreOnTap,
          child: Container(
            height: AppSizes.blockSizeVertical * 20.0,
            decoration: BoxDecoration(
                color: kColorContainer,
                border: Border.all(
                    width: AppSizes.blockSizeVertical * 0.2,
                    color: kColorAccent)),
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.blockSizeHorizontal * 4.0,
                  vertical: AppSizes.blockSizeVertical * 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/my-score.svg',
                          height: AppSizes.blockSizeVertical * 6.0,
                        ),
                        Text(
                          "Scores\nHistory".tr,
                          style: textBody(
                            fontSize: AppSizes.blockSizeVertical * 2.4,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: AppSizes.blockSizeVertical * 4.0),
          child: Image(
              width: AppSizes.blockSizeHorizontal * 26.0,
              image: AssetImage("assets/images/victory_avatar.png")),
        ),
        InkWell(
          onTap: deadlinesTap,
          child: Container(
            height: AppSizes.blockSizeVertical * 20.0,
            decoration: BoxDecoration(
                color: kColorAccent,
                border: Border.all(
                    width: AppSizes.blockSizeVertical * 0.2,
                    color: kColorAccent)),
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.blockSizeHorizontal * 4.0,
                  vertical: AppSizes.blockSizeVertical * 3.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/deadline.svg',
                          height: AppSizes.blockSizeVertical * 6.0,
                        ),
                        Text(
                          "Deadline".tr,
                          style: textBody(
                            fontSize: AppSizes.blockSizeVertical * 2.5,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }

  Widget _iconMenuItem({
    @required String iconName,
    @required String text,
    @required GestureTapCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: AppSizes.blockSizeHorizontal * 42.0,
        decoration: BoxDecoration(
            color: kColorContainer,
            border: Border.all(
                width: AppSizes.blockSizeVertical * 0.2, color: kColorAccent)),
        child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.blockSizeVertical * 2.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/$iconName.svg',
                      height: AppSizes.blockSizeVertical * 6.0,
                    ),
                    spacerWidget(height: AppSizes.blockSizeVertical * 1.5),
                    Text(
                      text,
                      style: textSubTitle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
