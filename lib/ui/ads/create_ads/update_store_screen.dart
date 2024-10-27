import 'dart:io';

import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/custom_upload_pictures.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/category_model.dart';
import 'package:dealz/data/models/city_model.dart';
import 'package:dealz/data/models/create_store_model.dart';
import 'package:dealz/data/models/days_model.dart';
import 'package:dealz/data/models/deals_section_model.dart';
import 'package:dealz/data/models/my_store_model.dart';
import 'package:dealz/data/models/state_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateCreateStore extends StatelessWidget {
  final MyStoreModel storeModel;

  const UpdateCreateStore({super.key, required this.storeModel});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _CreateStoreContent(
        viewModel: viewModel,
        storeModel: storeModel,
      ),
    );
  }
}

class _CreateStoreContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final MyStoreModel storeModel;

  const _CreateStoreContent({required this.viewModel, required this.storeModel});

  @override
  State<_CreateStoreContent> createState() => _CreateStoreState();
}

class _CreateStoreState extends State<_CreateStoreContent> {
  bool isChecked = true;

  TextEditingController storeNameController = TextEditingController();
  TextEditingController instagramLinkController = TextEditingController();
  TextEditingController facebookLinkController = TextEditingController();
  TextEditingController tiktokLinkController = TextEditingController();
  TextEditingController snapchatLinkController = TextEditingController();
  TextEditingController youtubeLinkController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController whatsAppController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController openingTimeController = TextEditingController();
  TextEditingController closingTimeController = TextEditingController();
  TextEditingController commercialRecordController = TextEditingController();

  StateModel? selectedState;
  CityModel? selectedCity;
  CategoryModel? selectedCategory;
  DealsSectionModel? selectedSection;

  List<DaysModel> selectedDays = [];

  DateTime? openingTime;
  DateTime? closingTime;

  File? logo;
  File? commercialRecord;

