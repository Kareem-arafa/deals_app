import 'dart:io';

import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/custom_upload_pictures.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/data/models/store_product_model.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/stores/products_colors_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../common/toast_utils.dart';

class AddProductToStoreScreen extends StatelessWidget {
  final int storeId;

  const AddProductToStoreScreen({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AddProductToStoreScreenContent(
        viewModel: viewModel,
        storeId: storeId,
      ),
    );
  }
}

class _AddProductToStoreScreenContent extends StatefulWidget {
  final int storeId;
  final HomeViewModel viewModel;

  const _AddProductToStoreScreenContent({required this.storeId, required this.viewModel});

  @override
  State<_AddProductToStoreScreenContent> createState() => _AddProductToStoreScreenState();
}

class _AddProductToStoreScreenState extends State<_AddProductToStoreScreenContent> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discount = TextEditingController();
  List<File> images = [];

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _AddProductToStoreScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.addProductToStoreReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.addProductToStoreReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.addProductToStoreReport.msg}");
        this.widget.viewModel.addProductToStoreReport.status = null;
      } else if (this.widget.viewModel.addProductToStoreReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        Navigator.pop(context);

        this.widget.viewModel.addProductToStoreReport.status = null;
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translations.of(context).text("addProductScreenTitle"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                child: Text(
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
                onChanged: (text) {
                  setState(() {});
                  return text;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  Translations.of(context).text("priceNote"),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.red[300],
                  ),
                ),
              ),
              if (priceController.text.isNotEmpty) ...[
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Discount",
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
                  hint: "Discount",
                  keyboardType: TextInputType.number,
                  controller: discount,
                ),
              ],
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
              ColorVariantPage(),
              SizedBox(
                height: 25,
              ),
              ButtonWidget(
                type: ButtonType.primary,
                title: Translations.of(context).text("addProductScreenTitle"),
                onTap: () {
                  if (titleController.text.isEmpty) {
                    return showToast(Translations.of(context).text("createAdsArabicTitleErrorMessage"));
                  }
                  if (descriptionController.text.isEmpty) {
                    return showToast(Translations.of(context).text("createAdsArabicDescriptionTitleErrorMessage"));
                  }
                  /*if (priceController.text.isEmpty) {
                    return showToast(Translations.of(context).text("createAdsPriceTitleErrorMessage"));
                  }*/
                  if (images.isEmpty) {
                    return showToast(Translations.of(context).text("createAdsImagesTitleErrorMessage"));
                  }
                  if (discount.text.isNotEmpty) {
                    final num percentage = num.parse(discount.text);
                    if (percentage < 0 || percentage > 100) return showToast("Discount must be between 0 and 100");
                  }

                  final StoreProductModel productModel = StoreProductModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    imagesFile: images,
                    price: priceController.text.isEmpty ? null : num.parse(priceController.text),
                    discount: discount.text.isEmpty ? null : num.parse(discount.text),
                  );
                  this.widget.viewModel.addProductToStore(widget.storeId, productModel);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
