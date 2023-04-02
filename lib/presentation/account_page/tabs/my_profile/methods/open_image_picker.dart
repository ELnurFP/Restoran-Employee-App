import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:template/language/localization.dart';

Container openImagePicker(
  bool isMain,
  ValueNotifier<File?> backImage,
  ValueNotifier<File?> image,
  AppLocalizations t,
) {
  ValueNotifier<XFile> imageFile = ValueNotifier(XFile(''));
  final ImagePicker picker = ImagePicker();
  void takePhoto(ImageSource source) async {

    String directory = (await getApplicationDocumentsDirectory()).path;

    // ignore: deprecated_member_use
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
        XFile file = XFile(pickedFile.path);
        String fileType = pickedFile.path.split('/').last.split('.').last;
        String savePath = "$directory/${isMain?'image':'backImage'}.$fileType";
        await file.saveTo(savePath);
      if (isMain) {

        image.value = File(savePath);
      } else {
        backImage.value = File(savePath);
      }
    }
    imageFile.value = pickedFile!;
  }

  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    height: 150.h,
    // width: 375.w,
    child: Column(
      children: [
        Text(t.translate("chooseAOption")),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                ),
                Text(t.translate("camera")),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                ),
                Text(t.translate("gallery")),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
