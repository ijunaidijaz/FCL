import 'package:country_code_picker/country_code_picker.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/pages/web_views/payment_webview_page.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:get/get.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:fcl/widgets/text_fields.dart';
import 'package:fcl/widgets/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    final _notifier = Provider.of<CompetitionListViewModel>(context);
    return BaseScaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: AppSizes.blockSizeVertical * 3.0),
          child: Form(
            key: _notifier.paymentFormKey,
            child: Column(
              children: [
                Image(
                    height: AppSizes.blockSizeVertical * 10.0,
                    image: AssetImage("assets/images/knet.png")),
                spacerWidget(height: AppSizes.blockSizeVertical * 3.0),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: AppSizes.blockSizeVertical * 2.0,
                      left: AppSizes.blockSizeHorizontal * 7.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Amount: KD ".tr + " ${_notifier.competitionAmount}",
                      style: textBody(),
                    ),
                  ),
                ),
                TxtField(
                  hinttxt: "Customer Name".tr,
                  validationerrortxt: null,
                  keyboardtype: TextInputType.name,
                  validator: (value) =>
                      value.isEmpty ? "Customer Name Can't be empty" : null,
                  onsaved: (value) => _notifier.custName = value,
                ),
                TxtField(
                  hinttxt: "Customer Email",
                  validationerrortxt: null,
                  keyboardtype: TextInputType.emailAddress,
                  validator: (value) => value.isEmpty
                      ? "Email Can't be empty"
                      : validateEmail(value) != true
                          ? "Email is not valid"
                          : null,
                  onsaved: (value) => _notifier.custEmail = value,
                ),
                txtFieldContactNumber(
                  notifier: _notifier,
                  onsaved: (value) => _notifier.custContactNo = value,
                  validator: (value) =>
                      value.isEmpty ? "Contact Number Can't be empty" : null,
                ),
                TxtField(
                  hinttxt: "Remarks",
                  maxlines: 3,
                  validationerrortxt: null,
                  keyboardtype: TextInputType.name,
                  validator: (value) =>
                      value.isEmpty ? "Customer Remarks Can't be empty" : null,
                  onsaved: (value) => _notifier.custRemarks = value,
                ),
                spacerWidget(height: AppSizes.blockSizeVertical * 2.0),
                Align(
                  child: _notifier.state == ViewState.kBusy
                      ? progressIndicator()
                      : raisedBtnLg(
                          onPressed: () async {
                            // await _notifier.validateAndSendPayment();
                            // if (_notifier.isPAymentPaid) {
                            //   // Navigator.pop(context);
                            //   showToast(msg: _notifier.authMsg);

                            //   Container(
                            //     child: WebView(
                            //       initialUrl: _notifier.paymentUrl,
                            //       javascriptMode: JavascriptMode.unrestricted,
                            //     ),
                            //   );
                            // } else {
                            //   showToast(msg: _notifier.authMsg);
                            // }

                            await _notifier.validateAndSendPayment();
                            if (_notifier.isPaymentProcessed) {
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PaymentWebViewPage(
                                            title: "Payment",
                                            selectedUrl: _notifier.paymentUrl,
                                          )));
                            }
                          },
                          text: "Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget txtFieldContactNumber({
    @required Function(String) onsaved,
    @required String Function(String) validator,
    @required CompetitionListViewModel notifier,
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
                      initialSelection: "+965",
                      onChanged: (code) {
                        print(code.toString());
                        setState(() {
                          notifier.custCountryCode = code.dialCode;
                        });
                      },
                      onInit: (code) {
                        notifier.custCountryCode = code.dialCode;
                        print(
                            "on init ${code.name} ${code.dialCode} ${code.name}");
                      }),
                ),
                Expanded(
                  child: TextFormField(
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
