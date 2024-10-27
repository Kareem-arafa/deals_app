import 'dart:io';

import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/custom_upload_pictures.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/create_commercial_ads_model.dart';
import 'package:dealz/data/models/deals_section_model.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/create_ads/plans/plan_one_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CommercialAd extends StatelessWidget {
  const CommercialAd({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _CommercialAdContent(
        viewModel: viewModel,
      ),
    );
  }
}


class _CommercialAdContent extends StatefulWidget {
  final HomeViewModel viewModel;
  const _CommercialAdContent({super.key, required this.viewModel});

  @override
  State<_CommercialAdContent> createState() => _CommercialAdState();
}

class _CommercialAdState extends State<_CommercialAdContent> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  DealsSectionModel? selectedSection;

  File? image;

  @override
  void initState() {
    super.initState();
    widget.viewModel.getSectionAds("commercial");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          controller: phoneController,
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
          controller: whatsappController,
          maxLength: 8,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(
          height: 15,
        ),
        CustomDropdownButton(
          items: widget.viewModel.adsSections,
          hint: Translations.of(context).text("CreateAdsSectionTitle"),
          value: selectedSection,
          onChange: (value) {
            selectedSection = value;
            setState(() {});
          },
        ),
        SizedBox(
          height: 25,
        ),
        CustomUploadPictures(
          title: Translations.of(context).text("CreateAdsAddPhotosTitle"),
          onImageSelected: (file) {
            image = file;
          },
          onImageRemoved: (file) {
            image = null;
          },
          isMultiImage: false,
        ),
        SizedBox(
          height: 40,
        ),
        ButtonWidget(
          type: ButtonType.primary,
          title: Translations.of(context).text("CreateAdsButtonTitle"),
          onTap: () {
            if (phoneController.text.isEmpty || phoneController.text.length < 8) {
              return showToast(Translations.of(context).text("createAdsPhoneNumberErrorMessage"));
            }
            if (whatsappController.text.isEmpty || whatsappController.text.length < 8) {
              return showToast(Translations.of(context).text("createAdsWhatsAppTitleErrorMessage"));
            }
            if (image == null) {
              return showToast(Translations.of(context).text("createAdsImagesTitleErrorMessage"));
            }

            CreateCommercialAdsModel createCommercialAdsModel = CreateCommercialAdsModel(
              phone: "965${phoneController.text}",
              whatsapp: "965${whatsappController.text}",
              image: image!,
              sectionId: selectedSection?.id,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlanOneScreen(
                  createCommercialAdsModel: createCommercialAdsModel,
                  adType: "commercial",
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
