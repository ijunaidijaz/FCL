import 'package:fcl/core/datamodels/notifications_datamodel.dart';
import 'package:fcl/core/viewmodels/notifications_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationsViewModel = Provider.of<NotificationsViewModel>(context);
    return BaseScaffold(
        isDrawer: false,
        isAction: false,
        isCenterTitle: false,
        centerTitle: "Notifications".tr,
        isCenterLogo: false,
        horizontalPadding: AppSizes.blockSizeHorizontal * 3.0,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSizes.blockSizeVertical * 5.0),
            child: FutureBuilder<NotificationsDatamodel>(
              future: notificationsViewModel.getNotificationsData(),
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
                  return Column(
                      children: List.generate(
                          snapshot.data.data.data.length,
                          (index) => _notificationCard(
                                norificationTxt:
                                    snapshot.data.data.data[index].message,
                                type: snapshot.data.data.data[index].type,
                              )));
                } else {
                  return Container(
                      height: AppSizes.screenHeight / 2,
                      child: Center(child: progressIndicator()));
                }
              },
            ),
          ),
        ));
  }

  Widget _notificationCard({
    @required String norificationTxt,
    @required String type,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                norificationTxt,
                textAlign: TextAlign.left,
                style: textBody(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: kColorAccent,
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.blockSizeHorizontal))),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.blockSizeHorizontal * 0.5),
                child: Text(
                  type,
                  style: textBody(
                      color: Colors.black,
                      fontSize: AppSizes.blockSizeHorizontal * 3.0),
                ),
              ),
            )
          ],
        ),
        Divider(
          color: Colors.white,
          indent: AppSizes.blockSizeVertical * 2.0,
          endIndent: AppSizes.blockSizeVertical * 2.0,
          height: AppSizes.blockSizeVertical * 6.0,
          thickness: AppSizes.blockSizeVertical * 0.15,
        )
      ],
    );
  }
}
