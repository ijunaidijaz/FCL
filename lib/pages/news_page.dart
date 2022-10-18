import 'package:fcl/core/datamodels/news_datamodel.dart';
import 'package:fcl/core/viewmodels/device_info.dart';
import 'package:fcl/core/viewmodels/news_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_date_format.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';

import 'package:fcl/pages/news_detail_page.dart';
import 'package:fcl/widgets/app_general_adds.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  DeviceInfoViewmodel deviceInfoViewmodel = DeviceInfoViewmodel();
  @override
  void initState() {
    getDeviceInfo();

    super.initState();
  }

  getDeviceInfo() async {
    await deviceInfoViewmodel.validateAndSubmitDeviceInfo(
        screenName: "FCL News Page");
  }

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context);
    return BaseScaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.blockSizeVertical * 5.0),
              child: Text(
                "News".tr,
                style: textTitle(),
              ),
            ),
            FutureBuilder<NewsDatamodel>(
              future: newsViewModel.getNewsData(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null || !snapshot.hasData) {
                    return Center(
                      child: Text(
                        "No data".tr,
                        style: textBody(),
                      ),
                    );
                  }
                  return Wrap(
                    children: [
                      Column(
                          children: List.generate(
                              snapshot.data.data.data.length, (index) {
                        var newsTitle = snapshot.data.data.data[index].title;
                        var newsImg =
                            "http://fclkw.com/storage/app/public/${snapshot.data.data.data[index].image}";
                        var newsDesc =
                            snapshot.data.data.data[index].description;
                        var newsDate = snapshot.data.data.data[index].createdAt;

                        return _newsCard(
                            title: newsTitle,
                            imgUrl: newsImg,
                            description: newsDesc,
                            time: timeAgo(newsDate),
                            ontap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsDetailPage(
                                            time: timeAgo(newsDate),
                                            description: newsDesc,
                                            title: newsTitle,
                                            imgUrl: newsImg,
                                          )),
                                ));
                      })),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: AppSizes.blockSizeHorizontal * 24.0),
                      //   child: raisedBtnLg(
                      //       borderRadius: AppSizes.blockSizeVertical * 0.08,
                      //       btnHeight: AppSizes.blockSizeVertical * 0.5,
                      //       onPressed: () {},
                      //       text: "Load More"),
                      // )
                    ],
                  );
                } else {
                  return Container(
                      height: AppSizes.screenHeight / 2,
                      child: Center(child: progressIndicator()));
                }
              },
            ),
            GeneralAdssWidget(),
          ],
        ),
      ),
    ));
  }

  Widget _newsCard({
    @required GestureTapCallback ontap,
    @required String title,
    @required String description,
    @required String imgUrl,
    @required String time,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.blockSizeVertical * 2.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          color: kColorContainer,
          child: Padding(
            padding: EdgeInsets.all(AppSizes.blockSizeVertical * 1.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImagePixels.container(
                    imageProvider: NetworkImage(imgUrl),
                    colorAlignment: Alignment.topLeft,
                    child: Container(
                      width: AppSizes.blockSizeHorizontal * 25.0,
                      height: AppSizes.blockSizeVertical * 15.0,
                      alignment: Alignment.center,
                      child: Container(
                        width: 829,
                        height: 197,
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
                        endIndent: AppSizes.blockSizeHorizontal * 35.0,
                        thickness: AppSizes.blockSizeHorizontal * 0.5,
                        color: kColorAccent,
                      ),
                      Text(
                        description,
                        style: textBody(
                            fontSize: AppSizes.blockSizeVertical * 1.6,
                            color: Colors.black),
                      ),
                      spacerWidget(height: AppSizes.blockSizeVertical * 1.0),
                      Text(
                        time,
                        textAlign: TextAlign.justify,
                        style: textBody(
                            fontSize: AppSizes.blockSizeVertical * 1.5,
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
