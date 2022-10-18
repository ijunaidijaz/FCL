import 'dart:ui';

import 'package:fcl/router/router.gr.dart';
import 'package:fcl/services/localization_service.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
// import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
// import 'package:intro_slider/slide_object.dart';
import 'master_views/base_scaffold.dart';
import 'package:get/get.dart';
//import 'package:intro_slider_example/home.dart';

class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({Key key}) : super(key: key);

  @override
  OnBoardingPageState createState() => new OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  List<Slide> slides = [];

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
          title: "About Us".tr,
          pathImage: "assets/images/logo.png",
          description:
              'A Game that depends on your correct predictions that will gather all football fans in one league.\n\nAll questions related to all football competitions.\n\nAll you need is:\n\n✓  Register in the App\n✓  Answer questions\n✓  Lead the league\n✓  Win the game'
                  .tr),
    );
    slides.add(
      Slide(
          title: "Competition Rules".tr,
          pathImage: "assets/images/logo.png",
          description:
              'You will face number of questions weekly, there are two types of questions\n✓  Main questions\n✓  Bonus questions\n\nNotice:\n✓  There is a Deadline that should be checked every week.\n✓  Submit all answers before the Deadline.\n\nYou will collect points if you predict answers correctly\n✓  Main questions 10 points.\n✓  Bonus questions 20 points.\n\nNotice: if you predict all answers correctly, you will win your points +30'
                  .tr),
    );

    slides.add(
      Slide(
          title: "Why am I participating in FCL?".tr,
          pathImage: "assets/images/logo.png",
          description:
              'In FCL Competition:\n\nCash prizes for the top three places in the competition Standings every month:\n✓  First place 30 KD\n✓  Second place 20 KD\n✓  Third place 10 KD\n\nSpecial prizes and gifts for the top 3 places at the end of the season:\n✓  First place 300KD and Golden Cup.\n✓  Second place 200KD and Silver Cup.\n✓  Third place 100KD and Bronze Cup.\n\nFCL competition cost free for all participants.\n\nNotice:\n         We will add more competitions with different special prizes and gifts that will cost every participant 1 KD only for each competition.'
                  .tr),
    );
  }

  void onDonePress() {
    NavRouter.navigator.pushNamed(NavRouter.mainPage);
    // Back to the first tab
    // this.goToTab(0);
  }

  void onSkipPress() {
    NavRouter.navigator.pushNamed(NavRouter.mainPage);
    // Back to the first tab
    // this.goToTab(0);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    // return Icon(
    //   Icons.navigate_next,
    //   color: kColorAccent,
    //   size: 35.0,
    // );
    return Text(
      "Next".tr,
      style: textBody(color: Colors.black),
    );
  }

  Widget renderDoneBtn() {
    return Text(
      "Done".tr,
      style: textBody(color: Colors.black),
    );
    // return Icon(
    //   Icons.done,
    //   color: kColorAccent,
    // );
  }

  Widget renderSkipBtn() {
    return Text(
      "Skip".tr,
      style: textBody(color: Colors.black),
    );
    // return Icon(
    //   Icons.skip_next,
    //   color: kColorAccent,
    // );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppSizes.blockSizeVertical * 2.0,
            horizontal: AppSizes.blockSizeHorizontal * 4.0),
        child: Column(
          children: <Widget>[
            Image(
                width: AppSizes.blockSizeHorizontal * 25.0,
                fit: BoxFit.fitWidth,
                image: AssetImage(currentSlide.pathImage)),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.blockSizeVertical * 3.0),
              child: Align(
                alignment: LocalizationService.locale == Locale('ar', 'AR')
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Text(
                  currentSlide.title,
                  style: textTitle(
                      color: Colors.black,
                      fontSize: AppSizes.blockSizeHorizontal * 3.8,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Text(
              currentSlide.description,
              style: textBody(
                  fontSize: AppSizes.blockSizeHorizontal * 3.3,
                  color: Colors.black),
            ),
          ],
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context); //TODO: remove it at end
    return WillPopScope(
      onWillPop: () => null,
      child: BaseScaffold(
        isAppbar: false,
        body: Center(
          child: SizedBox(
            height: AppSizes.blockSizeVertical * 85.0,
            child: Center(
                child: IntroSlider(

              // slides: [],
              // List slides
              slides: this.slides,

              // Skip button
              renderSkipBtn: this.renderSkipBtn(),
              onSkipPress: this.onSkipPress,
              // colorSkipBtn: Colors.transparent,
              // highlightColorSkipBtn: kColorAccent,

              // Next button
              renderNextBtn: this.renderNextBtn(),

              // Done button
              renderDoneBtn: this.renderDoneBtn(),
              onDonePress: this.onDonePress,
              // colorDoneBtn: Colors.transparent,
              // highlightColorDoneBtn: Colors.transparent,

              // Dot indicator
              colorDot: kColorAccent,
              sizeDot: AppSizes.blockSizeHorizontal * 2.0,
              // typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

              // Tabs
              listCustomTabs: this.renderListCustomTabs(),
              backgroundColorAllSlides: kColorContainer,
              refFuncGoToTab: (refFunc) {
                this.goToTab = refFunc;
              },

              // Behavior

              // Show or hide status bar
              // shouldHideStatusBar: false,
              hideStatusBar: false,
              // On tab change completed
              onTabChangeCompleted: this.onTabChangeCompleted,
            )),
          ),
        ),
      ),
    );
  }
}
