import 'dart:io';

import 'package:fcl/core/viewmodels/updateProfile_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class EditProfilePic extends StatefulWidget {
  const EditProfilePic({Key key}) : super(key: key);

  @override
  _EditProfilePicState createState() => _EditProfilePicState();
}

class _EditProfilePicState extends State<EditProfilePic> {
  final picker = ImagePicker();
  File mypic;
  bool isimage = false;
  @override
  Widget build(BuildContext context) {
    final _notifier = Provider.of<UpdateProfileViewmodel>(context);
    return BaseScaffold(
        isCenterTitle: false,
        isCenterLogo: false,
        isDrawer: false,
        centerTitle: "Change Profile Picture".tr,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        maxRadius: AppSizes.blockSizeVertical * 8.0,
                        backgroundImage: isimage
                            ? FileImage(mypic)
                            : NetworkImage(_notifier.imgUrl),
                      ),
                      InkWell(
                        onTap: () {
                          showAlertImagePicker(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: AppSizes.blockSizeVertical * 3.0,
                          child: Icon(
                            Icons.camera_alt,
                            size: AppSizes.blockSizeVertical * 3.5,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: AppSizes.blockSizeVertical * 10.0,
                      bottom: AppSizes.blockSizeVertical * 15.0),
                  child: Align(
                    child: _notifier.state == ViewState.kBusy
                        ? progressIndicator()
                        : raisedBtnLg(
                            onPressed: () async {
                              _notifier.changeProfilePic = mypic;
                              await _notifier
                                  .validateAndSubmitUpdateProfilePic();
                              if (_notifier.isProfilePicUpdated) {
                                showToast(
                                    msg: "Profile Picture Changed Successfully"
                                        .tr);
                                NavRouter.navigator.pushNamedAndRemoveUntil(
                                    NavRouter.mainPage, (route) => false);
                              } else {
                                showToast(msg: _notifier.authMsg);
                              }
                            },
                            text: "Change".tr),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  showAlertImagePicker(BuildContext context) {
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
          child: Padding(
            padding: EdgeInsets.all(AppSizes.blockSizeVertical * 2.0),
            child: Wrap(
              children: [
                raisedBtnLg(
                    bgColor: Colors.redAccent,
                    iconData: Icons.camera_alt,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                      _imagePicker(
                          context: context, imgSource: ImageSource.camera);
                    },
                    text: "Upload from Camera".tr),
                raisedBtnLg(
                    bgColor: Colors.blueGrey,
                    iconData: Icons.file_upload,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                      _imagePicker(
                          context: context, imgSource: ImageSource.gallery);
                    },
                    text: "Upload from Gallery".tr),
              ],
            ),
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

  _imagePicker({
    @required BuildContext context,
    @required ImageSource imgSource,
  }) async {
    var picked =
        // await ImagePicker.pickImage(source: imgSource, imageQuality: 40);
        await ImagePicker.platform.getImage(source: imgSource);
    mypic = File(
      picked.path,
    );
    if (mypic != null) {
      mypic = mypic;
      setState(() {
        isimage = true;
      });
    } else {
      print("null yahan ");
      Navigator.pop(context);
    }
  }
}
