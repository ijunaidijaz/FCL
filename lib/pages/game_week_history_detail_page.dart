import 'package:fcl/core/datamodels/weekQuizResult_datamodel.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_date_format.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_competition_adds.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';

import 'package:fcl/widgets/empty_widget.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class GameWeekHistoryDetailPage extends StatelessWidget {
  const GameWeekHistoryDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final competitionListViewModel =
    Provider.of<CompetitionListViewModel>(context);
    return BaseScaffold(
      isDrawer: false,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSizes.blockSizeVertical * 5.0),
            child: Column(
              children: [
                Text(
                  "${competitionListViewModel.weekDay} (${dateFormat(competitionListViewModel.weekExpiry)})",
                  style: textTitle(),
                  textAlign: TextAlign.center,
                ),
                spacerWidget(height: AppSizes.blockSizeVertical * 3.0),
                FutureBuilder<WeekQuizResultDatamodel>(
                  future: competitionListViewModel.getWeekQuizResultData(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null || !snapshot.hasData) {
                        return Padding(
                          padding: EdgeInsets.only(top: AppSizes.screenHeight / 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sorry you have missed the quiz its already expired. Please stay tuned for our upcoming quizzes.",
                                textAlign: TextAlign.center,
                                style: textBody(),
                              ),

                            ],
                          ),
                        );
                      }
                      return Column(
                        children: [
                          snapshot.data.data.mcqResult.length > 0
                              ? Column(
                            children: List.generate(
                                snapshot.data.data.mcqResult.length,
                                    (index) {
                                  return _answerTile(
                                      points: snapshot.data.data
                                          .mcqResult[index].bonus
                                          ? "20"
                                          : "10",
                                      date: timeAgo(competitionListViewModel
                                          .weekCreated),
                                      yourAnswer: snapshot.data.data
                                          .mcqResult[index].userAnswer,
                                      question: snapshot.data.data
                                          .mcqResult[index].question,
                                      correctAnswer: snapshot
                                          .data.data.mcqResult[index].answer,
                                      isAnwerTrue: snapshot.data.data
                                          .mcqResult[index].answerStatus);
                                }),
                          )
                              : emptyWidget,
                          snapshot.data.data.tfResult.length > 0
                              ? Column(
                            children: List.generate(
                                snapshot.data.data.tfResult.length,
                                    (index) {
                                  return _answerTile(
                                      points: snapshot
                                          .data.data.tfResult[index].bonus
                                          ? "20"
                                          : "10",
                                      date: timeAgo(competitionListViewModel
                                          .weekCreated),
                                      yourAnswer: snapshot.data.data
                                          .tfResult[index].userAnswer,
                                      question: snapshot
                                          .data.data.tfResult[index].question,
                                      correctAnswer: snapshot
                                          .data.data.tfResult[index].answer,
                                      isAnwerTrue: snapshot.data.data
                                          .tfResult[index].answerStatus);
                                }),
                          )
                              : emptyWidget,
                          snapshot.data.data.vsResult.length > 0
                              ? Column(
                            children: List.generate(
                                snapshot.data.data.vsResult.length,
                                    (index) {
                                  return _answerTile(
                                      points: snapshot
                                          .data.data.vsResult[index].bonus
                                          ? "20"
                                          : "10",
                                      date: timeAgo(competitionListViewModel
                                          .weekCreated),
                                      yourAnswer: snapshot.data.data
                                          .vsResult[index].userAnswer,
                                      question: snapshot
                                          .data.data.vsResult[index].question,
                                      correctAnswer: snapshot
                                          .data.data.vsResult[index].answer,
                                      isAnwerTrue: snapshot.data.data
                                          .vsResult[index].answerStatus);
                                }),
                          )
                              : emptyWidget,
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
            )),
      ),
    );
  }

  Widget _answerTile({
    @required bool isAnwerTrue,
    dynamic correctAnswer,
    @required String question,
    @required dynamic yourAnswer,
    @required String points,
    @required String date,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.blockSizeVertical * 2.0),
      child: Container(
        decoration: BoxDecoration(
            color: kColorContainer,
            borderRadius: BorderRadius.all(
                Radius.circular(AppSizes.blockSizeVertical * 4.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.blockSizeVertical * 0.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                  EdgeInsets.only(left: AppSizes.blockSizeVertical * 3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question,
                        style: textBody(
                            fontSize: AppSizes.blockSizeVertical * 1.9,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSizes.blockSizeVertical * 1.5),
                        child: Row(
                          children: [
                            Container(
                              color: kColorAccent,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                    AppSizes.blockSizeHorizontal * 3.2,
                                    vertical: AppSizes.blockSizeHorizontal),
                                child: Text(
                                  "$yourAnswer",
                                  textAlign: TextAlign.justify,
                                  style: textBody(
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                      AppSizes.blockSizeVertical * 1.7,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            spacerWidget(
                                width: AppSizes.blockSizeHorizontal * 1.8),
                            Text(
                              "$points " + "Points".tr,
                              style: textBody(
                                  fontSize: AppSizes.blockSizeVertical * 1.7,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        date,
                        textAlign: TextAlign.justify,
                        style: textBody(
                            fontSize: AppSizes.blockSizeVertical * 1.5,
                            color: Colors.black),
                      ),
                      spacerWidget(height: AppSizes.blockSizeVertical * 1.0),
                      isAnwerTrue
                          ? emptyWidget
                          : Text(
                        "Correct Answer:".tr + " $correctAnswer",
                        textAlign: TextAlign.justify,
                        style: textBody(
                            fontSize: AppSizes.blockSizeVertical * 1.6,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color:
                    isAnwerTrue ? HexColor('#27C004') : HexColor('#C00404'),
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.blockSizeVertical * 4.0))),
                height: AppSizes.blockSizeVertical * 18.0,
                width: AppSizes.blockSizeHorizontal * 20.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isAnwerTrue
                          ? FontAwesomeIcons.check
                          : FontAwesomeIcons.times,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}