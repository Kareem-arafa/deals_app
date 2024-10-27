import 'package:dealz/data/models/days_model.dart';
import 'package:dealz/data/models/my_store_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoreWorkTimeDialog extends StatelessWidget {
  final MyStoreModel store;

  const StoreWorkTimeDialog({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.images.store.path,
                height: 80,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                Translations.of(context).text("workingHoursLabel"),
                style: TextStyle(
                  color: Color(0xff110c23),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                itemCount: 7,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (store.getSelectedDays().contains(days[index])) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              days[index].name(Translations.of(context).currentLanguage),
                              style: TextStyle(
                                color: Color(0xff110c23),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${store.openingTime} - ${store.closingTime}",
                              style: TextStyle(
                                color: Color(0xff110c23),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            days[index].name(Translations.of(context).currentLanguage),
                            style: TextStyle(
                              color: Color(0xff110c23),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Closed",
                            style: TextStyle(
                              color: Color(0xff110c23),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 8,
                  );
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
