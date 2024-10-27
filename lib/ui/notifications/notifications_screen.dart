import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/notifications/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          'Notifications',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: "8 ",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        new TextSpan(
                          text: "Unread",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    Assets.images.close.path,
                    height: 25,
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (_, int index) {
                  return Opacity(
                    opacity:
                        (index == 0 || index == 1 || index == 2 || index == 3)
                            ? 1
                            : 0.5,
                    child: NotificationItem(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
