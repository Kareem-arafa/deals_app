import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/common/custom_tabbar.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/custom_upload_pictures.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AddCarForSale extends StatefulWidget {
  const AddCarForSale({super.key});

  @override
  State<AddCarForSale> createState() => _AddCarForSaleState();
}

class _AddCarForSaleState extends State<AddCarForSale> {
  List<String> carFeatures = [
    "AC",
    "Bluetooth",
    "Navigation",
    "Sensor",
  ];
  int? selectedFeature;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: new Text(
              "What are you selling",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CustomDropdownButton(
            items: [],
            hint: "Automotive",
            onChange: (value) {
              setState(() {});
            },
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: new Text(
              "Type",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CustomDropdownButton(
            items: [],
            hint: "Cars",
            onChange: (value) {
              setState(() {});
            },
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: new Text(
              "Model",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CustomDropdownButton(
            items: [],
            hint: "mERCIDES",
            onChange: (value) {
              setState(() {});
            },
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: new Text(
              "Choose Location",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            type: TextFieldType.text,
            hint: "Choose Your Listing Location",
            controller: TextEditingController(),
            suffixIcon: Image.asset(
              Assets.images.add.path,
              cacheHeight: 20,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: new Text(
              "Title",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            type: TextFieldType.text,
            hint: "Example ..",
            controller: TextEditingController(),
          ),
          SizedBox(
            height: 25,
          ),
          CustomUploadPictures(
            title: "Add up to 5 Photos ",
            onImageSelected: (file) {}, onImageRemoved: (File ) {  },
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: new Text(
              "Condition",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CustomTabbar(
            tabs: [
              Tab(
                text: "X",
              ),
              Tab(
                text: "New",
              ),
              Tab(
                text: "Used",
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: new Text(
                        "Model",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomDropdownButton(
                      items: [],
                      hint: "Example ..",
                      onChange: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: new Text(
                        "Fuel Type",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomDropdownButton(
                      items: [],
                      hint: "Example ..",
                      onChange: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: new Text(
                        "Color Interior",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomDropdownButton(
                      items: [],
                      hint: "Example ..",
                      onChange: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: new Text(
                        "Seats Material",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomDropdownButton(
                      items: [],
                      hint: "Example ..",
                      onChange: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: new Text(
              "Transmission",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CustomTabbar(
            tabs: [
              Tab(
                text: "X",
              ),
              Tab(
                text: "Auto",
              ),
              Tab(
                text: "Manual",
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: new Text(
              "Sunroof",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CustomTabbar(
            tabs: [
              Tab(
                text: "X",
              ),
              Tab(
                text: "Normal",
              ),
              Tab(
                text: "Panorama",
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: new Text(
                        "Car Condition",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomDropdownButton(
                      items: [],
                      hint: "Example ..",
                      onChange: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: new Text(
                        "Cylinders",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomDropdownButton(
                      items: [],
                      hint: "Example ..",
                      onChange: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: new Text(
              "Car Features",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          new Container(
            width: double.infinity,
            height: 252,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: ListView.separated(
                itemCount: carFeatures.length,
                shrinkWrap: true,
                itemBuilder: (_, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedFeature = index;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 23,
                          width: 23,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xff979797),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.asset(
                              Assets.images.check.path,
                              color: selectedFeature == index
                                  ? null
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Image.asset(
                          Assets.images.bluetooth.path,
                          height: 20,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        new Text(carFeatures[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ))
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 25,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ButtonWidget(
            type: ButtonType.primary,
            title: "Place Add",
            onTap: () {},
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
