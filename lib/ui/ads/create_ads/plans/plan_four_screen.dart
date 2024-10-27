/*
import 'package:dealz/common/custom_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/ads/create_ads/plans/plan_one_screen.dart';
import 'package:flutter/material.dart';

class PlanFourScreen extends StatefulWidget {
  const PlanFourScreen({super.key});

  @override
  State<PlanFourScreen> createState() => _PlanFourScreenState();
}

class _PlanFourScreenState extends State<PlanFourScreen> {
  List<AdPlan> plans = [
    AdPlan(
      title: "1",
      price: "kw 20",
      duration: "Month",
    ),
    AdPlan(
      title: "3",
      price: "kw 50",
      duration: "Month",
      discount: "kw 60",
    ),
    AdPlan(
      title: "6",
      price: "kw 90",
      duration: "Month",
    ),
    AdPlan(
      title: "1",
      price: "kw 160",
      duration: "Year",
    ),
  ];
  int? selectedPlan;
  int? selectedPackege;
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                              text: "Packages store ad on\n ",
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
            SizedBox(
              height: 25,
            ),
            ListView.separated(
              itemCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (_, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedPackege = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: selectedPackege == index
                            ? Theme.of(context).primaryColor
                            : Color(0xffd4d4d4),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: index == 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text(
                                  "Basic package",
                                  style: TextStyle(
                                    color: Color(0xff2b3242),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeBottom: true,
                                  removeTop: true,
                                  child: ListView.separated(
                                    itemCount: plans.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, int indx) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedPlan = indx;
                                          });
                                        },
                                        child: Container(
                                          height: 55,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: selectedPlan == indx
                                                ? Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.3)
                                                : Color(0xffd8d8d8)
                                                    .withOpacity(0.3),
                                            border: Border.all(
                                              color: selectedPlan == indx
                                                  ? Colors.transparent
                                                  : Color(0xff979797)
                                                      .withOpacity(0.3),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(36.5),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 26),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RichText(
                                                  text: new TextSpan(
                                                    children: [
                                                      new TextSpan(
                                                        text:
                                                            "${plans[indx].title} ",
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              Color(0xff2b3242),
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      new TextSpan(
                                                        text:
                                                            "${plans[indx].duration}",
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              Color(0xff2b3242),
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    if (plans[indx].discount !=
                                                        null)
                                                      new Text(
                                                        plans[indx].discount!,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffcdcdcd),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          decorationThickness:
                                                              2,
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    new Text(
                                                      plans[indx].price!,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff2b3242),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(
                                      height: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Center(
                                  child: ButtonWidget(
                                    type: ButtonType.primary,
                                    title: "Activate",
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        20,
                                    borderRaduis: 50,
                                    height: 38,
                                    onTap: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text(
                                  "Premium package",
                                  style: TextStyle(
                                    color: Color(0xff2b3242),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 55,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xffd8d8d8).withOpacity(0.3),
                                    border: Border.all(
                                      color: Color(0xff979797).withOpacity(0.3),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(36.5),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        new Text(
                                          "UPgrade Account",
                                          style: TextStyle(
                                            color: Color(0xff2b3242),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        new Text(
                                          "kw 30 ",
                                          style: TextStyle(
                                            color: Color(0xff2b3242),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 15,
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
      ),
    );
  }
}
*/
