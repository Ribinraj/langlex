import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:langlex/core/colors.dart';

Future<XFile> showBottomSheetWidget(BuildContext context) async {
  final completer = Completer<XFile>();
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          //height: MediaQuery.of(context).size.height * 2 / 10,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Appcolors.kbackgroundcolor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Select the image source:',
                style: TextStyle(fontSize: 20, color: Appcolors.ktextColor),
              ),
              const Divider(
                thickness: 2,
                color: Appcolors.kgreenColor,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      XFile imagePath = await fromCamera();
                      completer.complete(imagePath);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.camera,
                      color: Appcolors.kgreenColor,
                    ),
                    label: const Text(
                      'Camera',
                      style: TextStyle(color: Appcolors.ktextColor),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      XFile imagePath = await fromGallery();
                      completer.complete(imagePath);

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.image,
                      color: Appcolors.kgreenColor,
                    ),
                    label: const Text(
                      'Gallery',
                      style: TextStyle(color: Appcolors.ktextColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
  return completer.future;
}

//
Future<XFile> fromCamera() async {
  try {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      throw Exception('No image selected');
    }
    return image;
  } catch (e) {
    throw Exception(e);
  }
}

//
Future<XFile> fromGallery() async {
  try {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      throw Exception('No image selected');
    }
    return image;
  } catch (e) {
    throw Exception(e);
  }
}
