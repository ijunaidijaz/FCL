import 'dart:convert';

import 'package:fcl/core/datamodels/competitionList_datamodel.dart' as compData;
import 'package:fcl/core/datamodels/competitionGiftList_datamodel.dart';
import 'package:fcl/core/datamodels/competition_adds_datamodel.dart';
import 'package:fcl/core/datamodels/currentUser_datamodel.dart';
import 'package:fcl/core/datamodels/leagueScore_datamodel.dart';
import 'package:fcl/core/datamodels/paymentResponse_datamodel.dart';
import 'package:fcl/core/datamodels/questionsGame_datamodel.dart';
import 'package:fcl/core/datamodels/weekQuizResult_datamodel.dart';
import 'package:fcl/core/datamodels/weeks_datamodel.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:fcl/utils/app_constants.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as _http;
import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

class CompetitionListViewModel extends BaseViewmodel {
  var competitionAddsData;
  int quizId;
  List mcqQuestionId = [];
  List tFQuestionId = [];
  List vSQuestionId = [];
  List mcqAnswer = [];
  List tFAnswer = [];
  List vSAnswer = [];
  int competitionId;
  int weekId;
  String weekDay;
  DateTime weekExpiry;
  DateTime weekCreated;

  DateTime competitionStartDate;
  DateTime competitionEndDate;

  var competitionListData;
  var competitionGiftListData;
  var questionsGameData;
  var weeksData;
  var weekQuizGameData;
  String authMsg,
      paymentUrl,
      competitionName,
      competitionAmount,
      custCountryCode,
      custContactNo,
      custName,
      custEmail,
      custRemarks;
  bool isQuestionsSubmitted = false;
  bool isFreeCompetitionSubscribed = false;
  bool isPAymentPaid = false;
  bool isPaymentSuccessfull = false;
  bool isPaymentProcessed = false;
  final GlobalKey<FormState> paymentFormKey = GlobalKey<FormState>();

