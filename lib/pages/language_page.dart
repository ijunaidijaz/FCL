import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/services/localization_service.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/app_dropdowns.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key key}) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLang = LocalizationService.langs.first;
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isAppbar: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select the '.tr,
                    style: textSubTitle(),
                  ),
                  Text(
                    'Language'.tr,
                    style: textSubTitle(color: kColorAccent),
                  ),
                ],
              ),
              spacerWidget(height: AppSizes.blockSizeVertical * 8.0),
              RoundedBorderDropdown(
                dropdownvalue: _selectedLang,

                listItems: LocalizationService.langs.map((String lang) {
                  return DropdownMenuItem(value: lang, child: Text(lang));
                }).toList(),
                // listItems: ["English", "Arabic"],
                onchange: (String value) {
                  print(_selectedLang.indexOf(_selectedLang));
                  // updates dropdown selected value
                  setState(() => _selectedLang = value);
                  // gets language and changes the locale
                  LocalizationService().changeLocale(value);
                },
              ),
              raisedBtnLg(
                  onPressed: () async {
                    print(
                        "==========Language is =====${LocalizationService.langs.indexOf(_selectedLang)}");
                    SharedPreferences localStorage =
                        await SharedPreferences.getInstance();
                    localStorage.setBool(
                        'language',
                        LocalizationService.langs.indexOf(_selectedLang) == 0
                            ? true
                            : false);

                    Navigator.canPop(context)
                        ? NavRouter.navigator
                            .popAndPushNamed(NavRouter.mainPage)
                        : NavRouter.navigator.pushNamed(NavRouter.loginPage);
                  },
                  text: 'Continue'.tr),
            ],
          ),
        ));
  }
}
