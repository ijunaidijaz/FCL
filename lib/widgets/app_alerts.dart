import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

showAlertDialogMessge(
    BuildContext context, String msg, GestureTapCallback onTap) {
  // set up the AlertDialog
  Widget alert = Padding(
    padding: EdgeInsets.symmetric(
      horizontal: AppSizes.blockSizeHorizontal * 0.0,
    ),
    child: Center(
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppSizes.blockSizeVertical * 1.2)),
        child: Wrap(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(AppSizes.blockSizeVertical * 1.2),
                      bottomRight:
                          Radius.circular(AppSizes.blockSizeVertical * 1.2),
                    )),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.blockSizeHorizontal * 4.0,
                      vertical: AppSizes.blockSizeVertical * 2.0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.blockSizeHorizontal * 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            msg,
                            textAlign: TextAlign.center,
                            style: textBody(
                                fontSize: AppSizes.blockSizeVertical * 2.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.blockSizeHorizontal * 4.0),
                            child: raisedBtnLg(
                                isScreenWidthBtn: false,
                                btnWidth: AppSizes.blockSizeHorizontal * 30.0,
                                btnHeight: 5.5,
                                borderRadius: 1.0,
                                onPressed: onTap,
                                text: "OK".tr),
                          )
                        ],
                      ),
                    )),
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
