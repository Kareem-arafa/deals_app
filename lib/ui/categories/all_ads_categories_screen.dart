import 'package:dealz/data/models/category_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/categories/categories_widget.dart';
import 'package:flutter/material.dart';

class AllAdsCategoriesScreen extends StatefulWidget {
  final List<CategoryModel> categories;

  const AllAdsCategoriesScreen({super.key, required this.categories});

  @override
  State<AllAdsCategoriesScreen> createState() => _AllAdsCategoriesScreenState();
}

class _AllAdsCategoriesScreenState extends State<AllAdsCategoriesScreen> {
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
      body: Container(
        margin: EdgeInsets.all(16),
        child: CategoriesWidget(
          categories: widget.categories,
          scrollPhysics: AlwaysScrollableScrollPhysics(),
          isFromAds: true,
        ),
      ),
    );
  }
}
