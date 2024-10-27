import 'package:dealz/common/custom_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/cart/checkout_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Text(
                  "Airpods neck new collection",
                  style: TextStyle(
                    color: Color(0xff404040),
                  ),
                ),
                new Text(
                  "49.00 KWD",
                  style: TextStyle(
                    color: Color(0xffe44a4a),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Text(
                  "Airpods neck new collection",
                  style: TextStyle(
                    color: Color(0xff404040),
                  ),
                ),
                new Text(
                  "49.00 KWD",
                  style: TextStyle(
                    color: Color(0xffe44a4a),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Text(
                  "\tSat, 20-12-2020, 7 AM",
                  style: TextStyle(
                    color: Color(0xffb6b6b6),
                  ),
                ),
                RichText(
                  text: new TextSpan(
                    children: [
                      new TextSpan(
                        text: "Total: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      new TextSpan(
                        text: "500 ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      new TextSpan(
                        text: "KWD",
                        style: TextStyle(
                          color: Color(0xffadadad),
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ButtonWidget(
              type: ButtonType.primary,
              title: "Confirm",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Cart',
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
      body: ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        itemBuilder: (_, int index) {
          return CartItem();
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 10,
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
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
        child: Column(
          children: [
            Row(
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
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xff181818),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    new Text(
                      "4",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xff181818),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
