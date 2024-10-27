import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/profile/my_orders/track_order_screen.dart';
import 'package:flutter/material.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
            'My Orders',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xffe7e7e7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  splashBorderRadius: BorderRadius.circular(10),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: (index) {
                    setState(() {});
                  },
                  tabs: [
                    Tab(
                      text: "Waiting",
                    ),
                    Tab(
                      text: "In progress",
                    ),
                    Tab(
                      text: "Done",
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(),

     /*   ListView.separated(
          itemCount: 3,
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          itemBuilder: (_, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TrackOrderScreen(),
                  ),
                );
              },
              child: OrderItem(),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 10,
          ),
        ),*/
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      decoration: new BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xffe5e5e5),
          width: 0.95,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              Assets.images.airPods.path,
              width: 131,
              height: 118,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        "Airpods neck \nnew collection",
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.favorite_border_rounded,
                        color: Color(0xfff03b3b),
                        size: 18,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  new Text(
                    "49.00 kwd",
                    style: TextStyle(
                      color: Color(0xffe44a4a),
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      new Text(
                        "60.00 EG",
                        style: TextStyle(
                          color: Color(0xffc1c1c1),
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      new Text(
                        "50%off",
                        style: TextStyle(
                          color: Color(0xff63c57c),
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      new Container(
                        width: 65,
                        height: 20,
                        decoration: new BoxDecoration(
                          color: Color(0xfff5d235),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: new Text(
                            "Express",
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      new Text(
                        "7.0",
                        style: TextStyle(
                          color: Color(0xffc1c1c1),
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
