import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/all_stores_screen.dart';
import 'package:flutter/material.dart';

class HomeCategoryWidget extends StatelessWidget {
  final List<Sections> sections;
  const HomeCategoryWidget({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: sections.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, int index) {
        return HomeCategoryItem(
          section: sections[index],
        );
      },
      padding: EdgeInsets.symmetric(horizontal: 16),
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        height: 15,
      ),
    );
  }
}

class HomeCategoryItem extends StatelessWidget {
  final Sections section;
  const HomeCategoryItem({
    super.key, required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AllStoresScreen(
              sectionId: section.id!,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 114,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xffc8c8c8),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Image.network(
                    section.image ?? "",
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      Translations.of(context).currentLanguage == "ar" ? section.arabicName ?? "" : section.englishName ?? "",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${section.count} ${Translations.of(context).text("homeScreenSectionItemsLabel")}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 20,
            child: Image.asset(
              Assets.images.doubleArrow.path,
              height: 55,
            ),
          ),
        ],
      ),
    );
  }
}
