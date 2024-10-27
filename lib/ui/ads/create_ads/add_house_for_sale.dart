import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/custom_upload_pictures.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AddHouseForSale extends StatefulWidget {
  const AddHouseForSale({super.key});

  @override
  State<AddHouseForSale> createState() => _AddHouseForSaleState();
}

class _AddHouseForSaleState extends State<AddHouseForSale> {
  List<String> houseFeatures = [
    "AC",
    "Bluetooth",
    "Navigation",
    "Sensor",
  ];
  int? selectedFeature;
  @override
  Widget build(BuildContext context) {
    return Column(
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
          hint: "For sale - House For Sale",
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
          title: "Add Photos ",
          onImageSelected: (file) {}, onImageRemoved: (File ) {  },
        ),
        SizedBox(
          height: 25,
        ),
        CustomUploadPictures(
          title: "Add Photos ",
          onImageSelected: (file) {}, onImageRemoved: (File ) {  },
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            "Rooms",
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            "What’s App",
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
          hint: "087 018837599040",
          controller: TextEditingController(),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            "House Features",
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
              itemCount: houseFeatures.length,
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
                        Assets.images.airConditioner.path,
                        height: 20,
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      new Text(houseFeatures[index],
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
    );
  }
}
