import 'dart:io';

import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomUploadPictures extends StatefulWidget {
  final String? title;
  final bool? isNotRequired;
  final Function(File) onImageSelected;
  final Function(int) onImageRemoved;
  final bool? isMultiImage;

  CustomUploadPictures({
    super.key,
    this.title,
    this.isNotRequired,
    required this.onImageSelected,
    required this.onImageRemoved,
    this.isMultiImage = true,
  });

  @override
  State<CustomUploadPictures> createState() => _CustomUploadPicturesState();
}

class _CustomUploadPicturesState extends State<CustomUploadPictures> {
  List<XFile> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: RichText(
                text: new TextSpan(
                  children: [
                    new TextSpan(
                      text: widget.title,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Almarai',
                      ),
                    ),
                    if (!(widget.isNotRequired ?? false))
                      new TextSpan(
                        text: Translations.of(context).text("CreateAdsRequiredTitle"),
                        style: TextStyle(
                          color: Color(0xffed437c),
                          fontSize: 10,
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (widget.isMultiImage!) {
                  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (file != null) {
                    int sizeInByte = await file.length();
                    int sizeInKB = sizeInByte ~/ 1024;
                    print(sizeInKB);
                    if (sizeInKB > 2048) {
                      showToast("حجم الصورة يجب ان يكون اقل من ٢ ميجابيت");
                      return;
                    }
                    widget.onImageSelected(File(file.path));
                    setState(() {
                      selectedImages.add(file);
                    });
                  }
                } else {
                  if (selectedImages.isEmpty) {
                    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (file != null) widget.onImageSelected(File(file.path));
                    setState(() {
                      selectedImages.add(file!);
                    });
                  } else {
                    return;
                  }
                }
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        selectedImages.isEmpty
            ? GestureDetector(
                onTap: () async {
                  if (widget.isMultiImage!) {
                    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (file != null) {
                      int sizeInByte = await file.length();
                      int sizeInKB = sizeInByte ~/ 1024;
                      print(sizeInKB);
                      if (sizeInKB > 2048) {
                        showToast("حجم الصورة يجب ان يكون اقل من ٢ ميجابيت");
                        return;
                      }
                      widget.onImageSelected(File(file.path));
                      setState(() {
                        selectedImages.add(file);
                      });
                    }
                  } else {
                    if (selectedImages.isEmpty) {
                      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (file != null) {
                        int sizeInByte = await file.length();
                        int sizeInKB = sizeInByte ~/ 1024;
                        print(sizeInKB);
                        if (sizeInKB > 2048) {
                          showToast("حجم الصورة يجب ان يكون اقل من ٢ ميجابيت");
                          return;
                        }
                        widget.onImageSelected(File(file.path));
                        setState(() {
                          selectedImages.add(file);
                        });
                      }
                    } else {
                      return;
                    }
                  }
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  color: Color(0xffd7d7d7),
                  radius: Radius.circular(20),
                  dashPattern: [15, 15],
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Container(
                            width: 42,
                            height: 42,
                            decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                Assets.images.add.path,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          new Text(
                            Translations.of(context).text("CreateAdsUploadPicturesTitle"),
                            style: TextStyle(
                              color: Color(0xff110c23),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : DottedBorder(
                borderType: BorderType.RRect,
                color: Color(0xffd7d7d7),
                radius: Radius.circular(20),
                dashPattern: [15, 15],
                child: Container(
                  height: 140,
                  child: ListView.separated(
                    itemCount: selectedImages.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            height: 140,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: ClipRRect(
                              child: Image.file(
                                File(selectedImages[index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              widget.onImageRemoved(index);
                              setState(() {
                                selectedImages.remove(selectedImages[index]);
                              });
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
