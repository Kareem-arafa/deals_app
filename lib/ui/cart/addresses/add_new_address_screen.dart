import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/address_model.dart';
import 'package:dealz/data/models/city_model.dart';
import 'package:dealz/data/models/state_model.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AddNewAddressContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _AddNewAddressContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _AddNewAddressContent({super.key, required this.viewModel});

  @override
  State<_AddNewAddressContent> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<_AddNewAddressContent> {
  TextEditingController addressNameController = TextEditingController();
  TextEditingController addressLineController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  StateModel? selectedState;
  CityModel? selectedCity;

  @override
  void initState() {
    super.initState();
    widget.viewModel.getStates();
  }

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _AddNewAddressContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.createAddressesReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.createAddressesReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }

        showToast("${this.widget.viewModel.createAddressesReport.msg}");
        this.widget.viewModel.createAddressesReport.status = null;
      } else if (this.widget.viewModel.createAddressesReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("Address created successfully");
        Navigator.of(context).pop();
        this.widget.viewModel.createAddressesReport.status = null;
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.createAddressesReport.status = null;
    });
  }

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
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text(
                Translations.of(context).text("NewAddressScreenTitle"),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: new Text(
                  Translations.of(context).text("NewAddressScreenAddressName"),
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
                hint: Translations.of(context).text("NewAddressScreenAddressName"),
                controller: addressNameController,
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
                  Translations.of(context).text("NewAddressScreenAddressLine"),
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
                hint: Translations.of(context).text("NewAddressScreenAddressLine"),
                controller: addressLineController,
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
                controller: phoneController,
                hint:  Translations.of(context).text("CreateAdsPhoneTitle"),
                borderColor: Color(0xffcbcbcb),
                keyboardType: TextInputType.phone,
                maxLength: 8,
              ),
              SizedBox(
                height: 25,
              ),
              ButtonWidget(
                type: ButtonType.primary,
                title:  Translations.of(context).text("NewAddressScreenAddressAdd"),
                onTap: () {
                  if (selectedState == null) {
                    return showToast("Please select state");
                  }
                  if (selectedCity == null) {
                    return showToast("Please select city");
                  }
                  if (addressNameController.text.isEmpty) {
                    return showToast("Please enter address name");
                  }
                  if (addressLineController.text.isEmpty) {
                    return showToast("Please enter address line");
                  }
                  if (phoneController.text.isEmpty) {
                    return showToast("Please enter phone number");
                  }

                  final AddressModel address = AddressModel(
                    countryId: selectedState!.id,
                    cityId: selectedCity!.id,
                    addressName: addressNameController.text,
                    addressLine1: addressLineController.text,
                    phone: phoneController.text,
                  );
                  widget.viewModel.createAddress(address);
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
