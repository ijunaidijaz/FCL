import 'package:fcl/core/viewmodels/device_info.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_general_adds.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';

class NewsDetailPage extends StatefulWidget {
  final String imgUrl;
  final String title;
  final String description;
  final String time;
  NewsDetailPage(
      {Key key,
      @required this.imgUrl,
      @required this.description,
      @required this.time,
      @required this.title})
      : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  DeviceInfoViewmodel deviceInfoViewmodel = DeviceInfoViewmodel();
  @override
  void initState() {
    getDeviceInfo();

    super.initState();
  }

  getDeviceInfo() async {
    await deviceInfoViewmodel.validateAndSubmitDeviceInfo(
        screenName: "FCL News Details Page");
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isScafoldWhite: true,
        horizontalPadding: 0.0,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                fit: BoxFit.fitWidth,
                height: AppSizes.blockSizeVertical * 40.0,
                width: AppSizes.screenWidth,
                image: NetworkImage(this.widget.imgUrl),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.blockSizeHorizontal * 12.0,
                    vertical: AppSizes.blockSizeVertical * 4.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.widget.title,
                        style: textSubTitle(
                            fontSize: AppSizes.blockSizeVertical * 2.3,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      spacerWidget(height: AppSizes.blockSizeVertical),
                      Text(
                        this.widget.time,
                        style: textBody(
                            fontSize: AppSizes.blockSizeVertical * 1.8,
                            color: Colors.black),
                      ),
                      Divider(
                        height: AppSizes.blockSizeVertical * 3.5,
                        endIndent: AppSizes.blockSizeHorizontal * 60.0,
                        thickness: AppSizes.blockSizeHorizontal * 0.5,
                        color: kColorAccent,
                      ),
                      Text(
                        this.widget.description,
                        style: textBody(
                            color: Colors.black,
                            fontSize: AppSizes.blockSizeVertical * 2.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSizes.blockSizeVertical * 2.5),
                        child: GeneralAdssWidget(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
