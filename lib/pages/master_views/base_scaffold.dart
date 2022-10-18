import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:fcl/core/viewmodels/cloud_messaging_viewmodel.dart';
import 'package:fcl/core/viewmodels/socialLinks_viewmodel.dart.dart';
import 'package:fcl/pages/login_page.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:fcl/widgets/empty_widget.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:fcl/core/viewmodels/currentUser_viewmodel.dart';
import 'package:fcl/core/viewmodels/sponsers_viewmodel.dart';
import 'package:fcl/core/datamodels/currentUser_datamodel.dart';
import 'package:fcl/core/datamodels/sponsers_datamodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class BaseScaffold extends StatefulWidget {
  final Widget body;
  final bool isAppbar;
  final bool isDrawer;
  final bool isAction;
  final bool isCenterTitle;
  final String centerTitle;
  final double horizontalPadding;
  final bool isScafoldWhite;
  final bool isBackBtn;
  final isCenterLogo;

  BaseScaffold(
      {Key key,
      @required this.body,
      this.isAppbar = true,
      this.isAction = true,
      this.isCenterTitle = true,
      this.isBackBtn = true,
      this.centerTitle,
      this.isScafoldWhite = false,
      this.horizontalPadding = 7.0,
      this.isCenterLogo = true,
      this.isDrawer = false})
      : super(key: key);

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  SocialLinksViewModel socialLinksViewModel = SocialLinksViewModel();
  CurrentUserViewModel currentUserViewModel = CurrentUserViewModel();
  Future userData;
  bool _isNetworkConnected = true;
  Connectivity _connectivity;
  StreamSubscription _subscription;
  var socialLinkData;

  @override
  void initState() {
    _connectivity = Connectivity();
    _subscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        setState(() {
          //Conncted to mobile or wifi
          print("----------------------Internet Connected-----------------");
          _isNetworkConnected = true;
        });
      } else {
        setState(() {
          print("----------------------Internet Not Connected-----------------");
          _isNetworkConnected = false;
        });
      }
    });
    getSocialLinks();
    getCurrentUserData();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  getCurrentUserData() {
    userData = currentUserViewModel.getCurrentUserData();
  }

  getSocialLinks() async {
    if (await socialLinksViewModel.getSocialLinksDataData() != null) {
      socialLinkData = await socialLinksViewModel.getSocialLinksDataData();
    }


    // print(socialLinkData.data[1].socialName);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    final sponsersViewModel = Provider.of<SponsersViewModel>(context);
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(kColorPrimary.withOpacity(0.1), BlendMode.color),
          child: Image(
              fit: BoxFit.cover,
              height: AppSizes.screenHeight,
              width: AppSizes.screenWidth,
              image: AssetImage("assets/images/Layer 1047 copy 7@1X.png")),
        ),
        Container(
          height: AppSizes.screenHeight,
          width: AppSizes.screenWidth,
          color: widget.isScafoldWhite ? Colors.white : kColorPrimary.withOpacity(0.6),
        ),
        _isNetworkConnected
            ? Scaffold(
                backgroundColor: Colors.transparent,
                drawerEnableOpenDragGesture: false,
                key: _drawerKey,
                drawer: widget.isDrawer
                    ? FutureBuilder<CurrentUserDatamodel>(
                        future: userData,
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            var userData = snapshot.data.data;
                            if (snapshot.data == null || !snapshot.hasData) {
                              return Center(
                                child: Text(
                                  'No data'.tr,
                                  style: textBody(),
                                ),
                              );
                            }
                            return _drawer(
                                socialLinkData: socialLinkData,
                                context: context,
                                imgWidget: userData.image != null
                                    ? NetworkImage(kImgBaseUrl + userData.image)
                                    : AssetImage("assets/images/default-avatar.png"),
                                playerId: userData.id?.toString(),
                                userName: userData?.username);
                          } else {
                            return Container(child: Center(child: progressIndicator()));
                          }
                        },
                      )
                    : null,
                appBar: widget.isAppbar ? _appBar(context: context, sponsersViewModel: sponsersViewModel,

                drawerCallBack: ()async{
                  print("====Drawer is Opening===========");
                  // _drawerKey.currentState.openDrawer();

                  print("=======Data of user =====$userData");


                  if(userData!=null){
                    _drawerKey.currentState.openDrawer();
                  }else{

                    showToast(msg: "Authentication Error - Please Login again".tr);

                   // await Future.delayed(Duration(seconds: 3));
                    _onLogout();

                    // NavRouter.navigator.pushNamedAndRemoveUntil(
                    //     NavRouter.loginPage, (route) => false);
                  }
                }

                ) : null,
                body: Padding(padding: EdgeInsets.symmetric(horizontal: AppSizes.blockSizeHorizontal * widget.horizontalPadding), child: widget.body),
              )
            : Container(
                child: Center(
                  child: Image.asset("assets/images/no-internet.png"),
                ),
              ),
      ],
    );
  }

  Widget _drawer(
      {@required BuildContext context,
      @required String userName,
      @required dynamic socialLinkData,
      @required ImageProvider imgWidget,
      @required String playerId}) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: kColorPrimary,
      ),
      child: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: AppSizes.blockSizeVertical * 4.0),
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        maxRadius: AppSizes.blockSizeVertical * 6.0,
                        backgroundImage: imgWidget,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSizes.blockSizeVertical * 0.8),
                        child: Text(
                          userName,
                          style: textBody(color: kColorAccent),
                        ),
                      ),
                      Text(
                        'Player ID:'.tr + playerId,
                        style: textBody(),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: ListView.separated(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: AppSizes.blockSizeHorizontal * 4.0),
                        child: ListTile(
                            title: Text(
                              drawerListItems[index].name,
                              style: textBody(fontSize: AppSizes.blockSizeVertical * 1.6),
                            ),
                            onTap: drawerListItems[index].ontap),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: AppSizes.blockSizeVertical * 0.2,
                        indent: AppSizes.blockSizeHorizontal * 5.0,
                        endIndent: AppSizes.blockSizeHorizontal * 5.0,
                        color: Colors.white,
                      );
                    },
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.blockSizeVertical * 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Follow Us'.tr,
                      style: textBody(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSizes.blockSizeVertical * 1.0,
                        bottom: AppSizes.blockSizeVertical * 4.0,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              _launchEmail(recipent: socialLinkData.data[0].link);

                              // if (await canLaunch(socialLinkData.data[2].link))
                              //   await launch(socialLinkData.data[2].link);
                              // else
                              //   // can't launch url, there is some error
                              //   throw "Could not launch ${socialLinkData.data[2].socialName}";
                            },
                            child: SvgPicture.asset('assets/icons/gmail.svg', height: AppSizes.blockSizeVertical * 2.8, color: Colors.white),
                          ),
                          spacerWidget(width: AppSizes.blockSizeHorizontal * 3.0),
                          InkWell(
                            onTap: () async {
                              if (await canLaunch(socialLinkData.data[2].link))
                                await launch(socialLinkData.data[2].link);
                              else
                                // can't launch url, there is some error
                                throw "Could not launch ${socialLinkData.data[2].socialName}";
                            },
                            child: SvgPicture.asset('assets/icons/instagram.svg', height: AppSizes.blockSizeVertical * 2.5, color: Colors.white),
                          ),
                          spacerWidget(width: AppSizes.blockSizeHorizontal * 3.0),
                          InkWell(
                            onTap: () async {
                              if (await canLaunch(socialLinkData.data[1].link))
                                await launch(socialLinkData.data[1].link);
                              else
                                // can't launch url, there is some error
                                throw "Could not launch ${socialLinkData.data[1].socialName}";
                            },
                            child: SvgPicture.asset('assets/icons/twitter.svg', height: AppSizes.blockSizeVertical * 2.5, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _launchEmail({@required String recipent}) async {
    Email email = Email(
      to: [recipent],
    );

    await EmailLauncher.launch(email);
  }

  Widget _appBar({@required BuildContext context, @required SponsersViewModel sponsersViewModel, Function drawerCallBack}) {
    return AppBar(
      brightness: Brightness.dark,
      centerTitle: widget.isCenterTitle,
      leadingWidth: AppSizes.blockSizeVertical * 8.0,
      leading: widget.isDrawer != true
          ? IconButton(
              icon: Icon(
                Icons.chevron_left_outlined,
              ),
              onPressed: () => Navigator.pop(context),
            )
          : IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => drawerCallBack()
      ),
      backgroundColor: kColorPrimary,
      title: widget.isCenterLogo
          ? Image(
              height: AppSizes.blockSizeVertical * 15.0,
              // width: AppSizes.blockSizeHorizontal * 15.0,
              width: AppSizes.blockSizeHorizontal * 18.0,
              image: AssetImage('assets/images/logo.png'))
          : Text(
              widget.centerTitle,
              style: textBody(fontSize: AppSizes.blockSizeVertical * 2.3),
            ),
      actions: [
        widget.isAction
            ? Padding(
                padding: EdgeInsets.only(right: AppSizes.blockSizeHorizontal * 4.0, left: AppSizes.blockSizeHorizontal * 4.0),
                child: InkWell(
                  onTap: () => alertDialogSponsers(context: context, sponsersViewModel: sponsersViewModel),
                  child: Image(
                      height: AppSizes.blockSizeVertical * 12.0,
                      width: AppSizes.blockSizeHorizontal * 10.5,
                      image: AssetImage('assets/images/sponsor.png')),
                ),
              )
            : emptyWidget,
      ],
    );
  }

  alertDialogSponsers({@required BuildContext context, @required SponsersViewModel sponsersViewModel}) {
    // set up the AlertDialog
    Widget alert = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.blockSizeHorizontal * 0.0,
      ),
      child: Center(
        child: Dialog(
          child: Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kColorAccent,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.blockSizeVertical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Our Sponsers'.tr,
                        style: textBody(color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.blockSizeVertical * 4.0, horizontal: AppSizes.blockSizeHorizontal * 1.5),
                  child: FutureBuilder<SponsersDatamodel>(
                    future: sponsersViewModel.getSponsersData(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null || !snapshot.hasData) {
                          return Center(
                            child: Text(
                              'No data'.tr,
                              style: textBody(),
                            ),
                          );
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.data.data?.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppSizes.blockSizeVertical * 0.5,
                            mainAxisSpacing: AppSizes.blockSizeHorizontal * 0.3,
                          ),
                          itemBuilder: (_, index) {
                            return Column(
                              children: [
                                Image(
                                    height: AppSizes.blockSizeVertical * 10.0,
                                    image: NetworkImage(kImgBaseUrl + snapshot.data.data.data[index].image)),
                                spacerWidget(height: AppSizes.blockSizeVertical),
                                Text(
                                  snapshot.data.data.data[index].competition.name,
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return Container(height: AppSizes.screenHeight / 2, child: Center(child: progressIndicator()));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final drawerListItems = [
    DrawerMenuDatamodel(name: "Home".tr, ontap: () => NavRouter.navigator.popAndPushNamed(NavRouter.mainPage)),
    // DrawerMenuDatamodel(
    //     name: "Language:".tr + " " + 'SelectedLanguage'.tr,
    //     ontap: () =>
    //         NavRouter.navigator.popAndPushNamed(NavRouter.languagePage)),
    DrawerMenuDatamodel(name: "Profile".tr, ontap: () => NavRouter.navigator.popAndPushNamed(NavRouter.editProfilePage)),
    DrawerMenuDatamodel(name: "News".tr, ontap: () => NavRouter.navigator.popAndPushNamed(NavRouter.newsPage)),
    DrawerMenuDatamodel(name: "Subscription Details".tr, ontap: () => NavRouter.navigator.popAndPushNamed(NavRouter.subscriptionDetailPage)),
    DrawerMenuDatamodel(name: "About App".tr, ontap: () => NavRouter.navigator.popAndPushNamed(NavRouter.aboutUsPage)),
    DrawerMenuDatamodel(name: "FCL Rules".tr, ontap: () => NavRouter.navigator.popAndPushNamed(NavRouter.competitionsRulesPage)),
    DrawerMenuDatamodel(name: "Notifications".tr, ontap: () => NavRouter.navigator.popAndPushNamed(NavRouter.notificationsPage)),
    DrawerMenuDatamodel(name: "Logout".tr, ontap: () => _onLogout()),
  ];
}

_onLogout() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  await CloudMessaging().deleteToken();
  localStorage.remove('data');
  // NavRouter.navigator.pushAndRemoveUntil(
  //     MaterialPageRoute(
  //       builder: (context) => LoginPage(),
  //     ),
  //     ModalRoute.withName('/login-page'));

  // NavRouter.navigator.popUntil(ModalRoute.withName(NavRouter.mainPage));

  NavRouter.navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      ModalRoute.withName('/login-page'));
}

class DrawerMenuDatamodel {
  final String name;
  final GestureTapCallback ontap;

  DrawerMenuDatamodel({@required this.name, @required this.ontap});
}
