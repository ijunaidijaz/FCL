// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:fcl/pages/competition_deadlines_page.dart';
import 'package:fcl/pages/competition_gift_detail_page.dart';
import 'package:fcl/pages/competition_gift_list_page.dart';
import 'package:fcl/pages/competition_league_list_page.dart';
import 'package:fcl/pages/competition_result_list_page%20.dart';
import 'package:fcl/pages/contact_us_page.dart';
import 'package:fcl/pages/edit_profile_pic_page.dart';
import 'package:fcl/pages/forget_password_page.dart';
import 'package:fcl/pages/game_week_history_detail_page.dart';
import 'package:fcl/pages/league_detail_page.dart';
import 'package:fcl/pages/master_views/weeks_page.dart';
import 'package:fcl/pages/onboadring_page.dart';
import 'package:fcl/pages/payment_recipt_page.dart';
import 'package:fcl/pages/new_password_page.dart';
import 'package:fcl/pages/password_success_page.dart';
import 'package:fcl/pages/about_us_page.dart';
import 'package:fcl/pages/chnage_password_page.dart';
import 'package:fcl/pages/competition_rules_page.dart';
import 'package:fcl/pages/game_week_history_page.dart';
import 'package:fcl/pages/language_page.dart';
import 'package:fcl/pages/login_page.dart';
import 'package:fcl/pages/news_page.dart';
import 'package:fcl/pages/notifications_page.dart';
import 'package:fcl/pages/payment_page.dart';
import 'package:fcl/pages/questions_page.dart';
import 'package:fcl/pages/signup_page.dart';
import 'package:fcl/pages/main_page.dart';
import 'package:fcl/pages/edit_profile_page.dart';
import 'package:fcl/pages/subscription_details_page.dart';
import 'package:fcl/pages/weeks_deadline_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:auto_route/router_utils.dart';

class NavRouter {
  // static const questionGamePage = '/questionGame-page';
  static const questionsPage = '/questions-page';
  static const mainPage = '/main-page';
  static const loginPage = '/login-page';
  static const signupPage = '/signup-page';
  // static const activateEmailPage = '/activateEmail-page';
  static const languagePage = '/language-page';
  static const editProfilePage = '/edirProfile-page';
  static const editProfilePicPage = '/edirProfilePic-page';
  static const aboutUsPage = '/aboutUsPage-page';
  static const onBoardingPage = '/onBoarding-page';
  static const competitionResultListPage = '/competitionResultList-page';
  static const paymentReciptPage = '/paymentRecipt-page';
  static const weeksDeadlinePage = '/weeksDeadline-page';
  static const competitionsRulesPage = '/competitionsRules-page';
  static const subscriptionDetailPage = '/subscriptionDetail-page';
  static const paymentPage = '/payment-page';
  static const weeksPage = '/weeks-page';
  static const newsPage = '/news-page';
  static const newsDetailPage = '/newsDetail-page';
  static const notificationsPage = '/notifications-page';
  static const competitionsListPage = '/competitionsList-page';
  static const leagueDetailPage = '/competitionDetail-page';
  // static const welcomePage = '/welcome-page';
  static const changePasswordPage = '/changePassword-page';
  static const gameWeeksHistoryPage = '/gameWeeksHistory-page';
  static const gameWeeksHistoryDetailPage = '/gameWeeksHistoryDetail-page';
  static const forgetPasswordPage = '/forgetPassword-page';
  static const verifyCodePage = '/verifyCode-page';
  static const newPasswordPage = '/newPassword-page';
  static const passwordSuccessPage = '/passwordSuccess-page';
  static const competitionGiftListPage = '/competitionGiftList-page';
  static const competitionGiftDetailPage = '/competitionGiftDetail-page';
  static const competitionDeadlinesPage = '/competitionDeadlines-page';
  static const competitionLeagueListPage = '/competitionLeagueList-page';
  static const contactUsPage = '/contactUs-page';