  bool validateAndSave({
    @required FormState formstate,
  }) {
    final form = formstate;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<compData.CompetitionListDatamodel> getCompetitionData(
      {bool allCompetitions = false}) async {
    compData.CompetitionListDatamodel datamodel =
        compData.CompetitionListDatamodel();
    datamodel.data = compData.Data();
    datamodel.data.data = [];
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (competitionListData == null) {
      try {
        final response = await client.get(
          Uri.parse(kCompetitionListApi),
          headers: _setHeaders(),
        );
        print(response.body);
        final _competitionListData =
            compData.competitionListDatamodelFromJson(response.body);

        if (allCompetitions != true) {
          for (int i = 0; i < _competitionListData.data.data.length; i++) {
            if (_competitionListData.data.data[i].subscribe != null) {
              datamodel.data.data.add(_competitionListData.data.data[i]);
            }
          }
        }
        return allCompetitions ? _competitionListData : datamodel;
      } catch (e) {
        print("Track::CompetitionListPI error $e");
      }
    }
    return competitionListData;
  }

  Future<WeekQuizResultDatamodel> getWeekQuizResultData() async {
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();
    print("=========Week is is $weekId=======");
    try {
      final response = await client.get(
        Uri.parse(kweekQuizResultApi + weekId.toString()),
        headers: _setHeaders(),
      );
      print("========================== Here data is ===================");
      final _weekQuizGameData = weekQuizResultDatamodelFromJson(response.body);

      print(_weekQuizGameData);

      return _weekQuizGameData;
    } catch (e) {
      print("Track::WeekQuizResultPI error $e");
    }

    return competitionListData;
  }

  Future<CompetitionGiftListDatamodel> getCompetitionGiftData() async {
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (competitionGiftListData == null) {
      try {
        print("-------ID IS---------$competitionId------------------");
        final response = await client.get(
          Uri.parse("$kCompetitionGiftListApi ${competitionId.toString()}"),
          headers: _setHeaders(),
        );
        final _competitionGiftListData =
            competitionGiftListDatamodelFromJson(response.body);

        return _competitionGiftListData;
      } catch (e) {
        print("Track::CompetitionGiftListPI error $e");
      }
    }
    return competitionGiftListData;
  }

  Future<LeagueScoreDatamodel> getCompetitionLeagueData(
      {@required int comId}) async {
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (competitionGiftListData == null) {
      try {
        print("-----Com--ID IS---------$competitionId------------------");
        final response = await client.get(
          Uri.parse("$kLeagueScoreApi ${comId.toString()}/scoreList"),
          headers: _setHeaders(),
        );
        final _competitionGiftListData =
            leagueScoreDatamodelFromJson(response.body);

        return _competitionGiftListData;
      } catch (e) {
        print("Track::CompetitionGiftListPI error $e");
      }
    }
    return competitionGiftListData;
  }

  Future<QuestionsGameDatamodel> getQuestionsGameData({int weekId}) async {
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (questionsGameData == null) {
      try {
        print("--Week -----ID IS---------$weekId------------------");
        final response = await client.get(
          Uri.parse("$kQuestionsGameApi ${weekId.toString()}"),
          headers: _setHeaders(),
        );
        final _questionsGameData =
            questionsGameDatamodelFromJson(response.body);

        return _questionsGameData;
      } catch (e) {
        print("Track::QuestionsGameAPI error $e");
      }
    }
    return questionsGameData;
  }

  Future<WeeksDatamodel> getCompetitionWeekData() async {
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (weeksData == null) {
      try {
        print(
            "-----competition --ID IS---------$competitionId------------------");
        final response = await client.get(
          Uri.parse("$kWeeksApi ${competitionId.toString()}"),
          headers: _setHeaders(),
        );
        final _weeksData = weeksDatamodelFromJson(response.body);
        return _weeksData;
      } catch (e) {
        print("Track::WeeksAPI error $e");
      }
    }
    return weeksData;
  }

  Future<CompetitionAddsDatamodel> getCompetitionAddsData() async {
    String loginToken = await getLoginToken() ?? "";
    print("Token is $loginToken");
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();
    if (competitionAddsData == null) {
      print(
          "====hjhGET===Here compeition id is ${competitionId.toString()}========");
      try {
        final response = await client.get(
          Uri.parse("$kCompeitionAddsApi" + competitionId.toString() + "/all"),
          headers: _setHeaders(),
        );
        final _compeitionAddsData =
            competitionAddsDatamodelFromJson(response.body);

        return _compeitionAddsData;
      } catch (e) {
        print("Track::CompetitionAddsAPI error $e");
      }
    }

    return competitionAddsData;
  }

  Future<void> validateAndSubmitCGameQuestions() async {
    isQuestionsSubmitted = false;
    print("================$quizId here is=================");

    final _http.Client client = _http.Client();
    print("Quiz Id $competitionId");
    print("MCQ $mcqQuestionId");
    print("VS $vSQuestionId");
    print("TF $tFQuestionId");
    print("============Answers===========");
    print("VS $vSAnswer");
    print("Tf $tFAnswer");
    print("Mcqs  $mcqAnswer");

    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
          "Content-Type": "application/json",
        };
    setState(ViewState.kBusy);
    try {
      var data = {
        "McqQuestionID": mcqQuestionId,
        "McqAnswer": mcqAnswer,
        "TfQuestionID": tFQuestionId,
        "TfAnswer": tFAnswer,
        "VsQuestionID": vSQuestionId,
        "VsAnswer": vSAnswer,
        "QuizID": quizId
      };

      print(json.encode(data));
      var res = await client.post(
        Uri.parse(kSubmitQuizApi),
        body: json.encode(data),
        headers: _setHeaders(),
      );
      print(res.statusCode);
      var body = json.decode(res.body);
      print("==============here body is=====");

      print(body);
      if (body['status']) {
        tFAnswer.clear();
        mcqAnswer.clear();
        vSAnswer.clear();
        isQuestionsSubmitted = true;
      } else {
        authMsg = body['errorMessage'];
      }
    } catch (e) {
      print("Trace::Quiz Submit Api error $e");
      authMsg = e.message.toString();
    }
    setState(ViewState.kIdle);
  }

  Future<void> validateAndSubmitCompetitionPayment(
      {@required String paymentID, @required String amount}) async {
    String loginToken = await getLoginToken() ?? "";
    print("Here the competition Id is $competitionId");
    print("Here the Amount is $amount");

    _setHeaders() => {
      'Authorization': 'Bearer $loginToken',
      'Accept': 'application/json',
    };
    // setState(ViewState.kBusy);
    try {
      var data = {
        "competitionID": competitionId.toString(),
        "paymentID": paymentID,
        "period": kSubscribtionPeriod,
        "method": kPaymentMethod,
        "amount": amount,
      };

      var res = await _http.post(
        Uri.parse(kSubscribeCompetitiondApi),
        body: data,
        headers: _setHeaders(),
      );

      var body = json.decode(res.body);
      print(" **************************here subscription Body is $body");
      if (body['status']) {
        isPaymentSuccessfull = true;
        print(
            "============Finally Payment Info Saved to db=====================");

        authMsg = "Payment done successfully";
      } else {
        authMsg = body['errorMessage'];
      }
    } catch (e) {
      print("Trace:: Paymeny Submit Error${e.toString()}");
      authMsg = e.toString();
    }
    // setState(ViewState.kIdle);
  }

