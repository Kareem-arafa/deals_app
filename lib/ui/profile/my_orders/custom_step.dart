import 'package:dealz/ui/profile/my_orders/track_order_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSteps extends StatefulWidget {
  List<OrderTrackingModel>? orderTracking;

  CustomSteps({Key? key, this.orderTracking}) : super(key: key);

  @override
  _CustomStepsState createState() => _CustomStepsState();
}

class _CustomStepsState extends State<CustomSteps> {
  bool _isLast(int index, int listLength) {
    return listLength - 1 == index;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        for (int i = 0; i < widget.orderTracking!.length; i += 1)
          Column(
            children: <Widget>[
              buildVertical(i),
            ],
          ),
      ],
    );
  }

  Widget buildVertical(int index) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: _buildHeaderText(index),
          ),
          SizedBox(
            width: 25,
          ),
          Column(
            children: [
              widget.orderTracking![index].title!.isEmpty
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (widget.orderTracking![index].status ==
                                        "done" ||
                                    widget.orderTracking![index].status ==
                                        "inProgress")
                                ? Color(0xff41bfad)
                                : Color(0xffb1b1b1),
                            width: 3.120000000000001,
                          ),
                          color: widget.orderTracking![index].status == "done"
                              ? Color(0xff41bfad)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
              _isLast(index, widget.orderTracking!.length)
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: 2.5,
                        height: 62,
                        color: (widget.orderTracking![index].status == "done" ||
                                widget.orderTracking![index].status ==
                                    "inProgress")
                            ? Color(0xff41bfad)
                            : Color(0xffe1e1e2),
                      ),
                    ),
            ],
          ),
          SizedBox(
            width: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: new Text(
              widget.orderTracking![index].title!,
              style: TextStyle(
                color: widget.orderTracking![index].status == "pending"
                    ? Color(0xffb1b1b1)
                    : Color(0xff212121),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          widget.orderTracking![index].trackingDate!,
          style: TextStyle(
            color: widget.orderTracking![index].status == "pending"
                ? Color(0xffb1b1b1)
                : Color(0xff212121).withOpacity(0.5),
            fontSize: 11.5,
            fontWeight: FontWeight.w200,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          widget.orderTracking![index].trackingTime!,
          style: TextStyle(
            color: widget.orderTracking![index].status == "pending"
                ? Color(0xffb1b1b1)
                : Color(0xff212121),
            fontSize: 14.5,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
