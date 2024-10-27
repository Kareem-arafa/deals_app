import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraOrGallaryDialog extends StatefulWidget {
  final Function(File?) onSelectImage;

  CameraOrGallaryDialog({
    Key? key,
    required this.onSelectImage,
  }) : super(key: key);

  @override
  _CameraOrGallaryDialogContentState createState() => _CameraOrGallaryDialogContentState();
}

class _CameraOrGallaryDialogContentState extends State<CameraOrGallaryDialog> {
  final double padding = 16.0;
  final double avatarRadius = 50.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    showContent() {
      return <Widget>[
        Text(
          "Choose image from gallery or camera",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () async {
                  var image = await (ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  ));
                  if (image != null) {
                    // final compressedImage = await compressAndGetFile(File(image.path));
                    this.widget.onSelectImage(File(image.path));
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  "Gallery",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () async {
                  var image = await (ImagePicker().pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  ));
                  if (image != null) {
                    this.widget.onSelectImage(File(image.path));
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  "Camera",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        )
      ];
    }

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: avatarRadius + padding,
            bottom: padding,
            left: padding,
            right: padding,
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: showContent(),
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: Hero(
            tag: "addPhotoTag",
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: avatarRadius,
              child: Icon(
                // isCompleted ? Icons.check :
                Icons.camera_alt,
                size: avatarRadius,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