  Future<void> validateAndSubmitSubscribeFreeCompetition() async {
    isFreeCompetitionSubscribed = false;
    String loginToken = await getLoginToken() ?? "";
    print("Here the competition Id is $competitionId");

    _setHeaders() => {
      'Authorization': 'Bearer $loginToken',
      'Accept': 'application/json',
    };
    setState(ViewState.kBusy);
    try {
      var data = {
        "competitionID": competitionId.toString(),
      };

      var res = await _http.post(
        Uri.parse(kSubscribeFreeCompetitiondApi),
        body: data,
        headers: _setHeaders(),
      );

      var body = json.decode(res.body);
      print("Body is $body");
      if (body['status']) {
        isFreeCompetitionSubscribed = true;

        print("============Free Competition Subscribed=====================");

        authMsg = "Competition Subscribed successfully";
      } else {
        authMsg = body['errorMessage'];
      }
    } catch (e) {
      print("Trace:: Free Competition Subscribe Api Error${e.toString()}");
      authMsg = e.toString();
    }
    setState(ViewState.kIdle);
  }

  Future<void> validateAndSendPayment({@required int paymentMethodType}) async {
    final _http.Client client = _http.Client();
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
      'Authorization': 'Bearer $loginToken',
      'Accept': 'application/json',
    };
    print("===========Here payment type is $paymentMethodType");
    isPaymentSuccessfull = false;
    isPAymentPaid = false;
    isPaymentProcessed = false;
    // setState(ViewState.kBusy);
    try {
      final response = await client.get(
        Uri.parse(kCurrentUserApi),
        headers: _setHeaders(),
      );
      final currentUserData = currentUserDatamodelFromJson(response.body);
      print(currentUserData.data.email);
      print(currentUserData.data.id);
      print(currentUserData.data.fName);
      print(currentUserData.data.lName);
      print(currentUserData.data.phone);
      print(currentUserData.data.countryCode);

      var data = {
        'uid': kUserId,
        'pwd': kPassword,
        'secret': kSecret,
        // 'uid': 'tahseeeltest12',
        // 'pwd': 'tahseeeltest12',
        // 'secret': 'tahseeeltest12',

        'order_no': competitionId.toString(),
        'cust_name':
        currentUserData.data.fName + " " + currentUserData.data.lName,
        'order_amt': competitionAmount,
        'delivery_charges': '0',
        'total_items': '1',
        'cust_email': currentUserData.data.email,
        'phone_code': currentUserData.data.countryCode,
        'cust_mobile': currentUserData.data.phone,
        'callback_url': 'http://google.com/',
        'knet_allowed': '1',
        'cc_allowed': '1',
        'amex_allowed': '1',
        'remarks':
        "Username ${currentUserData.data.username} with userid ${currentUserData.data.id} subscribe to competition $competitionName by paying $competitionAmount KWD",
      };

      var res = await _http.post(
        Uri.parse(paymentMethodType == 0 ? kKnetCardApi : kCreditCardApi),
        body: data,
      );

      var body = json.decode(res.body);
      print("********************First Response is $body");
      if (body['error'] != true) {
        isPaymentProcessed = true;
        authMsg = body['msg'];
        paymentUrl = body['link'];
        print("-----URL is--------------$paymentUrl----------------------");
      } else {
        authMsg = body['msg'];
      }
    } catch (e) {
      print(e);
      authMsg = e.message.toString();
    }
    // setState(ViewState.kIdle);
  }

  Future<void> validateAndGetPaymentInfo(
      {@required String hash, @required orderId}) async {
    print(
        "=================here competiton ID is $competitionId =================");

    print("======Going for order info...............");

    setState(ViewState.kBusy);
    try {
      var data = {
        'uid': kUserId,
        'pwd': kPassword,
        'secret': kSecret,
        // 'uid': 'tahseeeltest12',
        // 'pwd': 'tahseeeltest12',
        // 'secret': 'tahseeeltest12',
        'id': orderId,
        'hash': hash,
      };

      var res = await _http.post(
        Uri.parse(kGetPaymentInfo),
        body: data,
      );

      print("*********************Response for order info is ${res.body}");

      final _response = paymentResponseDatamodelFromJson(res.body);

      print("********************Second Response is ${res.body}");

      if (_response.txInfo != null) {
        isPaymentSuccessfull = true;
        isPAymentPaid = true;

        print(
            "-=========transaction ID  ${_response.txInfo.trackId}================");
        authMsg = "Payment done successfully";
        validateAndSubmitCompetitionPayment(
            paymentID: _response.txInfo.trackId, amount: competitionAmount);
      } else {
        authMsg = "Payment not done, please try again later";
        print(
            "================Sorry transaction not possible====================");
      }
    } catch (e) {
      authMsg = "Payment not done, please try again later";
      setState(ViewState.kIdle);
      print("=============Here acception is============");
    }
     setState(ViewState.kIdle);
     setState(ViewState.kIdle);
  }
}
