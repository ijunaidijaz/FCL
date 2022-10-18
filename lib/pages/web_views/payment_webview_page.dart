import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/app_toast.dart';
import '../payment_recipt_page.dart';

class PaymentWebViewPage extends StatefulWidget {
  final String title;
  final String selectedUrl;

  PaymentWebViewPage({
    @required this.title,
    @required this.selectedUrl,
  });
  PaymentWebViewPageState createState() => PaymentWebViewPageState();
}

class PaymentWebViewPageState extends State<PaymentWebViewPage> {
  // CompetitionListViewModel _competitionListViewModel =
  //     CompetitionListViewModel();

  @override
  void initState() {
    super.initState();
  }

  final key = UniqueKey();
  int count = 0;
  num position = 1;
  // doneLoading(url) {
  //   Uri uri = Uri.dataFromString(url);
  //   String hash = uri.queryParameters['hash'];
  //   String orderId = uri.queryParameters['order_id'];
  //   if (hash != null && orderId != null) {
  //     print("=========hash $hash========");
  //     print("=========Order id $orderId========");

  //     _competitionListViewModel.validateAndGetPaymentInfo(
  //         hash: hash, orderId: orderId);
  //   }

  //   print("====on page end:$url");

  //   setState(() {
  //     position = 0;
  //   });
  // }

  // startLoading(url) {
  //   print("====on page start:$url");
  //   setState(() {
  //     position = 1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.selectedUrl);
    final competitionListViewModel =
    Provider.of<CompetitionListViewModel>(context);
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: IndexedStack(index: position, children: <Widget>[
          WebView(
            initialUrl: widget.selectedUrl,
            javascriptMode: JavascriptMode.unrestricted,
            key: key,
            onPageFinished: (url) async {
              Uri uri = Uri.dataFromString(url);
              String hash = uri.queryParameters['hash'];
              String orderId = uri.queryParameters['order_id'];
              if (hash != null && orderId != null) {
                print("=========hash $hash========");
                print("=========Order id $orderId========");
                await competitionListViewModel.validateAndGetPaymentInfo(
                    hash: hash, orderId: orderId);

                if (competitionListViewModel.state ==ViewState.kBusy) {
                  Container(
                    child: Center(child: progressIndicator()),
                  );
                } else {
                  // Navigator.of(context).popUntil((_) => count++ >= 2);
                  // showToast(msg: competitionListViewModel.authMsg);
                  Navigator
                      .of(context)
                      .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => PaymentReciptPage()));
                  // NavRouter.navigator.pushNamed(NavRouter.paymentReciptPage);
                }
              }

              print("====on page end:$url");
              setState(() {
                position = 0;
              });
            },
            onPageStarted: (url) {
              print("====on page start:$url");
              setState(() {
                position = 1;
              });
            },
          ),
          Container(
            color: Colors.white,
            child: Center(child: progressIndicator()),
          ),
        ]));
  }
}
