/*
import 'package:dealz/common/custom_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/ads/create_ads/plans/plan_one_screen.dart';
import 'package:flutter/material.dart';

class PlanTwoScreen extends StatefulWidget {
  const PlanTwoScreen({super.key});

  @override
  State<PlanTwoScreen> createState() => _PlanTwoScreenState();
}

class _PlanTwoScreenState extends State<PlanTwoScreen> {
  List<AdPlan> plans = [
    AdPlan(
      title: "Weekly Plan",
      price: "kw 20",
      duration: "for week",
      img: Assets.images.calendar.path,
    ),
    AdPlan(
      title: "Monthly Plan",
      price: "kw 40",
      duration: "month",
      img: Assets.images.calendarMonthly.path,
    ),
  ];
  int? selectedPlan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  Assets.images.logo.path,
                  height: 52,
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                            text: "Packages for Trend ad on ",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              letterSpacing: -0.5,
                            )),
                        new TextSpan(
                          text: "Dealz",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: "Poppins",
                            fontSize: 22,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          ListView.separated(
            itemCount: plans.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedPlan = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: selectedPlan == index
                          ? Theme.of(context).primaryColor
                          : Color(0xffd4d4d4),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                plans[index].img!,
                                height: 48,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  new Text(
                                    plans[index].title!,
                                    style: TextStyle(
                                      color: Color(0xff2b3242),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                    text: new TextSpan(
                                      children: [
                                        new TextSpan(
                                          text: "${plans[index].price} ",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xff2b3242),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (plans[index].duration != null)
                                          new TextSpan(
                                            text: "/${plans[index].duration}",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0xff2b3242),
                                              fontSize: 11,
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: ButtonWidget(
                            type: ButtonType.primary,
                            title: selectedPlan == index ? "Renew" : "Activate",
                            bgColor: selectedPlan == index
                                ? null
                                : Color(0xffd1d1d1),
                            borderRaduis: 50,
                            height: 38,
                            width: (MediaQuery.of(context).size.width / 2) - 20,
                            onTap: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: ButtonWidget(
              type: ButtonType.primary,
              title: "Done",
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
*/
