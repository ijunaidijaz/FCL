import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_general_adds.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'about_us_page.dart';

class CompetitionsRulesPage extends StatelessWidget {
  const CompetitionsRulesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isAction: false,
        isCenterLogo: false,
        centerTitle: "Competition Rules".tr,
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
                          'You will face number of questions weekly, there are two types of questions.'
                              .tr,
                          style: textBody(),
                        ),
                        optionTile(txt: 'Main questions'.tr),
                        optionTile(txt: 'Bonus questions'.tr),
                        Text(
                          "\n" + "Notice:".tr,
                          style: textBody(),
                        ),
                        optionTile(
                            txt:
                                'There is a Deadline that should be checked every week.'
                                    .tr),
                        optionTile(
                            txt: 'Submit all answers before the Deadline.'.tr),
                        Text(
                          '\nYou will collect points if you predict answers correctly'
                              .tr,
                          style: textBody(),
                        ),
                        optionTile(txt: "Main question 10 points".tr),
                        optionTile(txt: "Bonus question 20 points".tr),
                        Text(
                          "\n" + "Notice:".tr,
                          style: textBody(),
                        ),
                        Text(
                          '            If you predict all answers correctly, you will win your points +30.\n\nIn FCL Competition:\n\nCash prizes for the top three places in the competition Standings every month: \n'
                              .tr,
                          style: textBody(),
                        ),
                        optionTile(txt: "First place 30 KD".tr),
                        optionTile(txt: "Second place 20 KD".tr),
                        optionTile(txt: "Third place 10 KD".tr),


                        Text(
                          '\n\nSpecial prizes and gifts for the top 3 places at the end of the season:'
                              .tr,
                          style: textBody(),
                        ),


                        optionTile(txt: 'First place 300KD and Golden Cup.'.tr),
                        optionTile(
                            txt: 'Second place 200KD and Silver Cup.'.tr),
                        optionTile(
                            txt: 'Third place 100KD and Bronze Cup.\n'.tr),
                        Text(
                          'FCL competition cost free for all participants.\n\nNotice:\n           We will add more competitions with different special prizes and gifts that will cost every participant 1 KD only for each competition.'
                              .tr,
                          style: textBody(),
                        ),
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
