import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_general_adds.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isAction: false,
        isCenterLogo: false,
        centerTitle: "About Us".tr,
        isDrawer: false,
        isCenterTitle: false,
        body: Padding(
          padding:
              EdgeInsets.symmetric(vertical: AppSizes.blockSizeVertical * 3.5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.blockSizeHorizontal * 2.5),
                    child: Wrap(
                      children: [
                        Text(
                          'A Game that depends on your correct predictions that will gather all football fans in one league.\n\nAll questions related to all football competitions\n\nAll you need is:\n\n'
                              .tr,
                          style: textBody(),
                        ),
                        optionTile(txt: 'Register in the App'.tr),
                        optionTile(txt: 'Answer questions'.tr),
                        optionTile(txt: 'Lead the league'.tr),
                        optionTile(txt: 'Win the game'.tr),
                      ],
                    )),
                spacerWidget(height: AppSizes.blockSizeVertical * 6.0),
                GeneralAdssWidget(),
              ],
            ),
          ),
        ));
  }
}

Widget optionTile({@required String txt}) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(
        vertical: AppSizes.blockSizeVertical * 0.0,
        horizontal: AppSizes.blockSizeHorizontal),
    leading: SvgPicture.asset(
      'assets/icons/tick.svg',
      height: AppSizes.blockSizeVertical * 1.5,
    ),
    title: Text(
      txt,
      style: textBody(),
    ),
  );
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("GFG Slider"),
//       ),
//       body: ListView(
//         children: [],
//       ),
//     );
//   }
// }
