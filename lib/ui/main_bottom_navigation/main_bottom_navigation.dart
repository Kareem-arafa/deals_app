import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/create_ads/main_create_ad_screen.dart';
import 'package:dealz/ui/ads/main_ads_screen.dart';
import 'package:dealz/ui/auth/create_account/signup_with_email_screen.dart';
import 'package:dealz/ui/auth/login_screen.dart';
import 'package:dealz/ui/home/home_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/profile/profile_screen.dart';
import 'package:dealz/ui/settings/settings_option.dart';
import 'package:dealz/ui/trend/trend_ad_store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MainBottomNavigation extends StatelessWidget {
  final SettingsOptions options;
  final ValueChanged<SettingsOptions> onOptionsChanged;

  const MainBottomNavigation({super.key, required this.options, required this.onOptionsChanged});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _MainBottomNavigationContent(
        viewModel: viewModel,
        options: options,
        onOptionsChanged: onOptionsChanged,
      ),
    );
  }
}

class _MainBottomNavigationContent extends StatefulWidget {
  final SettingsOptions options;
  final ValueChanged<SettingsOptions> onOptionsChanged;
  final HomeViewModel viewModel;

  const _MainBottomNavigationContent({
    required this.options,
    required this.onOptionsChanged,
    required this.viewModel,
  });

  @override
  State<_MainBottomNavigationContent> createState() => _MainBottomNavigationState();
}

class _MainBottomNavigationState extends State<_MainBottomNavigationContent> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  late List<Widget> pages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pages = <Widget>[
      HomeScreen(),
      MainAdsScreen(),
      Container(),
      TrendAdStoreScreen(),
      ProfileScreen(
        options: widget.options,
        onOptionsChanged: widget.onOptionsChanged,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: Stack(
          alignment: FractionalOffset(.5, 0.3),
          children: [
            BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 50,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6) + EdgeInsets.only(top: 30),
                    child: Image.asset(
                      Assets.images.filledHome.path,
                      height: 20,
                      color: selectedIndex == 0 ? Theme.of(context).primaryColor : null,
                    ),
                  ),
                  label: Translations.of(context).text("mainScreenStoresLabel"),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6) + EdgeInsets.only(top: 30),
                    child: Image.asset(
                      Assets.images.adsActive.path,
                      height: 20,
                      color: selectedIndex == 1 ? Theme.of(context).primaryColor : Color(0xffadadad),
                    ),
                  ),
                  label: Translations.of(context).text("mainScreenAdsLabel"),
                ),
                BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6) + EdgeInsets.only(top: 30),
                    child: Image.asset(
                      Assets.images.trendBag.path,
                      height: 20,
                      color: selectedIndex == 3 ? Theme.of(context).primaryColor : Color(0xffadadad),
                    ),
                  ),
                  label: Translations.of(context).text("mainScreenTrendsLabel"),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6) + EdgeInsets.only(top: 30),
                    child: Image.asset(
                      Assets.images.account.path,
                      height: 20,
                      color: selectedIndex == 4 ? Theme.of(context).primaryColor : Color(0xffadadad),
                    ),
                  ),
                  label: Translations.of(context).text("mainScreenAccountLabel"),
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: Theme.of(context).primaryColor,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(
                fontSize: 11,
              ),
              selectedFontSize: 11,
              unselectedFontSize: 11,
              unselectedItemColor: Colors.black.withOpacity(0.4),
            ),
            InkWell(
              onTap: () {
                if (widget.viewModel.user != null)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MainCreateAdScreen(),
                    ),
                  );
                else
                  showCreateUserBottomSheet(context);
              },
              child: Container(
                width: 55,
                child: Image.asset(
                  Assets.images.addptn.path,
                ),
              ),
            ),
          ],
        ),
      ),
      body: pages.elementAt(selectedIndex),
    );
  }

  void showCreateUserBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  Translations.of(context).text("guestBottomSheetForLoginOrRegisterTitle"),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text(
                  Translations.of(context).text("loginScreenLoginButton"),
                ),
                onTap: () {
                  // Close the bottom sheet and navigate to login screen
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.person_add),
                title: Text(
                  Translations.of(context).text("loginScreenRegisterNow"),
                ),
                onTap: () {
                  // Close the bottom sheet and navigate to register screen
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupWithEmailScreen()));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
