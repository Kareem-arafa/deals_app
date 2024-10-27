/*
import 'package:dealz/common/custom_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/ads/create_ads/plans/plan_one_screen.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

class PlanThreeScreen extends StatefulWidget {
  const PlanThreeScreen({super.key});

  @override
  State<PlanThreeScreen> createState() => _PlanThreeScreenState();
}

class _PlanThreeScreenState extends State<PlanThreeScreen> {
  List<AdPlan> plans = [
    AdPlan(
      title: "3",
      price: "kw 5",
      duration: "Days",
    ),
    AdPlan(
      title: "1",
      price: "kw 10",
      duration: "Week",
    ),
    AdPlan(
      title: "1",
      price: "kw 25",
      duration: "Month",
    ),
    AdPlan(
      title: "3",
      price: "kw 60",
      duration: "Month",
    ),
    AdPlan(
      title: "6",
      price: "kw 100",
      duration: "Month",
    ),
    AdPlan(
      title: "1",
      price: "kw 150",
      duration: "Year",
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
                              text: "Packages for Trend add on ",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                removeTop: true,
                child: DynamicHeightGridView(
                  itemCount: plans.length,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  physics: NeverScrollableScrollPhysics(),
                  builder: (BuildContext context, int index) {
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
                              horizontal: 12, vertical: 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: new Text(
                                    plans[index].price!,
                                    style: TextStyle(
                                      color: Color(0xff2b3242),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: new TextSpan(
                                  children: [
                                    new TextSpan(
                                        text: "${plans[index].title}\n",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xff2b3242),
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0,
                                        )),
                                    new TextSpan(
                                      text: "${plans[index].duration}",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xff2b3242),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ButtonWidget(
                                type: ButtonType.primary,
                                title: "Renew",
                                bgColor: selectedPlan == index
                                    ? null
                                    : Color(0xffd1d1d1),
                                borderRaduis: 50,
                                height: 35,
                                onTap: () {},
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
