import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/profile/my_orders/custom_step.dart';
import 'package:dealz/ui/profile/my_orders/my_order_screen.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
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
          'Track Order',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              OrderItem(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        new Text(
                          "Estimated delivery",
                          style: TextStyle(
                            color: Color(0xff4a4a4a),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        new Text(
                          "21 SEPTEMBER",
                          style: TextStyle(
                            color: Color(0xff212121),
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        new Text(
                          "Order number",
                          style: TextStyle(
                            color: Color(0xff4a4a4a),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        new Text(
                          "NL2309443064",
                          style: TextStyle(
                            color: Color(0xff212121),
                            fontSize: 17,
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
              CustomSteps(
                orderTracking: [
                  OrderTrackingModel(
                    title: "Received by the courier",
                    trackingDate: "21/09/2015",
                    trackingTime: "Est. 6:00\nam",
                    status: "pending",
                  ),
                  OrderTrackingModel(
                    title: "Processed at the depot",
                    trackingDate: "21/09/2015",
                    trackingTime: "2:21\nam",
                    status: "inProgress",
                  ),
                  OrderTrackingModel(
                    title: "Delivered to the depot for\nsorting",
                    trackingDate: "20/09/2015",
                    trackingTime: "7:40\npm",
                    status: "done",
                  ),
                  OrderTrackingModel(
                    title: "Picked up from warehouse\nby Hermes",
                    trackingDate: "20/09/2015",
                    trackingTime: "5:32\npm",
                    status: "done",
                  ),
                  OrderTrackingModel(
                    title: "",
                    trackingDate: "20/09/2015",
                    trackingTime: "8:42\nam",
                    status: "done",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderTrackingModel {
  String? title;
  String? trackingDate;
  String? trackingTime;
  String? status;
  OrderTrackingModel({
    this.title,
    this.trackingDate,
    this.trackingTime,
    this.status,
  });
}
