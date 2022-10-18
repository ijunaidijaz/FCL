import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fcl/core/datamodels/questionsGame_datamodel.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/core/viewmodels/device_info.dart';
import 'package:fcl/core/viewmodels/generalAdds_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_alerts.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:fcl/widgets/empty_widget.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionGamePage extends StatefulWidget {
  final int weekId;

  QuestionGamePage({Key key, @required this.weekId}) : super(key: key);

  @override
  _QuestionGamePageState createState() => _QuestionGamePageState();
}

class _QuestionGamePageState extends State<QuestionGamePage> {
  CompetitionListViewModel viemodel = CompetitionListViewModel();
  DeviceInfoViewmodel deviceInfoViewmodel = DeviceInfoViewmodel();

  List isTrue = [];
  List isFalse = [];
  List isVs1 = [];
  List isVs2 = [];
  List isTie = [];
  List isopt1 = [];
  List isopt2 = [];
  List isopt3 = [];
  List isopt4 = [];
  Future data;
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    loadFuture();
    getDeviceInfo();
    super.initState();
  }

  getDeviceInfo() async {
    await deviceInfoViewmodel.validateAndSubmitDeviceInfo(
        screenName: "FCL question page");
  }

  loadFuture() {
    viemodel.vSAnswer.clear();
    viemodel.tFAnswer.clear();
    viemodel.mcqAnswer.clear();

    data = viemodel.getQuestionsGameData(weekId: widget.weekId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final generalAddsViewModel = Provider.of<GeneralAddsViewModel>(context);
    final competitionListViewModel =
        Provider.of<CompetitionListViewModel>(context);
    AppSizes().init(context);
    return BaseScaffold(
      horizontalPadding: 2.0,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: FutureBuilder<QuestionsGameDatamodel>(
          future: data,
          builder: (BuildContext context, snapshot) {
            competitionListViewModel.tFQuestionId.clear();
            competitionListViewModel.vSQuestionId.clear();
            competitionListViewModel.mcqQuestionId.clear();

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null || !snapshot.hasData) {
                return Center(
                  child: Text(
                    "No data".tr,
                    style: textBody(),
                  ),
                );
              }

              if (snapshot.data.data.userMcqAnswer.isNotEmpty ||
                  snapshot.data.data.userTfAnswer.isNotEmpty ||
                  snapshot.data.data.userVsqAnswer.isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: AppSizes.screenHeight / 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You Already Submit Answers".tr,
                        textAlign: TextAlign.center,
                        style: textBody(),
                      ),
                      raisedBtnLg(
                          text: "OK".tr,
                          onPressed: () {
                            Navigator.pop(context);
                            NavRouter.navigator
                                .pushNamed(NavRouter.questionsPage);
                          }),
                    ],
                  ),
                );
              }

              if (snapshot.data.data.status == 0) {
                return Padding(
                  padding: EdgeInsets.only(top: AppSizes.screenHeight / 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "We will add the questions soon. Keep checking the quiz."
                            .tr,
                        textAlign: TextAlign.center,
                        style: textBody(),
                      ),
                      raisedBtnLg(
                          text: "OK".tr,
                          onPressed: () {
                            Navigator.pop(context);
                            NavRouter.navigator
                                .pushNamed(NavRouter.questionsPage);
                          }),
                    ],
                  ),
                );
              }

              if (snapshot.data.data.questionMc.isNotEmpty ||
                  snapshot.data.data.questionTf.isNotEmpty ||
                  snapshot.data.data.questionVs.isNotEmpty) {
                competitionListViewModel.quizId =
                    snapshot.data.data.competitionId;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppSizes.blockSizeVertical * 1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Questions".tr,
                              style: textBody(
                                  color: Colors.white
                                      .withOpacity(0.8509803921568627),
                                  fontSize: AppSizes.blockSizeVertical * 2.5))
                        ],
                      ),
                    ),
                    Container(
                      width: AppSizes.screenWidth,
                      child: ValueListenableBuilder<int>(
                        builder:
                            (BuildContext context, int value, Widget child) {
                          // This builder will only get called when the _counter
                          // is updated.
                          return Column(
                            children: [
                              // snapshot.data.data.questionVs.length > 0
                              //     ? Container(
                              //         color: kColorAccent,
                              //         child: Padding(
                              //           padding: EdgeInsets.symmetric(
                              //               vertical:
                              //                   AppSizes.blockSizeVertical * 1.0),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.center,
                              //             children: [
                              //               Text(
                              //                 "Bonus".tr,
                              //                 style: textBody(color: Colors.black),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       )
                              //     : emptyWidget,
                              Column(
                                children: List.generate(
                                    snapshot.data.data.questionVs.length,
                                    (index) {
                                  isVs1.add(false);
                                  isVs2.add(false);
                                  isTie.add(false);
                                  if (!competitionListViewModel.vSQuestionId
                                      .contains(snapshot
                                          .data.data.questionVs[index].id)) {
                                    competitionListViewModel.vSQuestionId.add(
                                        snapshot
                                            .data.data.questionVs[index].id);
                                  }
                                  return _questionVs(
                                    isBonus: snapshot
                                        .data.data.questionVs[index].bonus,
                                    isTieOnTap: () {
                                      // setState(() {
                                      if (competitionListViewModel.vSAnswer
                                          .asMap()
                                          .containsKey(index)) {
                                        competitionListViewModel.vSAnswer
                                            .removeAt(index);
                                      }
                                      competitionListViewModel.vSAnswer
                                          .insert(index, "tie");
                                      isTie[index] = true;
                                      isVs1[index] = false;
                                      isVs2[index] = false;
                                      _counter.value += 1;
                                      // });
                                    },
                                    vs1OnTap: () {
                                      // setState(() {
                                      if (competitionListViewModel.vSAnswer
                                          .asMap()
                                          .containsKey(index)) {
                                        competitionListViewModel.vSAnswer
                                            .removeAt(index);
                                      }
                                      competitionListViewModel.vSAnswer
                                          .insert(index, 1);
                                      isTie[index] = false;
                                      isVs1[index] = true;
                                      isVs2[index] = false;
                                      _counter.value += 1;
                                      // });
                                    },
                                    vs2OnTap: () {
                                      // setState(() {
                                      if (competitionListViewModel.vSAnswer
                                          .asMap()
                                          .containsKey(index)) {
                                        competitionListViewModel.vSAnswer
                                            .removeAt(index);
                                      }
                                      competitionListViewModel.vSAnswer
                                          .insert(index, 2);

                                      isTie[index] = false;
                                      isVs1[index] = false;
                                      isVs2[index] = true;
                                      _counter.value += 1;
                                      // });
                                    },
                                    vs1Color: isVs1[index]
                                        ? kColorAccent
                                        : Colors.transparent,
                                    vs2Color: isVs2[index]
                                        ? kColorAccent
                                        : Colors.transparent,
                                    tieColor: isTie[index]
                                        ? kColorAccent
                                        : Colors.transparent,
                                    question: snapshot
                                        .data.data.questionVs[index].question,
                                    v1Name: snapshot
                                        .data.data.questionVs[index].v1Name,
                                    v2Name: snapshot
                                        .data.data.questionVs[index].v2Name,
                                    v1ImgUrl: kImgBaseUrl +
                                        snapshot.data.data.questionVs[index]
                                            .v1Image,
                                    v2ImgUrl: kImgBaseUrl +
                                        snapshot.data.data.questionVs[index]
                                            .v2Image,
                                  );
                                }),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppSizes.blockSizeVertical * 0.5),
                                child: ValueListenableBuilder<int>(
                                  builder: (BuildContext context, int value,
                                      Widget child) {
                                    // This builder will only get called when the _counter
                                    // is updated.
                                    return Column(
                                      children: List.generate(
                                          snapshot.data.data.questionMc.length,
                                          (index) {
                                        isopt1.add(false);
                                        isopt2.add(false);
                                        isopt3.add(false);
                                        isopt4.add(false);
                                        if (!competitionListViewModel.mcqQuestionId.contains(snapshot.data.data.questionMc[index].id)) {
                                          competitionListViewModel.mcqQuestionId
                                              .add(snapshot.data.data
                                                  .questionMc[index].id);
                                        }

                                        return _questionMc(
                                          isBonus: snapshot.data.data
                                              .questionMc[index].bonus,
                                          opt1Color: isopt1[index]
                                              ? Colors.white
                                              : kColorAccent,
                                          opt2Color: isopt2[index]
                                              ? Colors.white
                                              : kColorAccent,
                                          opt3Color: isopt3[index]
                                              ? Colors.white
                                              : kColorAccent,
                                          opt4Color: isopt4[index]
                                              ? Colors.white
                                              : kColorAccent,
                                          option1: snapshot.data.data
                                              .questionMc[index].option1,
                                          option2: snapshot.data.data
                                              .questionMc[index].option2,
                                          option3: snapshot.data.data
                                              .questionMc[index].option3,
                                          option4: snapshot.data.data
                                              .questionMc[index].option4,
                                          onTapoption1: () {
                                            // setState(() async {
                                            if (competitionListViewModel
                                                .mcqAnswer
                                                .asMap()
                                                .containsKey(index)) {
                                              competitionListViewModel.mcqAnswer
                                                  .removeAt(index);
                                            }
                                            competitionListViewModel.mcqAnswer
                                                .insert(index, 1);
                                            isopt1[index] = true;
                                            isopt2[index] = false;
                                            isopt3[index] = false;
                                            isopt4[index] = false;
                                            _counter.value += 1;
                                            // });
                                          },
                                          onTapoption2: () {
                                            // setState(() async {
                                            if (competitionListViewModel
                                                .mcqAnswer
                                                .asMap()
                                                .containsKey(index)) {
                                              competitionListViewModel.mcqAnswer
                                                  .removeAt(index);
                                            }
                                            competitionListViewModel.mcqAnswer
                                                .insert(index, 2);
                                            isopt2[index] = true;
                                            isopt1[index] = false;
                                            isopt3[index] = false;
                                            isopt4[index] = false;
                                            _counter.value += 1;
                                            // });
                                          },
                                          onTapoption3: () {
                                            // setState(() async{
                                            if (competitionListViewModel
                                                .mcqAnswer
                                                .asMap()
                                                .containsKey(index)) {
                                              competitionListViewModel.mcqAnswer
                                                  .removeAt(index);
                                            }
                                            competitionListViewModel.mcqAnswer
                                                .insert(index, 3);
                                            isopt3[index] = true;
                                            isopt2[index] = false;
                                            isopt1[index] = false;
                                            isopt4[index] = false;
                                            _counter.value += 1;
                                            // });
                                          },
                                          onTapoption4: () {
                                            // setState(() async{
                                            if (competitionListViewModel
                                                .mcqAnswer
                                                .asMap()
                                                .containsKey(index)) {
                                              competitionListViewModel.mcqAnswer
                                                  .removeAt(index);
                                            }
                                            competitionListViewModel.mcqAnswer
                                                .insert(index, 4);
                                            isopt4[index] = true;
                                            isopt1[index] = false;
                                            isopt3[index] = false;
                                            isopt2[index] = false;
                                            _counter.value += 1;

                                            // });
                                          },
                                          question: snapshot.data.data
                                              .questionMc[index].question,
                                        );
                                      }),
                                    );
                                  },
                                  valueListenable: _counter,
                                  // The child parameter is most helpful if the child is
                                  // expensive to build and does not depend on the value from
                                  // the notifier.
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(
                              //       vertical: AppSizes.blockSizeVertical * 0.5),
                              //   child:
                              // ),

                              Column(
                                  children: List.generate(
                                      snapshot.data.data.questionTf.length,
                                      (index) {
                                        if( !competitionListViewModel.tFQuestionId.contains( snapshot.data.data.questionTf[index].id)){
                                competitionListViewModel.tFQuestionId.add(
                                    snapshot.data.data.questionTf[index].id);}
                                isTrue.add(false);
                                isFalse.add(false);

                                return _questionTf(
                                  isBonus: snapshot
                                      .data.data.questionTf[index].bonus,
                                  trueOptColor: isTrue[index]
                                      ? Colors.white
                                      : kColorAccent,
                                  falseOptColor: isFalse[index]
                                      ? Colors.white
                                      : kColorAccent,
                                  onTapTrue: () {
                                    // setState(() {
                                    if (competitionListViewModel.tFAnswer
                                        .asMap()
                                        .containsKey(index)) {
                                      competitionListViewModel.tFAnswer
                                          .removeAt(index);
                                    }
                                    competitionListViewModel.tFAnswer
                                        .insert(index, true);
                                    isTrue[index] = true;
                                    isFalse[index] = false;
                                    _counter.value += 1;
                                    // });
                                  },
                                  onTapFalse: () {
                                    // setState(() {
                                    if (competitionListViewModel.tFAnswer
                                        .asMap()
                                        .containsKey(index)) {
                                      competitionListViewModel.tFAnswer
                                          .removeAt(index);
                                    }
                                    competitionListViewModel.tFAnswer
                                        .insert(index, false);
                                    isTrue[index] = false;
                                    isFalse[index] = true;
                                    _counter.value += 1;
                                    // });
                                  },
                                  question: snapshot
                                      .data.data.questionTf[index].question,
                                );
                              })),
                              snapshot.data.data.competitionNativeAdd.length > 0
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              AppSizes.blockSizeVertical * 2.0),
                                      child: CarouselSlider(
                                        items: List.generate(
                                            snapshot
                                                .data
                                                .data
                                                .competitionNativeAdd[0]
                                                .pictures
                                                .length, (index) {
                                          generalAddsViewModel
                                              .validateAndSubmitGeneralAddsStat(
                                            isGeneralAdd: false,
                                            wasClicked: false,
                                            generalAddId: snapshot.data.data
                                                .competitionNativeAdd[0].id,
                                          );
                                          return InkWell(
                                            onTap: () async {
                                              if (await canLaunch(snapshot
                                                  .data
                                                  .data
                                                  .competitionNativeAdd[0]
                                                  .url)) {
                                                await generalAddsViewModel
                                                    .validateAndSubmitGeneralAddsStat(
                                                  isGeneralAdd: false,
                                                  wasClicked: true,
                                                  generalAddId: snapshot
                                                      .data
                                                      .data
                                                      .competitionNativeAdd[0]
                                                      .id,
                                                );
                                                await launch(snapshot
                                                    .data
                                                    .data
                                                    .competitionNativeAdd[0]
                                                    .url);
                                              } else
                                                // can't launch url, there is some error
                                                throw "Could not launch ${snapshot.data.data.competitionNativeAdd[0].url}";
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "http://fclkw.com/storage/app/public/${snapshot.data.data.competitionNativeAdd[0].pictures[index]}"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),

                                        //Slider Container properties
                                        options: CarouselOptions(
                                          height: 180.0,
                                          enlargeCenterPage: true,
                                          autoPlay: true,
                                          aspectRatio: 16 / 9,
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enableInfiniteScroll: true,
                                          autoPlayAnimationDuration:
                                              Duration(milliseconds: 800),
                                          viewportFraction: 0.8,
                                        ),
                                      ),
                                    )
                                  : emptyWidget,
                              Align(
                                child: competitionListViewModel.state ==
                                        ViewState.kBusy
                                    ? progressIndicator()
                                    : _customSelectionBtn(
                                        color: kColorAccent,
                                        onTap: () async {
                                          competitionListViewModel.quizId =
                                              snapshot.data.data.id;

                                          if ((snapshot.data.data.expiredAt
                                              .isBefore(DateTime.now()))) {
                                            showAlertDialogMessge(context,
                                                "Quiz already expired".tr, () {
                                              Navigator.pop(context);
                                              NavRouter.navigator.pushNamed(
                                                  NavRouter.mainPage);
                                            });
                                          } else {
                                            if (snapshot.data.data.questionVs.length == competitionListViewModel.vSAnswer.length &&
                                                snapshot.data.data.questionTf
                                                        .length ==
                                                    competitionListViewModel
                                                        .tFAnswer.length &&
                                                snapshot.data.data.questionMc
                                                        .length ==
                                                    competitionListViewModel
                                                        .mcqAnswer.length) {
                                              await competitionListViewModel
                                                  .validateAndSubmitCGameQuestions();
                                              if (competitionListViewModel
                                                  .isQuestionsSubmitted) {
                                                if (snapshot
                                                        .data
                                                        .data
                                                        .userMcqAnswer
                                                        .isNotEmpty ||
                                                    snapshot
                                                        .data
                                                        .data
                                                        .userTfAnswer
                                                        .isNotEmpty ||
                                                    snapshot
                                                        .data
                                                        .data
                                                        .userVsqAnswer
                                                        .isNotEmpty) {
                                                  showAlertDialogMessge(
                                                      context,
                                                      "Your Answers have been\nUpdated, Good Luck"
                                                          .tr
                                                          .tr, () {
                                                    Navigator.pop(context);
                                                    NavRouter.navigator
                                                        .pushNamed(
                                                            NavRouter.mainPage);
                                                  });
                                                } else {
                                                  showAlertDialogMessge(
                                                      _scaffoldKey.currentContext,
                                                      "Answers have been submitted successfully. Good Luck"
                                                          .tr, () {
                                                     NavRouter.navigator
                                                        .pushNamed(
                                                            NavRouter.mainPage);
                                                  });
                                                }
                                              } else {
                                                if (competitionListViewModel
                                                            .authMsg !=
                                                        null &&
                                                    competitionListViewModel
                                                            .authMsg
                                                            .toLowerCase()
                                                            .toString()
                                                            .trim() !=
                                                        "null") {
                                                  showToast(
                                                      msg:
                                                          competitionListViewModel
                                                              .authMsg);
                                                }
                                              }
                                            } else {
                                              showToast(
                                                  msg:
                                                      "Please Answer all questions"
                                                          .tr);
                                            }
                                          }
                                        },
                                        btnLabel: "Submit".tr,
                                      ),
                              ),
                            ],
                          );
                        },
                        valueListenable: _counter,
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  height:
                      AppSizes.screenHeight - AppSizes.blockSizeVertical * 20.0,
                  child: Center(
                    child: Text(
                      "No Quiz against this Week".tr,
                      style: textBody(),
                    ),
                  ),
                );
              }
            } else {
              return Container(
                  height: AppSizes.screenHeight / 2,
                  child: Center(child: progressIndicator()));
            }
          },
        ),
      ),
    );
  }

  Widget _questionVs({
    @required String v1Name,
    @required String v2Name,
    @required String v1ImgUrl,
    @required String v2ImgUrl,
    @required String question,
    @required Color vs1Color,
    @required Color vs2Color,
    @required Color tieColor,
    @required int isBonus,
    @required GestureTapCallback vs1OnTap,
    @required GestureTapCallback vs2OnTap,
    @required GestureTapCallback isTieOnTap,
  }) {
    return Column(
      children: [
        isBonus == 1 ? _bonusQuestion(true) : emptyWidget,
        Container(
          decoration: BoxDecoration(
              color: kColorContainer,
              border: Border.all(
                color: isBonus == 1 ? kColorAccent : Colors.transparent,
              )),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSizes.blockSizeVertical * 1.5,
                horizontal: AppSizes.blockSizeHorizontal * 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppSizes.blockSizeHorizontal * 55.0,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              question,
                              style: textBody(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   "${isBonus == 1 ? "20" : "10"} " + "Points".tr,
                    //   style: textBody(
                    //       fontWeight: FontWeight.bold, color: Colors.black),
                    // ),
                  ],
                ),
                spacerWidget(height: AppSizes.blockSizeVertical * 2.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: vs1OnTap,
                        child: Container(
                          color: vs1Color,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image(
                                  height: AppSizes.blockSizeVertical * 6.0,
                                  width: AppSizes.blockSizeHorizontal * 25.0,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(v1ImgUrl),
                                ),
                              ),
                              Text(
                                v1Name,
                                style: textBody(
                                    fontSize:
                                        AppSizes.blockSizeHorizontal * 3.0,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "VS".tr,
                        style: textBody(color: Colors.black),
                      ),
                      Text(
                        "",
                        style: textBody(color: Colors.black),
                      ),
                      InkWell(
                        onTap: vs2OnTap,
                        child: Container(
                          color: vs2Color,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image(
                                  height: AppSizes.blockSizeVertical * 6.0,
                                  width: AppSizes.blockSizeHorizontal * 25.0,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(v2ImgUrl),
                                ),
                              ),
                              Text(
                                v2Name,
                                style: textBody(
                                    fontSize:
                                        AppSizes.blockSizeHorizontal * 3.0,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "OR".tr,
                        style: textBody(color: Colors.black),
                      ),
                      InkWell(
                        onTap: isTieOnTap,
                        child: Container(
                          color: tieColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image(
                                  height: AppSizes.blockSizeVertical * 6.0,
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/tie.png"),
                                ),
                              ),
                              Text(
                                "Tie",
                                style: textBody(
                                    fontSize:
                                        AppSizes.blockSizeHorizontal * 3.0,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _questionMc({
    @required String question,
    @required String option1,
    @required GestureTapCallback onTapoption1,
    @required String option2,
    @required GestureTapCallback onTapoption2,
    @required String option3,
    @required GestureTapCallback onTapoption3,
    @required String option4,
    @required GestureTapCallback onTapoption4,
    @required Color opt1Color,
    @required Color opt2Color,
    @required Color opt3Color,
    @required Color opt4Color,
    @required int isBonus,
  }) {
    return Column(
      children: [
        isBonus == 1 ? _bonusQuestion(false) : emptyWidget,
        Container(
          decoration: BoxDecoration(
              color: kColorContainer,
              border: Border.all(
                color: isBonus == 1 ? kColorAccent : Colors.transparent,
              )),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSizes.blockSizeVertical * 1.5,
                horizontal: AppSizes.blockSizeHorizontal * 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppSizes.blockSizeHorizontal * 55.0,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              question,
                              style: textBody(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   "${isBonus == 1 ? "20" : "10"} " + "Points".tr,
                    //   style: textBody(
                    //       fontWeight: FontWeight.bold, color: Colors.black),
                    // ),
                  ],
                ),
                spacerWidget(height: AppSizes.blockSizeVertical * 2.0),

                Column(
                  children: [
                    Row(
                      children: [
                        _customSelectionBtn(
                            color: opt1Color,
                            btnLabel: option1,
                            onTap: onTapoption1),
                        spacerWidget(width: AppSizes.blockSizeVertical * 2.0),
                        _customSelectionBtn(
                            color: opt2Color,
                            btnLabel: option2,
                            onTap: onTapoption2),
                      ],
                    ),
                    Row(
                      children: [
                        _customSelectionBtn(
                            color: opt3Color,
                            btnLabel: option3,
                            onTap: onTapoption3),
                        spacerWidget(width: AppSizes.blockSizeVertical * 2.0),
                        _customSelectionBtn(
                            color: opt4Color,
                            btnLabel: option4,
                            onTap: onTapoption4),
                      ],
                    ),
                  ],
                ),
                // Container(
                //   height: AppSizes.blockSizeVertical * 20.0,
                //   child: GridView.builder(
                //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //           crossAxisSpacing: AppSizes.blockSizeHorizontal * 5.0,
                //           mainAxisSpacing: AppSizes.blockSizeVertical * 0.02,
                //           crossAxisCount: 2,
                //           childAspectRatio: AppSizes.blockSizeVertical * 0.26),
                //       itemCount: 4,
                //       itemBuilder: (_, index) {
                //         return _customSelectionBtn(
                //             btnLabel: option, onTap: onTapoption1);
                //       }),
                // )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _questionTf({
    @required String question,
    @required GestureTapCallback onTapTrue,
    @required GestureTapCallback onTapFalse,
    @required Color trueOptColor,
    @required Color falseOptColor,
    @required int isBonus,
  }) {
    return Column(
      children: [
        isBonus == 1 ? _bonusQuestion(false) : emptyWidget,
        Container(
          decoration: BoxDecoration(
            color: kColorContainer,
            border: Border.all(
              color: isBonus == 1 ? kColorAccent : Colors.transparent,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSizes.blockSizeVertical * 2.0,
                horizontal: AppSizes.blockSizeHorizontal * 7.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppSizes.blockSizeHorizontal * 55.0,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              question,
                              style: textBody(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   "${isBonus == 1 ? "20" : "10"} " + "Points".tr,
                    //   style: textBody(
                    //       fontWeight: FontWeight.bold, color: Colors.black),
                    // ),
                  ],
                ),
                spacerWidget(height: AppSizes.blockSizeVertical * 2.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    raisedBtnLg(
                        bgColor: trueOptColor,
                        btnHeight: AppSizes.blockSizeVertical * 0.6,
                        isScreenWidthBtn: false,
                        btnWidth: AppSizes.blockSizeHorizontal * 39.0,
                        borderRadius: 0.0,
                        context: null,
                        textColor: Colors.black,
                        onPressed: onTapTrue,
                        text: "Yes".tr),
                    raisedBtnLg(
                        bgColor: falseOptColor,
                        btnHeight: AppSizes.blockSizeVertical * 0.6,
                        isScreenWidthBtn: false,
                        btnWidth: AppSizes.blockSizeHorizontal * 39.0,
                        borderRadius: 0.0,
                        context: null,
                        textColor: Colors.black,
                        onPressed: onTapFalse,
                        text: "No".tr),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _bonusQuestion(bool blue) {
    return Container(
      color: blue ? Colors.blue : kColorAccent,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: AppSizes.blockSizeVertical * 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bonus".tr,
              style: textBody(color: blue ? kColorAccent : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customSelectionBtn({
    @required String btnLabel,
    @required GestureTapCallback onTap,
    @required Color color,
  }) {
    return raisedBtnLg(
        bgColor: color,
        btnHeight: AppSizes.blockSizeVertical * 0.6,
        isScreenWidthBtn: false,
        btnWidth: AppSizes.blockSizeHorizontal * 39.0,
        borderRadius: 0.0,
        context: null,
        textColor: Colors.black,
        onPressed: onTap,
        text: btnLabel);
  }
}
