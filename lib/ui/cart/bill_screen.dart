import 'package:dealz/common/custom_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  int? selectedIndex;
  List<String> titles = [
    "Cash",
    "Credit/ Debit Card",
  ];
  List<String> images = [
    Assets.images.money.path,
    Assets.images.creditCard.path,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0) + EdgeInsets.only(bottom: 16),
        child: ButtonWidget(
          type: ButtonType.primary,
          title: "Confirm",
        ),
      ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.all(16.0) + EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  Assets.images.doc.path,
                  height: 110,
                ),
                SizedBox(
                  height: 6,
                ),
                RichText(
                  text: new TextSpan(
                    children: [
                      new TextSpan(
                        text: "500 ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.5,
                        ),
                      ),
                      new TextSpan(
                        text: "KWD",
                        style: TextStyle(
                          color: Color(0xffadadad),
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                new Text(
                  "\tSat, 20-12-2020, 7 AM",
                  style: TextStyle(
                    color: Color(0xffb6b6b6),
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    new Text(
                      "Product Name:  ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    new Text(
                      "Airpodshhfnc",
                      style: TextStyle(
                        color: Color(0xff393939),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    new Text(
                      "Full Adress :  ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    new Text(
                      "Maadi Elaslky,38949",
                      style: TextStyle(
                        color: Color(0xff393939),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    new Text(
                      "Payment Method:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                ListView.separated(
                  itemCount: titles.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: new Container(
                        width: double.infinity,
                        height: 57,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x0d000000),
                                offset: Offset(0, 0),
                                blurRadius: 70,
                                spreadRadius: 0)
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? Theme.of(context).primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                    color: selectedIndex == index
                                        ? Colors.transparent
                                        : Color(0xffbababa),
                                    width: 1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.done,
                                  color: selectedIndex == index
                                      ? Colors.black
                                      : Colors.transparent,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Image.asset(
                                images[index],
                                height: 18,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              new Text(
                                titles[index],
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: 15,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
