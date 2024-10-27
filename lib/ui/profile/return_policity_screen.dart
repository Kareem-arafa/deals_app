import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ReturnPolicyScreen extends StatelessWidget {
  const ReturnPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _ReturnPolicyScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _ReturnPolicyScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _ReturnPolicyScreenContent({super.key, required this.viewModel});

  @override
  State<_ReturnPolicyScreenContent> createState() => _ReturnPolicyScreenContentState();
}

class _ReturnPolicyScreenContentState extends State<_ReturnPolicyScreenContent> {
  @override
  void initState() {
    super.initState();
    this.widget.viewModel.getPageData("return-policy");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.widget.viewModel.getPageModelReport.status == ActionStatus.running
          ? Center(
        child: CupertinoActivityIndicator(
          animating: true, // Control animation
          color: Theme.of(context).primaryColor,
        ),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    height: 115,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: SafeArea(
                        child: new Text(
                          this.widget.viewModel.pageModel?.getTitle(Translations.of(context).currentLanguage) ??
                              "Terms & Conditions",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new Container(
                      width: 45,
                      height: 45,
                      decoration: new BoxDecoration(
                        color: Color(0xfff2f3f5),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Image.asset(
                          Assets.images.backArrow.path,
                          color: Color(0xff606770),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: new Text(
                    this.widget.viewModel.pageModel?.getDesc(Translations.of(context).currentLanguage) ?? "",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