  @override
  void initState() {
    super.initState();
    this.widget.viewModel.getStates();
    this.widget.viewModel.getSectionAds("stores");
    this.widget.viewModel.getSectionCategories(widget.storeModel.categoryId!);
    storeNameController.text = widget.storeModel.name ?? "";
    instagramLinkController.text = widget.storeModel.instagramLink ?? "";
    facebookLinkController.text = widget.storeModel.facebookLink ?? "";
    snapchatLinkController.text = widget.storeModel.snapchatLink ?? "";
    youtubeLinkController.text = widget.storeModel.youtubeLink ?? "";
    tiktokLinkController.text = widget.storeModel.tiktokLink ?? "";
    phoneNumberController.text = widget.storeModel.phone?.substring(3) ?? "";
    whatsAppController.text = widget.storeModel.whatsapp?.substring(3) ?? "";
    descriptionController.text = widget.storeModel.description ?? "";
    openingTimeController.text = widget.storeModel.openingTime ?? "";
    closingTimeController.text = widget.storeModel.closingTime ?? "";
    widget.storeModel.availableDays?.forEach((e) {
      days.forEach((day) {
        if (day.arabicName == e || day.englishName == e) {
          selectedDays.add(day);
        }
      });
    });
    final String currentDateTime = DateTime.now().toString().split(" ").first;
    print(currentDateTime);
    openingTime = DateTime.parse("$currentDateTime ${widget.storeModel.openingTime ?? "00:00"}");
    closingTime = DateTime.parse("$currentDateTime ${widget.storeModel.closingTime ?? "00:00"}");
  }

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _CreateStoreContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.viewModel.getSectionAdsReport.status == ActionStatus.complete) {
      widget.viewModel.adsSections.forEach((section) {
        if (section.id == widget.storeModel.sectionId) {
          selectedSection = section;
        }
      });
    }
    if (widget.viewModel.getSectionCategoriesReport.status == ActionStatus.complete) {
      widget.viewModel.sectionCategories.forEach((category) {
        if (category.id == widget.storeModel.categoryId) {
          selectedCategory = category;
        }
      });
    }
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.updateStoreReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.updateStoreReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }

        showToast("${this.widget.viewModel.updateStoreReport.msg}");
        this.widget.viewModel.updateStoreReport.status = null;
      } else if (this.widget.viewModel.updateStoreReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("Store updated successfully");
        Navigator.of(context).pop();
        this.widget.viewModel.updateStoreReport.status = null;
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.updateStoreReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: new Text(
                    Translations.of(context).text("createStoreEnglishName"),
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
                  hint: Translations.of(context).text("createStoreEnglishName"),
                  controller: storeNameController,
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
                    this.widget.viewModel.getSectionCategories(value.id);
                    selectedSection = value;
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
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: new Text(
                    Translations.of(context).text("createStoreInstagramLinkTitle"),
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
                  hint: Translations.of(context).text("createStoreInstagramLinkTitle"),
                  controller: instagramLinkController,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: new Text(
                    Translations.of(context).text("createStoreFacebookLinkTitle"),
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
                  hint: Translations.of(context).text("createStoreFacebookLinkTitle"),
                  controller: facebookLinkController,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: new Text(
                    Translations.of(context).text("createStoreTiktokLinkTitle"),
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
                  hint: Translations.of(context).text("createStoreTiktokLinkTitle"),
                  controller: tiktokLinkController,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: new Text(
                    Translations.of(context).text("createStoreSnapChatLinkTitle"),
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
                  hint: Translations.of(context).text("createStoreSnapChatLinkTitle"),
                  controller: snapchatLinkController,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: new Text(
                    Translations.of(context).text("createStoreYoutubeLinkTitle"),
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
                  hint: Translations.of(context).text("createStoreYoutubeLinkTitle"),
                  controller: youtubeLinkController,
                ),
                SizedBox(
                  height: 10,
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
                    Translations.of(context).text("createStoreAvailableDaysTitle"),
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
                  items: days,
                  hint: Translations.of(context).text("createStoreAvailableDaysTitle"),
                  onChange: (value) {
                    if (selectedDays.contains(value)) {
                      selectedDays.remove(value);
                    } else {
                      selectedDays.add(value);
                    }
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                if (selectedDays.isNotEmpty)
                  Container(
                    height: 40,
                    child: ListView.builder(
                        itemCount: selectedDays.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text(
                                    selectedDays[index].name(Translations.of(context).currentLanguage),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
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
                              Translations.of(context).text("createStoreOpeningTimeTitle"),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () async {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => Container(
                                  height: 216,
                                  padding: const EdgeInsets.only(top: 6.0),
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                  ),
                                  color: CupertinoColors.systemBackground.resolveFrom(context),
                                  // Use a SafeArea widget to avoid system overlaps.
                                  child: SafeArea(
                                    top: false,
                                    child: CupertinoTimerPicker(
                                      mode: CupertinoTimerPickerMode.hm,
                                      initialTimerDuration: Duration.zero,
                                      // This is called when the user changes the timer's
                                      // duration.
                                      onTimerDurationChanged: (Duration newDuration) {
                                        setState(() {
                                          final DateTime currentTime = DateTime.now();

                                          openingTime = DateTime(
                                            currentTime.year,
                                            currentTime.month,
                                            currentTime.year,
                                            newDuration.inHours,
                                            newDuration.inMinutes.remainder(60),
                                          );
                                          openingTimeController.text = DateFormat("HH:mm").format(openingTime!);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              );
                              /*final TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (BuildContext context, Widget? child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                      child: child!,
                                    );
                                  });*/

                              /*if (pickedTime != null)
                                setState(() {
                                  final DateTime currentTime = DateTime.now();

                                  openingTime = DateTime(
                                    currentTime.year,
                                    currentTime.month,
                                    currentTime.year,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                  openingTimeController.text = "${pickedTime.hour}:${pickedTime.minute}";
                                });*/
                            },
                            child: TextFieldWidget(
                              type: TextFieldType.text,
                              hint: "00:00",
                              controller: openingTimeController,
                              enabled: false,
                            ),
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
                              Translations.of(context).text("createStoreClosingTimeTitle"),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (openingTime == null) {
                                return showToast("اختر وقت الفتح اولا");
                              }
                              /*  final TimeOfDay? pickedTime = await */
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => Container(
                                  height: 216,
                                  padding: const EdgeInsets.only(top: 6.0),
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                  ),
                                  color: CupertinoColors.systemBackground.resolveFrom(context),
                                  // Use a SafeArea widget to avoid system overlaps.
                                  child: SafeArea(
                                    top: false,
                                    child: CupertinoTimerPicker(
                                      mode: CupertinoTimerPickerMode.hm,
                                      initialTimerDuration: Duration(hours: openingTime!.hour, minutes: openingTime!.minute),
                                      // This is called when the user changes the timer's
                                      // duration.
                                      onTimerDurationChanged: (Duration newDuration) {
                                        final DateTime currentTime = DateTime.now();

                                        final newClosingDate = DateTime(
                                          currentTime.year,
                                          currentTime.month,
                                          currentTime.year,
                                          newDuration.inHours,
                                          newDuration.inMinutes.remainder(60),
                                        );

                                        if (newClosingDate.isAfter(openingTime!)) {
                                          setState(() {
                                            closingTime = newClosingDate;
                                            closingTimeController.text = DateFormat("HH:mm").format(closingTime!);
                                          });
                                        } else {
                                          return showToast("وقت الإغلاق لابد ان يكون بعد وقت الفتح");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              );

                              /*showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (BuildContext context, Widget? child) {
                                    return child!; */ /*MediaQuery(
                                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                      child: child!,
                                    );*/ /*
                                  });*/

                              /*final DateTime currentTime = DateTime.now();

                              if (pickedTime != null) {
                                final newClosingDate = DateTime(
                                  currentTime.year,
                                  currentTime.month,
                                  currentTime.year,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );

                                if (newClosingDate.isAfter(openingTime!)) {
                                  setState(() {
                                    closingTime = newClosingDate;
                                    closingTimeController.text = "${pickedTime.hour}:${pickedTime.minute}";
                                  });
                                } else {
                                  return showToast("وقت الإغلاق لابد ان يكون بعد وقت الفتح");
                                }
                              }*/
                            },
                            child: TextFieldWidget(
                              type: TextFieldType.text,
                              hint: "00:00",
                              controller: closingTimeController,
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                CustomUploadPictures(
                  title: Translations.of(context).text("createStoreAddCoverTitle"),
                  isNotRequired: false,
                  onImageSelected: (file) {
                    logo = file;
                  },
                  onImageRemoved: (File) {
                    logo = null;
                  },
                  isMultiImage: false,
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: new Text(
                    Translations.of(context).text("CreateAdsPhoneTitle"),
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
                  controller: phoneNumberController,
                  maxLength: 8,
                  keyboardType: TextInputType.phone,
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
                  maxLength: 8,
                  keyboardType: TextInputType.phone,
                ),
                // SizedBox(
                //   height: 25,
                // ),
                /* Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: new Text(
                    Translations.of(context).text("CreateAdsArabicDescriptionTitle"),
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
                  hint: Translations.of(context).text("CreateAdsArabicDescriptionTitle"),
                  controller: arabicDescriptionController,
                  maxLines: 5,
                ),*/
                SizedBox(
                  height: 25,
                ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      new Text(
                        Translations.of(context).text("createStoreCommercialRecordTitle"),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      new Text(
                        Translations.of(context).text("createStoreOptionalTitle"),
                        style: TextStyle(
                          color: Color(0xffbebebe),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                  type: TextFieldType.text,
                  hint: Translations.of(context).text("createStoreCommercialRecordTitle"),
                  controller: commercialRecordController,
                  suffixIcon: InkWell(
                    onTap: () async {
                      var file = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (file != null) {
                        commercialRecord = File(file.path);
                        int sizeInByte = await file.length();
                        int sizeInKB = sizeInByte ~/ 1024;
                        print(sizeInKB);
                        if (sizeInKB > 2048) {
                          showToast("حجم الصورة يجب ان يكون اقل من ٢ ميجابيت");
                          return;
                        }
                        commercialRecordController.text = file.name;
                        setState(() {});
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: new Text(
                            Translations.of(context).text("createStoreUploadTitle"),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 29,
                        width: 27,
                        decoration: BoxDecoration(
                          color: isChecked ? Theme.of(context).primaryColor : Colors.white,
                          border: Border.all(
                            color: isChecked ? Colors.transparent : Color(0xff979797),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            Assets.images.check.path,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        Translations.of(context).text("createStoreAgreeTermsAndConditionTitle"),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ButtonWidget(
                  type: ButtonType.primary,
                  title: Translations.of(context).text("updateStoreLabel"),
                  onTap: () {
                    if (!isChecked) {
                      return showToast(Translations.of(context).text("createStoreTermsAndConditionErrorMessage"));
                    }
                    if (storeNameController.text.isEmpty) {
                      return showToast(Translations.of(context).text("createStoreStoreEnglishNameErrorMessage"));
                    }
                    if (selectedSection == null) {
                      return showToast(Translations.of(context).text("createAdsSectionTitleErrorMessage"));
                    }
                    if (selectedCategory == null) {
                      return showToast(Translations.of(context).text("createStoreCategoryErrorMessage"));
                    }
                    if (numberOfValidInput() == 0) {
                      return showToast(Translations.of(context).text("createStoreSocialMediaErrorMessage"));
                    }
                    if (phoneNumberController.text.isEmpty || phoneNumberController.text.length < 8) {
                      return showToast(Translations.of(context).text("createAdsPhoneNumberErrorMessage"));
                    }
                    if (whatsAppController.text.isEmpty || whatsAppController.text.length < 8) {
                      return showToast(Translations.of(context).text("createAdsWhatsAppTitleErrorMessage"));
                    }
                    if (descriptionController.text.isEmpty) {
                      return showToast(Translations.of(context).text("createAdsEnglishDescriptionTitleErrorMessage"));
                    }
                    /*if (selectedState == null) {
                      return showToast(Translations.of(context).text("createAdsStateTitleErrorMessage"));
                    }
                    if (selectedCity == null) {
                      return showToast(Translations.of(context).text("createAdsCityTitleErrorMessage"));
                    }*/
                    if (selectedDays.isEmpty) {
                      return showToast(Translations.of(context).text("createStoreDaysErrorMessage"));
                    }
                    if (openingTime == null) {
                      return showToast(Translations.of(context).text("createStoreOpenTimeErrorMessage"));
                    }
                    if (closingTime == null) {
                      return showToast(Translations.of(context).text("createStoreCloseTimeErrorMessage"));
                    }
                    /*if (logo == null) {
                      return showToast(Translations.of(context).text("createStoreLogoErrorMessage"));
                    }*/

                    final CreateStoreModel createStore = CreateStoreModel(
                      name: storeNameController.text,
                      description: descriptionController.text,
                      categoryId: selectedCategory!.id!,
                      sectionId: selectedSection!.id!,
                      phone: "965${phoneNumberController.text}",
                      cityId: selectedCity?.id ?? widget.storeModel.categoryId!,
                      availableDays: selectedDays.map((e) => e.name("en")).toList(),
                      openTime: DateFormat("HH:mm").format(openingTime!),
                      closeTime: DateFormat("HH:mm").format(closingTime!),
                      whatsapp: "965${whatsAppController.text}",
                      instagramLink: instagramLinkController.text,
                      logo: logo,
                      commercialRecord: commercialRecord,
                      facebookLink: facebookLinkController.text,
                      tiktokLink: tiktokLinkController.text,
                      snapchatLink: snapchatLinkController.text,
                      youtubeLink: youtubeLinkController.text,
                      packageId: widget.storeModel.packageId!,
                    );
                    this.widget.viewModel.updateStore(widget.storeModel.id!, createStore);
                  },
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

  int numberOfValidInput() {
    int invalidLinks = 0;
    if (instagramLinkController.text.isNotEmpty) {
      invalidLinks += 1;
    }
    if (facebookLinkController.text.isNotEmpty) {
      invalidLinks += 1;
    }
    if (snapchatLinkController.text.isNotEmpty) {
      invalidLinks += 1;
    }
    if (youtubeLinkController.text.isNotEmpty) {
      invalidLinks += 1;
    }
    if (tiktokLinkController.text.isNotEmpty) {
      invalidLinks += 1;
    }
    return invalidLinks;
  }
}
