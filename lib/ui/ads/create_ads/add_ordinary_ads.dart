import 'dart:io';

import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/custom_upload_pictures.dart';
import 'package:dealz/common/pick_address.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/attributes_models.dart';
import 'package:dealz/data/models/category_model.dart';
import 'package:dealz/data/models/city_model.dart';
import 'package:dealz/data/models/create_ordinary_ads_model.dart';
import 'package:dealz/data/models/deals_section_model.dart';
import 'package:dealz/data/models/feature_model.dart';
import 'package:dealz/data/models/state_model.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/create_ads/plans/plan_one_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:collection/collection.dart';
import 'package:geocode/geocode.dart';

class AddOrdinaryAds extends StatelessWidget {
  const AddOrdinaryAds({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AddOrdinaryAdsContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _AddOrdinaryAdsContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _AddOrdinaryAdsContent({required this.viewModel});

  @override
  State<_AddOrdinaryAdsContent> createState() => _AddOrdinaryAdsState();
}

class _AddOrdinaryAdsState extends State<_AddOrdinaryAdsContent> {
  TextEditingController titleController = TextEditingController();
  TextEditingController whatsAppController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  StateModel? selectedState;
  CityModel? selectedCity;
  DealsSectionModel? selectedSection;
  CategoryModel? selectedCategory;

  List<File> images = [];

  bool showInSpecial = false;

  List<FeatureModel> features = [];

  Coordinates? adsCoordinates;

  Map<int, Options> attributes = {};

  @override
  void initState() {
    super.initState();
    this.widget.viewModel.getStates();
    this.widget.viewModel.getSectionAds("ads");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("CreateAdsArabicTitle"),
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
          hint: Translations.of(context).text("CreateAdsArabicTitle"),
          controller: arabicTitleController,
        ),
        SizedBox(
          height: 25,
        ),*/
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("CreateAdsEnglishTitle"),
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
          hint: Translations.of(context).text("CreateAdsEnglishTitle"),
          controller: titleController,
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("CreateAdsSectionTitle"),
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
          items: this.widget.viewModel.adsSections,
          hint: Translations.of(context).text("CreateAdsSectionTitle"),
          value: selectedSection,
          onChange: (value) {
            selectedSection = value;
            this.widget.viewModel.getAdsFeatures(selectedSection!.id!);
            this.widget.viewModel.getSectionCategories(selectedSection!.id!);
            this.widget.viewModel.getSectionAttributes(selectedSection!.id!);
            features.clear();
            selectedCategory = null;
            setState(() {});
          },
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("createStoreCategoryTitle"),
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
          items: this.widget.viewModel.sectionCategories,
          hint: Translations.of(context).text("createStoreCategoryTitle"),
          value: selectedCategory,
          onChange: (value) {
            selectedCategory = value;
            setState(() {});
          },
        ),
        SizedBox(
          height: 25,
        ),
        if (selectedSection != null)
          widget.viewModel.getSectionAttributesReport.status == ActionStatus.running
              ? Center(
                  child: CupertinoActivityIndicator(
                    animating: true, // Control animation
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : ListView.builder(
                  itemCount: this.widget.viewModel.sectionAttributes.length,
                  itemBuilder: (context, index) {
                    final SectionAttributesModel sectionAttributes = this.widget.viewModel.sectionAttributes[index];
                    if (sectionAttributes.type == "text") {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              sectionAttributes.name ?? "",
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
                            hint: sectionAttributes.name ?? "",
                            suffixIcon: Align(
                              widthFactor: 0.125,
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(sectionAttributes.unit ?? ""),
                            ),
                            onChanged: (text) {
                              attributes[sectionAttributes.id!] = Options(
                                optionName: text,
                              );
                              setState(() {});
                              return text;
                            },
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      );
                    } else if (sectionAttributes.type == "number") {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              sectionAttributes.name ?? "",
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
                            hint: sectionAttributes.name ?? "",
                            suffixIcon: Align(
                              widthFactor: 0.125,
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(sectionAttributes.unit ?? ""),
                            ),
                            onChanged: (text) {
                              attributes[sectionAttributes.id!] = Options(
                                optionName: text,
                              );
                              setState(() {});
                              return text;
                            },
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              sectionAttributes.name ?? "",
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
                            items: sectionAttributes.options,
                            hint: sectionAttributes.name ?? "",
                            value: null,
                            onChange: (value) {
                              attributes[sectionAttributes.id!] = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      );
                    }
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("CreateAdsPriceTitle"),
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
          hint: Translations.of(context).text("CreateAdsPriceTitle"),
          keyboardType: TextInputType.number,
          controller: priceController,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("priceNote"),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.red[300],
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("CreateAdsChooseStateTitle"),
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
          items: this.widget.viewModel.states,
          hint: Translations.of(context).text("CreateAdsChooseStateTitle"),
          value: selectedState,
          onChange: (value) {
            this.widget.viewModel.getCities(value.id);
            selectedState = value;
            selectedCity = null;
            setState(() {});
          },
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("CreateAdsChooseCityTitle"),
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
          items: this.widget.viewModel.cities,
          hint: Translations.of(context).text("CreateAdsChooseCityTitle"),
          value: selectedCity,
          onChange: (value) {
            selectedCity = value;
            setState(() {});
          },
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("CreateAdsWhatsAppTitle"),
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
          type: TextFieldType.phone,
          hint: "12345678",
          controller: whatsAppController,
          keyboardType: TextInputType.phone,
          maxLength: 8,
        ),
        SizedBox(
          height: 25,
        ),
        /*  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("CreateAdsArabicDescriptionTitle"),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),*/
        /*   SizedBox(
          height: 15,
        ),
        TextFieldWidget(
          type: TextFieldType.text,
          hint: Translations.of(context).text("CreateAdsArabicDescriptionTitle"),
          controller: arabicDescriptionController,
          maxLines: 5,
        ),
        SizedBox(
          height: 25,
        ),*/
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("CreateAdsEnglishDescriptionTitle"),
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
          hint: Translations.of(context).text("CreateAdsEnglishDescriptionTitle"),
          controller: descriptionController,
          maxLines: 5,
        ),
        SizedBox(
          height: 25,
        ),
        CustomUploadPictures(
          title: Translations.of(context).text("CreateAdsAddPhotosTitle"),
          onImageSelected: (file) {
            images.add(file);
          },
          onImageRemoved: (file) {
            images.removeAt(file);
          },
          isMultiImage: true,
        ),
        SizedBox(
          height: 25,
        ),
        /* ListView.builder(
          shrinkWrap: true,
          itemCount: features.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return FeatureWidget(
              arabicTitleController: features[index].nameAr,
              englishTitleController: features[index].nameEn,
              onImageSelected: (file) {
                features[index].image = file;
              },
              onImageRemoved: (file) {
                features[index].image = null;
              },
            );
          },
        ),*/
        /*ButtonWidget(
          type: ButtonType.secondary,
          title: Translations.of(context).text("CreateAdsAddNewFeatureButtonTitle"),
          onTap: () {
            features.add(
              FeatureModel(
                nameAr: TextEditingController(),
                nameEn: TextEditingController(),
                image: null,
              ),
            );
            setState(() {});
          },
        ),*/
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: new Text(
            Translations.of(context).text("featuresLabel"),
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
          items: this.widget.viewModel.features,
          hint: Translations.of(context).text("featuresLabel"),
          value: features.isEmpty ? null : features.last,
          onChange: (value) {
            if (features.contains(value)) {
              features.remove(value);
            } else {
              features.add(value);
            }
            setState(() {});
          },
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
          runSpacing: 8,
          spacing: 8,
          children: features
              .mapIndexed(
                (index, feature) => Chip(
                  label: Text(feature.name(Translations.of(context).currentLanguage)),
                  labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  backgroundColor: Colors.blue,
                  deleteIcon: Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                  onDeleted: () {
                    features.removeAt(index);
                    setState(() {});
                  },
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddAddressScreen(
                      setAddress: (location, coordinates) {
                        setState(() {
                          addressController.text = location;
                          adsCoordinates = coordinates;
                        });
                      },
                    )));
          },
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: IgnorePointer(
                  ignoring: true,
                  child: TextFieldWidget(
                    controller: addressController,
                    type: TextFieldType.text,
                    hint: Translations.of(context).text("chooseYourLocationOnMap"),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Icon(
                        Icons.location_on_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translations.of(context).text("CreateAdsShowInSpecialAdsTitle"),
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            FlutterSwitch(
              value: showInSpecial,
              height: 30,
              width: 60,
              activeColor: Theme.of(context).primaryColor,
              showOnOff: false,
              onToggle: (val) {
                setState(() {
                  showInSpecial = val;
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        ButtonWidget(
          type: ButtonType.primary,
          title: Translations.of(context).text("CreateAdsButtonTitle"),
          onTap: () {
            final List<AttributesModel> finalAttributes = [];
            if (attributes.isNotEmpty) {
              attributes.forEach((key, value) {
                final AttributesModel attribute = AttributesModel(
                  attributeId: key,
                  attributeValue: value.id ?? value.optionName,
                );
                finalAttributes.add(attribute);
              });
            }
            if (titleController.text.isEmpty) {
              return showToast(Translations.of(context).text("createAdsArabicTitleErrorMessage"));
            }
            if (selectedSection == null) {
              return showToast(Translations.of(context).text("createAdsSectionTitleErrorMessage"));
            }
            if (selectedCategory == null) {
              return showToast(Translations.of(context).text("createStoreCategoryErrorMessage"));
            }
            /*if (priceController.text.isEmpty) {
              return showToast(Translations.of(context).text("createAdsPriceTitleErrorMessage"));
            }*/
            if (selectedState == null) {
              return showToast(Translations.of(context).text("createAdsStateTitleErrorMessage"));
            }
            if (selectedCity == null) {
              return showToast(Translations.of(context).text("createAdsCityTitleErrorMessage"));
            }
            if (whatsAppController.text.isEmpty || whatsAppController.text.length < 8) {
              return showToast(Translations.of(context).text("createAdsWhatsAppTitleErrorMessage"));
            }
            if (descriptionController.text.isEmpty) {
              return showToast(Translations.of(context).text("createAdsArabicDescriptionTitleErrorMessage"));
            }
            if (images.isEmpty) {
              return showToast(Translations.of(context).text("createAdsImagesTitleErrorMessage"));
            }
            CreateOrdinaryAdsModel model = CreateOrdinaryAdsModel(
              description: descriptionController.text,
              title: titleController.text,
              whatsApp: "965${whatsAppController.text}",
              images: images,
              sectionId: selectedSection!.id!,
              cityId: selectedCity!.id!,
              stateId: selectedState!.id!,
              features: features,
              price: priceController.text.isEmpty ? null : priceController.text,
              showInSpecialAds: showInSpecial,
              categoryId: selectedCategory!.id!,
              lang: adsCoordinates?.longitude,
              lat: adsCoordinates?.latitude,
              attributes: finalAttributes,
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlanOneScreen(
                  createOrdinaryAdsModel: model,
                  adType: "ordinary",
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
