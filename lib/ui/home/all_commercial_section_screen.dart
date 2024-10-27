import 'package:dealz/data/models/category_model.dart';
import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/categories/category_item.dart';
import 'package:dealz/ui/home/all_stores_screen.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

class AllCommercialSectionScreen extends StatelessWidget {
  final List<Sections> sections;
  const AllCommercialSectionScreen({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            Translations.of(context).text("homeScreenAllSectionLabel"),
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
              matchTextDirection: true,
            ),
          ),
        ),
        body: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: DynamicHeightGridView(
            itemCount: this.sections.length,
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            builder: (BuildContext context, int index) {
              final section = this.sections[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllStoresScreen(
                        sectionId: sections[index].id!,
                      ),
                    ),
                  );
                },
                child: CategoryItem(
                  category: CategoryModel(
                    id: section.id,
                    nameAr: section.arabicName,
                    nameEn: section.englishName,
                    image: section.image,
                  ),
                ),
              );
            },
          ),
        )
    );
  }
}
