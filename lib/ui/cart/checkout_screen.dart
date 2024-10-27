import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/cart/bill_screen.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int? selectedIndex;
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
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: new Text(
                  "Done",
                  style: TextStyle(
                    color: Color(0xff242424),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text(
                "Check Out",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              new Text(
                "Billing Adress",
                style: TextStyle(
                  color: Color(0xff343434),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                type: TextFieldType.text,
                controller: TextEditingController(),
                hint: "Name",
                borderColor: Color(0xffcbcbcb),
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                type: TextFieldType.text,
                controller: TextEditingController(),
                hint: "Email",
                borderColor: Color(0xffcbcbcb),
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                type: TextFieldType.text,
                controller: TextEditingController(),
                hint: "Phone",
                borderColor: Color(0xffcbcbcb),
              ),
              SizedBox(
                height: 15,
              ),
              CustomDropdownButton(
                items: [],
                hint: "Adress",
                borderColor: Color(0xffcbcbcb),
                onChange: (value) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 25,
              ),
              new Text(
                "Promo Code",
                style: TextStyle(
                  color: Color(0xff343434),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 45,
                child: TextFieldWidget(
                  type: TextFieldType.text,
                  controller: TextEditingController(),
                  hint: "Gift certificate or promo code",
                  borderColor: Color(0xffcbcbcb),
                  suffixIcon: new Container(
                    width: 75,
                    height: 45,
                    decoration: new BoxDecoration(
                      color: Color(0xff323232),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Center(
                      child: new Text(
                        "Apply",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              new Text(
                "Billing Options",
                style: TextStyle(
                  color: Color(0xff343434),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                removeTop: true,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffd8d8d8).withOpacity(0.28),
                          border: Border.all(
                            color: Color(0xff979797).withOpacity(0.28),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: new Container(
                                  width: 27,
                                  height: 27,
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xffcbcbcb),
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedIndex == index
                                            ? Color(0xff75b886)
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: selectedIndex == index
                                              ? Color(0xff979797)
                                              : Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  new Text(
                                    "C.O,D",
                                    style: TextStyle(
                                      color: Color(0xff0e0f14),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  new Text(
                                    "chasheir check or cash only ",
                                    style: TextStyle(
                                      color: Color(0xff0e0f14).withOpacity(0.5),
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )
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
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      child: TextFieldWidget(
                        type: TextFieldType.text,
                        hint: "Asmaa reda *6788",
                        borderColor: Color(0xffcbcbcb),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 45,
                      child: TextFieldWidget(
                        type: TextFieldType.text,
                        hint: "CVV",
                        borderColor: Color(0xffcbcbcb),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    Assets.images.mastercard.path,
                    height: 25,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    Assets.images.visa.path,
                    height: 35,
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              ButtonWidget(
                type: ButtonType.primary,
                title: "Confirm",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BillScreen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
