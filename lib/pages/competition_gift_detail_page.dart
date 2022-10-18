import 'package:fcl/core/viewmodels/device_info.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_competition_adds.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:fcl/core/datamodels/competitionGiftList_datamodel.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';

import 'package:provider/provider.dart';
import 'package:get/get.dart';

class CompetitionGiftDetailPage extends StatefulWidget {
  const CompetitionGiftDetailPage({Key key}) : super(key: key);

  @override
  _CompetitionGiftDetailPageState createState() =>
      _CompetitionGiftDetailPageState();
}

class _CompetitionGiftDetailPageState extends State<CompetitionGiftDetailPage> {
  DeviceInfoViewmodel deviceInfoViewmodel = DeviceInfoViewmodel();

  @override
  void initState() {
    getDeviceInfo();
    super.initState();
  }

  getDeviceInfo() async {
    await deviceInfoViewmodel.validateAndSubmitDeviceInfo(
        screenName: "FCL gift page");
  }

  @override
  Widget build(BuildContext context) {
    final competitionListViewModel =
        Provider.of<CompetitionListViewModel>(context);
    return BaseScaffold(
        isDrawer: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSizes.blockSizeVertical * 3.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Gifts and Prizes".tr,
                    style: textSubTitle(fontWeight: FontWeight.bold),
                  ),
                ),
                spacerWidget(height: AppSizes.blockSizeVertical * 5.0),
                FutureBuilder<CompetitionGiftListDatamodel>(
                  future: competitionListViewModel.getCompetitionGiftData(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null ||
                          !snapshot.hasData ||
                          snapshot.data.data.data.isEmpty) {
                        return Container(
                          height: AppSizes.screenHeight / 2,
                          child: Center(
                            child: Text(
                              "No Gifts for this Competition".tr,
                              style: textBody(),
                            ),
                          ),
                        );
                      }
                      return Wrap(
                        children: [
                          Column(
                              children: List.generate(
                                  snapshot.data.data.data.length, (index) {
                            return _giftItem(
                                title: snapshot.data.data.data[index].title,
                                desc:
                                    snapshot.data.data.data[index].description,
                                // winPoints:
                                //     snapshot.data.data.data[index].winPoint,
                                imgUrl: kImgBaseUrl +
                                    snapshot.data.data.data[index].image,
                                position: position(snapshot
                                    .data.data.data[index].number
                                    .toString()));
                          })),
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
            ),
          ),
        ));
  }

  position(String numb) {
    if (numb == "1") {
      return numb + "st";
    } else if (numb == "2") {
      return numb + "nd";
    } else if (numb == "3") {
      return numb + "rd";
    } else {
      return numb + "th";
    }
  }

  Widget _giftItem({
    @required String title,
    @required String desc,
    @required String imgUrl,
    // @required String winPoints,
    @required String position,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.blockSizeVertical * 2.0),
      child: Column(
        children: [
          Container(
            color: kColorAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.blockSizeVertical * 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$position" + 'Position'.tr,
                    style: textBody(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: kColorContainer,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.blockSizeVertical * 2.5,
                  horizontal: AppSizes.blockSizeHorizontal * 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImagePixels.container(
                      imageProvider: NetworkImage(imgUrl),
                      colorAlignment: Alignment.topLeft,
                      child: Container(
                        width: AppSizes.blockSizeHorizontal * 25.0,
                        height: AppSizes.blockSizeVertical * 10.0,
                        alignment: Alignment.center,
                        child: Container(
                          width: 1000,
                          height: 428,
                          child: Image(image: NetworkImage(imgUrl)),
                        ),
                      )),
                  spacerWidget(width: AppSizes.blockSizeHorizontal * 3.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: textBody(
                              fontSize: AppSizes.blockSizeVertical * 1.8,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Divider(
                          height: AppSizes.blockSizeVertical * 3.0,
                          endIndent: AppSizes.blockSizeHorizontal * 40.0,
                          thickness: AppSizes.blockSizeHorizontal * 0.5,
                          color: Colors.black,
                        ),
                        Text(
                          desc,
                          textAlign: TextAlign.justify,
                          style: textBody(
                              fontSize: AppSizes.blockSizeVertical * 1.7,
                              color: Colors.black),
                        ),
                        spacerWidget(height: AppSizes.blockSizeVertical * 1.0),
                        // Container(
                        //   color: kColorAccent,
                        //   child: Padding(
                        //     padding:
                        //         EdgeInsets.all(AppSizes.blockSizeHorizontal),
                        //     child: Text(
                        //       "points for lucky winner $winPoints",
                        //       textAlign: TextAlign.justify,
                        //       style: textBody(
                        //           fontSize: AppSizes.blockSizeVertical * 1.7,
                        //           color: Colors.black),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
