import 'dart:io';
import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stray_dog_app/Application/tools/AppText.dart';

class CameraLocationScreen extends StatefulWidget {
  const CameraLocationScreen({super.key});

  @override
  State<CameraLocationScreen> createState() => _CameraLocationScreenState();
}

class _CameraLocationScreenState extends State<CameraLocationScreen> {
  Uint8List? _image;
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inform Us',
          style: titleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
            height: 30,
            width: 350,
            child: DefaultTextStyle(
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              child: AnimatedTextKit(
                pause: const Duration(milliseconds: 200),
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText('SAVE STRAY DOGS_'),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ),
          AppText(
            txt:
                '"Under Stray Dog Management Rules 2001, its illegal for an individual, RWA or estate management to remove or relocate dogs. The dogs have to be sterilized and vaccinated and returned to the same area". ',
            size: 12,
            color: Colors.black45,
          ),
          gyap(10, 0),
          AppText(
            txt: 'Inform us if you see Stray dogs in your Locality',
            size: 13,
            color: const Color.fromARGB(255, 16, 148, 236),
          ),
          _image != null
              ? Stack(children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: MemoryImage(_image!),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    left: 150,
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        showImagePickerOption(context);
                      },
                    ),
                  ),
                ])
              : Stack(
                  children: [
                    const Expanded(
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage(
                          'assets/images/savedog.jpg',
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -2,
                      left: 150,
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          showImagePickerOption(context);
                        },
                      ),
                    ),
                  ],
                ),
        ]),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: const Color.fromARGB(255, 228, 223, 223),
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.image,
                            color: Colors.redAccent,
                            size: 60,
                          ),
                          AppText(
                            txt: 'Gallery',
                            size: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            color: Colors.blueGrey,
                            size: 60,
                          ),
                          AppText(
                            txt: 'Camera',
                            size: 12,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

//Gallery
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.pop(context); //close the model sheet
  }

//Camera
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.pop(context);
  }
}
