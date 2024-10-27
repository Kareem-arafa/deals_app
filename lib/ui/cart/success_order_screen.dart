import 'package:dealz/common/custom_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SuccessOrderScreen extends StatelessWidget {
  const SuccessOrderScreen({super.key});

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
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Image.asset(
                      Assets.images.orderDone.path,
                      height: 120,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: new Text(
                      "Your order has been received",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  new Text(
                    "It is being prepared for shipment and will be delivered to you within a few days",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff454545),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ButtonWidget(
                type: ButtonType.primary,
                onTap: () {},
                title: "Back Home",
              ),
            )
          ],
        ),
      ),
    );
  }
}
