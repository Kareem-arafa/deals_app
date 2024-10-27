import 'package:dealz/common/title_with_viewAll.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/trend/stores_widget.dart';
import 'package:flutter/material.dart';

class MainTrendAdsScreen extends StatefulWidget {
  const MainTrendAdsScreen({super.key});

  @override
  State<MainTrendAdsScreen> createState() => _MainTrendAdsScreenState();
}

class _MainTrendAdsScreenState extends State<MainTrendAdsScreen> {
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
        centerTitle: false,
        title: Text(
          'Trend',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TitleWithViewAll(
                    title: "Latest Added",
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      TrendItem(150, hasTitle: true),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TrendItem(240, hasTitle: true),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: TrendItem(240, hasTitle: true),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      MediaQuery.removePadding(
                        context: context,
                        removeBottom: true,
                        child: ListView.separated(
                          itemCount: 7,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, int) {
                            return TrendItem(215, hasNoOpacity: true);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            height: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TitleWithViewAll(
                title: "All Stores",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StoresWidget(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TitleWithViewAll(
                title: "All Products",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StoresWidget(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class TrendItem extends StatelessWidget {
  final double height;
  final bool? hasTitle;
  final bool? hasNoOpacity;
  const TrendItem(
    this.height, {
    super.key,
    this.hasTitle,
    this.hasNoOpacity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(Assets.images.ads.path),
            ),
          ),
        ),
        if (!(hasNoOpacity ?? false))
          Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0x59000000),
            ),
          ),
        if (hasTitle ?? false)
          Positioned(
            left: 20,
            bottom: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cairo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Product Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
