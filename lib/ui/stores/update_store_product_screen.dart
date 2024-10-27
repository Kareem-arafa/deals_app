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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../common/toast_utils.dart';

class UpdateStoreProductScreen extends StatelessWidget {
  final int storeId;
  final StoreProductModel productModel;

  const UpdateStoreProductScreen({
    super.key,
    required this.storeId,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AddProductToStoreScreenContent(
        viewModel: viewModel,
        storeId: storeId,
        productModel: productModel,
      ),
    );
  }
}

class _AddProductToStoreScreenContent extends StatefulWidget {
  final int storeId;
  final HomeViewModel viewModel;
  final StoreProductModel productModel;

  const _AddProductToStoreScreenContent({required this.storeId, required this.viewModel, required this.productModel});

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
  void initState() {
    super.initState();
    titleController.text = widget.productModel.title ?? "";
    descriptionController.text = widget.productModel.description ?? "";
    priceController.text = widget.productModel.price?.toString() ?? "";
    discount.text = widget.productModel.discount?.toString() ?? "";
  }

  @override
  void didUpdateWidget(covariant _AddProductToStoreScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.updateProductToStoreReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.updateProductToStoreReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.updateProductToStoreReport.msg}");
        this.widget.viewModel.updateProductToStoreReport.status = null;
      } else if (this.widget.viewModel.updateProductToStoreReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        Navigator.pop(context);
        Navigator.pop(context);

        this.widget.viewModel.updateProductToStoreReport.status = null;
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
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: new Text(
                  Translations.of(context).text("discountLabel"),
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
                hint: Translations.of(context).text("discountLabel"),
                keyboardType: TextInputType.number,
                controller: discount,
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
              ButtonWidget(
                type: ButtonType.primary,
                title: Translations.of(context).text("updateProductLabel"),
                onTap: () {
                  if (titleController.text.isEmpty) {
                    return showToast(Translations.of(context).text("createAdsArabicTitleErrorMessage"));
                  }
                  if (descriptionController.text.isEmpty) {
                    return showToast(Translations.of(context).text("createAdsArabicDescriptionTitleErrorMessage"));
                  }
                  if (priceController.text.isEmpty) {
                    return showToast(Translations.of(context).text("createAdsPriceTitleErrorMessage"));
                  }
                  if (discount.text.isNotEmpty) {
                    final num percentage = num.parse(discount.text);
                    if (percentage < 0 && percentage > 100)
                      return showToast(Translations.of(context).text("discountErrorMessage"));
                  }

                  final StoreProductModel productModel = StoreProductModel(
                    id: widget.productModel.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    imagesFile: images,
                    price: num.parse(priceController.text),
                    discount: num.parse(discount.text),
                  );
                  this.widget.viewModel.updateProductToStore(widget.storeId, productModel);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
