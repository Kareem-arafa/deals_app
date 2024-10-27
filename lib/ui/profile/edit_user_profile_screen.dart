import 'dart:io';

import 'package:dealz/common/animation_utils.dart';
import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/delete_account_bottom_sheet.dart';
import 'package:dealz/common/gallary_or_camera_dialog.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/auth/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthViewModel>(
      distinct: true,
      converter: (store) => AuthViewModel.fromStore(store),
      builder: (_, viewModel) => _EditProfileScreenContent(
        authViewModel: viewModel,
      ),
    );
  }
}

class _EditProfileScreenContent extends StatefulWidget {
  final AuthViewModel authViewModel;

  const _EditProfileScreenContent({super.key, required this.authViewModel});

  @override
  State<_EditProfileScreenContent> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<_EditProfileScreenContent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool follow = false;
  bool location = false;

  File? _image;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.authViewModel.user?.name ?? "";
    _emailController.text = widget.authViewModel.user?.email ?? "";
    _dobController.text = widget.authViewModel.user?.dateOfBirth ?? "";
    _phoneController.text = widget.authViewModel.user?.phone?.replaceAll("965", "") ?? "";

    follow = widget.authViewModel.user?.alertFollow ?? false;
    location = widget.authViewModel.user?.location ?? false;

    this.widget.authViewModel.getMyProfile();
  }

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _EditProfileScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.authViewModel.editProfileActionReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.authViewModel.editProfileActionReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.authViewModel.editProfileActionReport.msg}");
        this.widget.authViewModel.editProfileActionReport.status = null;
      } else if (this.widget.authViewModel.editProfileActionReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.authViewModel.editProfileActionReport.status = null;
        Navigator.pop(context);
        showToast("profile updated successfully");
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.authViewModel.editProfileActionReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
              ),
              Positioned(
                right: 0,
                child: Image.asset(
                  Assets.images.editProfleBg.path,
                  height: 200,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                  child: Icon(Icons.arrow_back),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0) + EdgeInsets.only(top: 80),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: new Container(
                          width: 309,
                          height: 79,
                          decoration: new BoxDecoration(
                            color: Color(0xff126a8e),
                            borderRadius: BorderRadius.circular(39.5),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (widget.authViewModel.user?.followers ?? 0).toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      Translations.of(context).text("profileScreenFollowersLabel"),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 1,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff979797),
                                    width: 1,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (widget.authViewModel.user?.followings ?? 0).toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      Translations.of(context).text("profileScreenFollowingLabel"),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      /*  SizedBox(
                        height: 25,
                      ),
                      new Text(
                        "MY Wallet",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 62,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff979797).withOpacity(0.2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text(
                                    "78",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  new Text(
                                    "Free Credit",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 1,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff979797).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text(
                                    "283",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  new Text(
                                    "Premium",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),*/
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        Translations.of(context).text("signupScreenNameTitle"),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                        type: TextFieldType.text,
                        controller: _nameController,
                        hint: "",
                        borderColor: Color(0xffd4d4d4),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        Translations.of(context).text("CreateAdsPhoneTitle"),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                        type: TextFieldType.phone,
                        controller: _phoneController,
                        hint: "35749220028",
                        borderColor: Color(0xffd4d4d4),
                        enabled: false,
                        /* suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.only(end: 16),
                              child: Text(
                                "Verify",
                                style: TextStyle(
                                  color: Color(0xff07beb8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),*/
                      ),
                      Text(Translations.of(context).text("phoneCan'tChange")),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        Translations.of(context).text("signupScreenEmailTitle"),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                        type: TextFieldType.text,
                        controller: _emailController,
                        hint: "AsmaReda@gmail.com",
                        borderColor: Color(0xffd4d4d4),
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                      /*SizedBox(
                        height: 25,
                      ),
                      new Text(
                        "Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                        type: TextFieldType.text,
                        controller: TextEditingController(),
                        hint: "267493003",
                        borderColor: Color(0xffd4d4d4),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 16),
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  color: Color(0xffff9947),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),*/
                      SizedBox(
                        height: 25,
                      ),
                      new Text(
                        Translations.of(context).text("profileScreenDOBLabel"),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () async {
                          var dateTime = await showDatePicker(
                            locale: Locale(Translations.of(context).currentLanguage),
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900, 1, 1),
                            lastDate: DateTime.now(),
                          );
                          if (dateTime != null) {
                            _dobController.text = DateFormat("yyyy-MM-dd", "en").format(dateTime);
                            setState(() {});
                          }
                        },
                        child: TextFieldWidget(
                          type: TextFieldType.text,
                          controller: _dobController,
                          hint: "8-8-1778",
                          borderColor: Color(0xffd4d4d4),
                          enabled: false,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text(
                            Translations.of(context).text("profileScreenAlertFollowLabel"),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          FlutterSwitch(
                            value: follow,
                            height: 30,
                            width: 60,
                            activeColor: Theme.of(context).primaryColor,
                            showOnOff: false,
                            onToggle: (val) {
                              setState(() {
                                follow = val;
                              });
                            },
                          ),
                        ],
                      ),
                      Divider(
                        color: Color(0xff979797),
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text(
                            Translations.of(context).text("profileScreenLocationLabel"),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          FlutterSwitch(
                            value: location,
                            height: 30,
                            width: 60,
                            activeColor: Theme.of(context).primaryColor,
                            showOnOff: false,
                            onToggle: (val) {
                              setState(() {
                                location = val;
                              });
                            },
                          ),
                        ],
                      ),
                      Divider(
                        color: Color(0xff979797),
                        height: 35,
                      ),
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              isScrollControlled: true,
                              useRootNavigator: true,
                              builder: (context) {
                                return DeleteAccountBottomSheet();
                              });
                        },
                        child: new Text(
                          Translations.of(context).text("profileScreenDeleteLabel"),
                          style: TextStyle(
                            color: Color(0xfff53057),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonWidget(
                        type: ButtonType.primary,
                        title: Translations.of(context).text("profileScreenDoneLabel"),
                        onTap: () {
                          if (_nameController.text.isEmpty) {
                            return showToast("Please enter name");
                          }
                          if (_emailController.text.isEmpty) {
                            return showToast("Please enter email");
                          }
                          /*if (_dobController.text.isEmpty) {
                            return showToast("Please enter date of birth");
                          }*/
                          if (_phoneController.text.isEmpty) {
                            return showToast("Please enter phone number");
                          }
                          final UserModel user = UserModel(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            dateOfBirth: _dobController.text,
                            alertFollow: follow,
                            location: location,
                          );
                          if (_image != null) {
                            user.imageFile = _image;
                          }
                          widget.authViewModel.editProfile(user);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  _image != null
                      ? new Container(
                          width: 130,
                          height: 130,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xfff4f4f4),
                            border: Border.all(color: Colors.white, width: 4),
                            image: DecorationImage(
                              image: FileImage(_image!),
                            ),
                          ),
                        )
                      : new Container(
                          width: 130,
                          height: 130,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xfff4f4f4),
                            border: Border.all(color: Colors.white, width: 4),
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.authViewModel.user?.image ?? "",
                              ),
                            ),
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          HeroDialogRoute(
                            builder: (BuildContext context) => CameraOrGallaryDialog(
                              onSelectImage: (image) {
                                if (image != null) {
                                  setState(() {
                                    _image = image;
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        Assets.images.selectpicIcon.path,
                        height: 50,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
