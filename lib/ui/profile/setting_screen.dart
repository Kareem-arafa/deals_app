import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/data/models/days_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/settings/settings_option.dart';
import 'package:dealz/ui/settings/theme.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final SettingsOptions options;
  final ValueChanged<SettingsOptions> onOptionsChanged;

  const SettingsScreen({super.key, required this.options, required this.onOptionsChanged});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  LanguageModel? selectedLanguage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedLanguage = appLanguages.firstWhere((element) => element.code == Translations.of(context).currentLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            Assets.images.backArrow.path,
            height: 18,
            matchTextDirection: true,
          ),
        ),
        centerTitle: false,
        title: Text(
          Translations.of(context).text("settingScreenTitle"),
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0) + EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(
              Translations.of(context).text("settingScreenLanguage"),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            new Text(
              Translations.of(context).text("settingScreenSubTitle"),
            ),
            SizedBox(
              height: 70,
            ),
            CustomDropdownButton(
              items: appLanguages,
              value: selectedLanguage,
              hint: "Language",
              borderColor: Color(0xffcfcfcf),
              onChange: (value) {
                selectedLanguage = value;
                if (value.code == "en") {
                  changeLang("en");
                } else {
                  changeLang("ar");
                }
                setState(() {});
              },
            ),
            SizedBox(
              height: 40,
            ),
            ButtonWidget(
              type: ButtonType.primary,
              title: Translations.of(context).text("settingScreenDoneButtonTitle"),
              onTap: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  changeLang(String lang) {
    var locale;
    var textDirection;

    if (lang == "en") {
      locale = Locale('en', 'US');
      textDirection = TextDirection.ltr;
    } else {
      locale = Locale('ar', 'EG');
      textDirection = TextDirection.rtl;
    }

    Translations.load(locale).then((local) {
      this.widget.onOptionsChanged(
            this.widget.options.copyWith(
                  languageLocale: locale,
                  textDirection: textDirection,
                  theme: AppTheme().appTheme,
                ),
          );
    });
  }
}
