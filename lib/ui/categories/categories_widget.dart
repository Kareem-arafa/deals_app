import 'package:dealz/data/models/category_model.dart';
import 'package:dealz/ui/categories/category_details_screen.dart';
import 'package:dealz/ui/categories/category_item.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  final List<CategoryModel> categories;
  final ScrollPhysics? scrollPhysics;
  final bool isFromAds;
  final bool isFromAll;

  const CategoriesWidget({super.key, this.scrollPhysics, required this.categories, this.isFromAds = false, this.isFromAll = true});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: DynamicHeightGridView(
        itemCount:widget.isFromAll ? this.widget.categories.length : this.widget.categories.take(9).length,
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        physics: widget.scrollPhysics,
        builder: (BuildContext context, int index) {
          final category = this.widget.categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryDetailsScreen(
                    category: category,
                    fromAds: widget.isFromAds,
                  ),
                ),
              );
            },
            child: CategoryItem(
              category: category,
            ),
          );
        },
      ),
    );
  }
}
