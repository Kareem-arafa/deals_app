import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/all_stores_screen.dart';
import 'package:dealz/ui/home/home_category_widget.dart';
import 'package:flutter/material.dart';

class AllSectionScreen extends StatelessWidget {
  final List<Sections> sections;
  const AllSectionScreen({super.key, required this.sections});

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
      body: ListView.separated(
        itemCount: sections.length,
        itemBuilder: (_, int index) {
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
            child: HomeCategoryItem(
              section: sections[index],
            ),
          );
        },
        padding: EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 15,
        ),
      )
    );
  }
}
