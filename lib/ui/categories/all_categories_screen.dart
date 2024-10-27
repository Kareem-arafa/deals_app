import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/ui/categories/categories_widget.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AllCategoriesScreen extends StatelessWidget {
  final int sectionId;

  const AllCategoriesScreen({super.key, required this.sectionId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AllCategoriesScreenContent(
        viewModel: viewModel,
        sectionId: sectionId,
      ),
    );
  }
}

class _AllCategoriesScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final int sectionId;

  const _AllCategoriesScreenContent({required this.viewModel, required this.sectionId});

  @override
  State<_AllCategoriesScreenContent> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<_AllCategoriesScreenContent> {
  @override
  void initState() {
    super.initState();
    this.widget.viewModel.getSectionCategories(widget.sectionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'All Categories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            Assets.images.backArrow.path,
            height: 18,
          ),
        ),
      ),
      body: this.widget.viewModel.getSectionCategoriesReport.status == ActionStatus.running
          ? Center(
              child: CupertinoActivityIndicator(
                animating: true, // Control animation
                color: Theme.of(context).primaryColor,
              ),
            )
          : Container(
              margin: EdgeInsets.all(16),
              child: CategoriesWidget(
                categories: this.widget.viewModel.sectionCategories,
                scrollPhysics: AlwaysScrollableScrollPhysics(),
              ),
            ),
    );
  }
}
