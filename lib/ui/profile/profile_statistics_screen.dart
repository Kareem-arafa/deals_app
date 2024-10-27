import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ProfileStatisticsScreen extends StatefulWidget {
  const ProfileStatisticsScreen({super.key});

  @override
  State<ProfileStatisticsScreen> createState() =>
      _ProfileStatisticsScreenState();
}

class _ProfileStatisticsScreenState extends State<ProfileStatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile Statistics',
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
      body: Container(),
     /* SingleChildScrollView(
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
      ),*/
    );
  }
}

class StatisticsItem extends StatelessWidget {
  const StatisticsItem(this.img, this.title, this.price,
      {super.key, this.hasCurrency});
  final String img;
  final String title;
  final String price;
  final bool? hasCurrency;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Image.asset(
            img,
            height: 40,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text(
                title,
                style: TextStyle(
                  color: Color(0xff717171),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              RichText(
                text: new TextSpan(
                  children: [
                    new TextSpan(
                      text: price,
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (hasCurrency ?? false)
                      new TextSpan(
                        text: " kwd",
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
