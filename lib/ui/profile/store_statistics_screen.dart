import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/profile/profile_statistics_screen.dart';
import 'package:flutter/material.dart';

class StoreStatisticsScreen extends StatefulWidget {
  const StoreStatisticsScreen({super.key});

  @override
  State<StoreStatisticsScreen> createState() => _StoreStatisticsScreenState();
}

class _StoreStatisticsScreenState extends State<StoreStatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Store Statistics',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff15a8e1).withOpacity(0.1177779796511628),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x05000000),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text(
                        "Select Date :\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text(
                                  "From",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomDropdownButton(
                                  items: [],
                                  hint: "5-12-2023",
                                  onChange: (value) {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text(
                                  "To",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomDropdownButton(
                                  items: [],
                                  hint: "5-12-2023",
                                  onChange: (value) {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              new Container(
                width: double.infinity,
                decoration: new BoxDecoration(
                  color: Color(0xfff6f6f6),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x05000000),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                        spreadRadius: 0)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0) +
                      EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        "Products :\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      StatisticsItem(
                          Assets.images.home.path, "All Products", "245"),
                      StatisticsItem(
                          Assets.images.views.path, "All Views", "5468"),
                      StatisticsItem(Assets.images.transactions.path,
                          "All Transactions", "245",
                          hasCurrency: true),
                      StatisticsItem(Assets.images.home.path,
                          "Total refered Calls", "366"),
                      StatisticsItem(Assets.images.home.path,
                          "Number of followers", "366"),
                      StatisticsItem(Assets.images.home.path,
                          "Number of sales deals", "366"),
                      StatisticsItem(
                          Assets.images.home.path, "Number of Ads", "366")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
