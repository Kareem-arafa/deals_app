import 'package:alice/alice.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/redux/store.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/auth/create_account/verify_mobile_number_screen.dart';
import 'package:dealz/ui/main_bottom_navigation/main_bottom_navigation.dart';
import 'package:dealz/ui/settings/settings_option.dart';
import 'package:dealz/ui/settings/settings_option_page.dart';
import 'package:dealz/ui/settings/theme.dart';
import 'package:dealz/ui/splash/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Alice alice = Alice(showNotification: true, directionality: TextDirection.ltr);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


main() async {
  var store = await createStore();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;

  const MyApp({super.key, required this.store});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SettingsOptions _options;

  @override
  void initState() {
    super.initState();
    _options = SettingsOptions(
      theme: AppTheme().appTheme,
      platform: defaultTargetPlatform,
      textDirection: TextDirection.rtl,
    );
    SharedPreferences.getInstance().then((prefs) {
      var lang = prefs.getString("lang");
      Locale locale = const Locale("en", "US");
      TextDirection textDirection = TextDirection.ltr;
      if (lang == "ar") {
        locale = Locale("ar", "EG");
        textDirection = TextDirection.rtl;
      } else {
        locale = Locale("en", "US");
        textDirection = TextDirection.ltr;
      }
      setState(() {
        _options = _options.copyWith(
          languageLocale: locale,
          textDirection: textDirection,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'Deals',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,//alice.getNavigatorKey(),
        theme: ThemeData(
          fontFamily: "Almarai",
          primaryColor: Color(0xff15a8e1),
        ),
        routes: _routes(),
        locale: _options.languageLocale,
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ar', 'EG'),
        ],
        localizationsDelegates: [
          TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }

  void _handleOptionsChanged(SettingsOptions newOptions) {
    if (newOptions.languageLocale!.languageCode != _options.languageLocale!.languageCode) {
      SharedPreferences.getInstance().then((pref) {
        pref.setString("lang", newOptions.languageLocale!.languageCode);
      });
    }
    setState(() {
      _options = newOptions;
    });
  }

  Map<String, WidgetBuilder> _routes() {
    return <String, WidgetBuilder>{
      "/settings": (_) => SettingsOptionsPage(
            options: _options,
            onOptionsChanged: _handleOptionsChanged,
          ),
      "/": (_) => SplashScreen(),
      "/main": (_) => MainBottomNavigation(
            options: _options,
            onOptionsChanged: _handleOptionsChanged,
          ),
    };
  }
}
