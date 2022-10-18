import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:fcl/widgets/text_fields.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:provider/provider.dart';
import 'package:fcl/core/viewmodels/currentUser_viewmodel.dart';
import 'package:fcl/core/viewmodels/updateProfile_viewmodel.dart';
import 'package:fcl/core/datamodels/currentUser_datamodel.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/app_calendar_filed.dart';
import 'package:fcl/utils/app_date_format.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  CurrentUserViewModel currentUserViewModel = CurrentUserViewModel();
  Future currentUserFuture;
  @override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

  void getCurrentUserData() async {
    currentUserFuture = currentUserViewModel.getCurrentUserData();
  }

  DateTime picker;
  DateTime dob;
  @override
  Widget build(BuildContext context) {
    final _notifier = Provider.of<UpdateProfileViewmodel>(context);
    // final currentUserViewModel = Provider.of<CurrentUserViewModel>(context);

    return BaseScaffold(
        isCenterTitle: false,
        isCenterLogo: false,
        isDrawer: false,
        centerTitle: "Edit Profile".tr,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.blockSizeVertical * 2.0),
              child: FutureBuilder<CurrentUserDatamodel>(
                future: currentUserFuture,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var currentUserData = snapshot.data.data;
                    if (snapshot.data == null || !snapshot.hasData) {
                      return Center(
                        child: Text(
                          "No data".tr,
                          style: textBody(),
                        ),
                      );
                    }
                    var profileImg = currentUserData.image != null
                        ? kImgBaseUrl + currentUserData.image
                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8czzbrLzXJ9R_uhKyMiwj1iGxKhJtH7pwlQ&usqp=CAU";
                    return Form(
                      key: _notifier.updateProfileFormKey,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              NavRouter.navigator
                                  .pushNamed(NavRouter.editProfilePicPage);
                              _notifier.imgUrl = profileImg;
                            },
                            child: CircleAvatar(
                              maxRadius: AppSizes.blockSizeVertical * 8.0,
                              backgroundImage: NetworkImage(profileImg),
                            ),
                          ),
                          spacerWidget(
                              height: AppSizes.blockSizeVertical * 2.0),
                          Text(
                            "Player ID:".tr + currentUserData.id.toString(),
                            style: textBody(),
                          ),
                          spacerWidget(
                              height: AppSizes.blockSizeVertical * 1.5),
                          TxtField(
                            titletxt: "First Name".tr,
                            hinttxt: "First Name".tr,
                            initialvalue: currentUserData.fName,
                            validationerrortxt: null,
                            keyboardtype: TextInputType.name,
                            onsaved: (value) =>
                                _notifier.updateProfileFirstName = value,
                            validator: (value) => value.isEmpty
                                ? "First Nome Can't be empty".tr
                                : null,
                          ),
                          TxtField(
                            titletxt: "Last Name".tr,
                            hinttxt: "Last Name".tr,
                            initialvalue: currentUserData.lName,
                            validationerrortxt: null,
                            keyboardtype: TextInputType.name,
                            onsaved: (value) =>
                                _notifier.updateProfileLastName = value,
                            validator: (value) => value.isEmpty
                                ? "Last Name Can\'t be empty".tr
                                : null,
                          ),
                          InkWell(
                              onTap: () async {
                                picker = await calendarWidget(context: context);
                                setState(() {
                                  dob = picker;
                                });

                                print(picker);
                              },
                              child: calendarFiled(
                                  dateTxt: dob != null
                                      ? dateFormat(dob)
                                      : dateFormat(currentUserData.dob))),
                          TxtField(
                            titletxt: "Email".tr,
                            hinttxt: "Email".tr,
                            initialvalue: currentUserData.email,
                            validationerrortxt: null,
                            keyboardtype: TextInputType.emailAddress,
                            onsaved: (value) =>
                                _notifier.updateProfileEmail = value,
                            validator: (value) => value.isEmpty
                                ? "Email Can\'t be empty".tr
                                : null,
                          ),
                          TxtField(
                            titletxt: "Username",
                            hinttxt: "Username",
                            initialvalue: currentUserData.username,
                            validationerrortxt: null,
                            keyboardtype: TextInputType.name,
                            onsaved: (value) =>
                                _notifier.updateProfileUserName = value,
                            validator: (value) => value.isEmpty
                                ? "Username or Email Can\'t be empty".tr
                                : null,
                          ),
                          txtFieldContactNumber(
                              notifier: _notifier,
                              initialValue: currentUserData.phone,
                              currentUserData: currentUserData,
                              validator: (value) => value.isEmpty
                                  ? "Contact Number Can\'t be empty"
                                  : null,
                              onsaved: (value) {
                                value != null
                                    ? _notifier.updateProfilePhoneNumber = value
                                    : _notifier.updateProfilePhoneNumber =
                                        currentUserData.phone;
                              }),
                          Align(
                            child: _notifier.state == ViewState.kBusy
                                ? progressIndicator()
                                : raisedBtnLg(
                                    onPressed: () async {
                                      if (picker != null) {
                                        _notifier.updateProfileBirth =
                                            dateFormatYearBefore(picker)
                                                .toString();
                                      } else {
                                        _notifier.updateProfileBirth =
                                            currentUserData.dob.toString();
                                      }
                                      await _notifier
                                          .validateAndSubmitUpdateProfile();
                                      if (_notifier.isProfileUpdated) {
                                        showToast(
                                            msg: "Profile Updated Successfully"
                                                .tr);

                                        Navigator.pop(context);
                                      } else {
                                        showToast(msg: _notifier.authMsg);
                                      }
                                    },
                                    text: "Submit".tr),
                          ),
                          InkWell(
                            onTap: () => NavRouter.navigator
                                .pushNamed(NavRouter.changePasswordPage),
                            child: Text(
                              "Change Password??".tr,
                              style: textBody(color: kColorAccent),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                                AppSizes.blockSizeVertical * 2.0),
                            child: Text(
                              "Note:You are responsible for all information that will be changed so you have to make sure that you are writing correct information because it will be used for your security."
                                  .tr
                                  .tr,
                              style: textBody(
                                  fontSize: AppSizes.blockSizeVertical * 1.7),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                        height: AppSizes.screenHeight -
                            AppSizes.blockSizeVertical * 20.0,
                        child: Center(child: progressIndicator()));
                  }
                },
              ),
            ),
          ),
        ));
  }

  Widget txtFieldContactNumber({
    @required Function(String) onsaved,
    @required String Function(String) validator,
    @required UpdateProfileViewmodel notifier,
    @required Data currentUserData,
    String initialValue,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.blockSizeHorizontal * 2.0,
          vertical: AppSizes.blockSizeHorizontal * 2.0),
      child: Container(
        decoration: BoxDecoration(
            color: kColorContainer,
            borderRadius:
                BorderRadius.circular(AppSizes.blockSizeHorizontal * 7.0)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: AppSizes.blockSizeHorizontal * 25,
                  child: CountryCodePicker(
                      initialSelection: currentUserData.countryCode,
                      countryFilter: [
                        "+965",
                        "+966",
                        "+968",
                        "+973",
                        "+971",
                        "+964",
                        "+974"
                      ],
                      onChanged: (code) {
                        code.dialCode != null
                            ? notifier.updateProfileCountryCode = code.dialCode
                            : notifier.updateProfileCountryCode =
                            currentUserData.countryCode;
                        print("Code is ${code.dialCode}");
                        // setState(() {
                        //   notifier.updateProfileCountryCode = code.dialCode;
                        // });
                      },
                      onInit: (code) {
                        notifier.updateProfileCountryCode = code.dialCode;
                        print(
                            "on init ${code.name} ${code.dialCode} ${code.name}");
                      }),
                ),
                Expanded(
                  child: TextFormField(
                      initialValue: initialValue,
                      onSaved: onsaved,
                      validator: validator,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "+1 320 45214 444",
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            gapPadding: 10.0,
                          ))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