  // static GlobalKey<NavigatorState> get navigatorKey =>
  // getNavigatorKey<Router>();
  static GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {

      // //questionGamePage-route
      // case NavRouter.questionGamePage:
      //   if (hasInvalidArgs<Key>(args)) {
      //     return misTypedArgsRoute<Key>(args);
      //   }
      //   return MaterialPageRoute(
      //     builder: (_) => QuestionGamePage(),
      //     settings: settings,
      //   );

      //questionsPage-route
      case NavRouter.questionsPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => QuestionsPage(),
          settings: settings,
        );
      //onBoadringPage-route
      case NavRouter.onBoardingPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => OnBoardingPage(),
          settings: settings,
        );
      //competitionsDeadlinesPage-route
      case NavRouter.competitionDeadlinesPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => CompetitionDeadlinesPage(),
          settings: settings,
        );
      //weeksDeadlinePage-route
      case NavRouter.weeksDeadlinePage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => WeeksDeadlinePage(),
          settings: settings,
        );

      //competitionsLeagueListPage-route
      case NavRouter.competitionLeagueListPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => CompetitionLeagueListPage(),
          settings: settings,
        );

      //competitionResultListPage-route
      case NavRouter.competitionResultListPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => CompetitionResultListPage(),
          settings: settings,
        );
      //weeksPage-route
      case NavRouter.weeksPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => WeeksPage(),
          settings: settings,
        );

      //verifyCodePage-route
      // case NavRouter.verifyCodePage:
      //   // if (hasInvalidArgs<Key>(args)) {
      //   //   return misTypedArgsRoute<Key>(args);
      //   // }
      //   return MaterialPageRoute(
      //     builder: (_) => VerifyCodePage(
      //       onSubmit: () {},
      //       isActivateEmail: false,
      //     ),
      //     settings: settings,
      //   );
      //paymentReciptPage-route
      case NavRouter.paymentReciptPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => PaymentReciptPage(),
          settings: settings,
        );
      //ActivateEmailPage-route
      // case NavRouter.activateEmailPage:
      //   if (hasInvalidArgs<Key>(args)) {
      //     return misTypedArgsRoute<Key>(args);
      //   }
      //   return MaterialPageRoute(
      //     builder: (_) => VerifyCodePage(),
      //     settings: settings,
      //   );
      //newPasswordPage-route
      case NavRouter.newPasswordPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => NewPasswordPage(),
          settings: settings,
        );

      //passwordSuccessPage-route
      case NavRouter.passwordSuccessPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => PasswordSuccessPage(),
          settings: settings,
        );

      //mainPage-route
      case NavRouter.mainPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => MainPage(),
          settings: settings,
        );
      //contactUsPage-route
      case NavRouter.contactUsPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => ContactUsPage(),
          settings: settings,
        );

      //forgetPasswordPage-route
      case NavRouter.forgetPasswordPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordPage(),
          settings: settings,
        );

      //competitionGiftListPage-route
      case NavRouter.competitionGiftListPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => CompetitionGiftListPage(),
          settings: settings,
        );

      //competitionGiftDetalPage-route
      case NavRouter.competitionGiftDetailPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => CompetitionGiftDetailPage(),
          settings: settings,
        );

      //welcomePage-route
      // case NavRouter.welcomePage:
      //   if (hasInvalidArgs<Key>(args)) {
      //     return misTypedArgsRoute<Key>(args);
      //   }
      //   return MaterialPageRoute(
      //     builder: (_) => WelcomePage(),
      //     settings: settings,
      //   );

      //gameWeeksHistoryPage-route
      case NavRouter.gameWeeksHistoryPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => GameWeeksHistory(),
          settings: settings,
        );

      //gameWeeksHistoryDetailPage-route
      case NavRouter.gameWeeksHistoryDetailPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => GameWeekHistoryDetailPage(),
          settings: settings,
        );

      //changePasswordPage-route
      case NavRouter.changePasswordPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => ChangePasswordPage(),
          settings: settings,
        );

      //competitionDetailPage-route
      case NavRouter.leagueDetailPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => LeagueDetailPage(),
          settings: settings,
        );

      //newsPage-route
      case NavRouter.newsPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => NewsPage(),
          settings: settings,
        );

      //notificationsPage-route
      case NavRouter.notificationsPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => NotificationsPage(),
          settings: settings,
        );

      // //newsDetailPage-route
      // case NavRouter.newsDetailPage:
      //   if (hasInvalidArgs<Key>(args)) {
      //     return misTypedArgsRoute<Key>(args);
      //   }
      //   return MaterialPageRoute(
      //     builder: (_) => NewsDetailPage(),
      //     settings: settings,
      //   );

      //paymentPage-route
      case NavRouter.paymentPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => PaymentPage(),
          settings: settings,
        );

      //SubscriptionDetailPage-route
      case NavRouter.subscriptionDetailPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => SubscriptionDetailPage(),
          settings: settings,
        );

      //aboutUsPage-route
      case NavRouter.aboutUsPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => AboutUsPage(),
          settings: settings,
        );

      //competitionsRulesPage-route
      case NavRouter.competitionsRulesPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => CompetitionsRulesPage(),
          settings: settings,
        );

      //loginPage-route
      case NavRouter.loginPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
          settings: settings,
        );

      //editProfilePage-route
      case NavRouter.editProfilePage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => EditProfilePage(),
          settings: settings,
        );

      //editProfilePicPage-route
      case NavRouter.editProfilePicPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => EditProfilePic(),
          settings: settings,
        );
      //signupPage-route
      case NavRouter.signupPage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => SignupPage(),
          settings: settings,
        );

      //languagePage-route
      case NavRouter.languagePage:
        // if (hasInvalidArgs<Key>(args)) {
        //   return misTypedArgsRoute<Key>(args);
        // }
        return MaterialPageRoute(
          builder: (_) => LanguagePage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => MainPage(),
          settings: settings,
        );
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************
