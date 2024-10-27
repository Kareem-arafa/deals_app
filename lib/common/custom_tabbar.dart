import 'package:flutter/material.dart';

class CustomTabbar extends StatelessWidget {
  final List<Tab>? tabs;
  const CustomTabbar({
    super.key,
    this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xffe7e7e7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        splashBorderRadius: BorderRadius.circular(10),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        tabs: tabs ?? [],
      ),
    );
  }
}
