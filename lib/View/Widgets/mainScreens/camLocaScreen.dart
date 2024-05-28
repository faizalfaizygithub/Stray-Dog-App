import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stray_dog_app/View/tools/AppText.dart';

class CameraLocationScreen extends StatefulWidget {
  const CameraLocationScreen({super.key});

  @override
  State<CameraLocationScreen> createState() => _CameraLocationScreenState();
}

class _CameraLocationScreenState extends State<CameraLocationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _reportController = TextEditingController();
  final CollectionReference _items =
      FirebaseFirestore.instance.collection('report');
  void addReport(String downloadURL) {
    final data = {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'incident': _reportController.text,
      'imageURL': downloadURL,
      'location': _currentAddress,
      'value': _currentLocation.toString()
    };
    _items.add(data);
  }

  PlatformFile? pickedFile;
  String downloadURL = '';

  var loading = false.obs;

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAddress = '';

  Future<void> uploadFile() async {
    try {
      if (pickedFile != null) {
        if (kIsWeb) {
          // For web, use the Uint8List directly
          final Uint8List fileBytes = pickedFile!.bytes!;
          final ref =
              FirebaseStorage.instance.ref().child('files/${pickedFile!.name}');

          await ref.putData(fileBytes);

          String downloadURL = await ref.getDownloadURL();
          addReport(downloadURL);
        } else {
          // For other platforms, use the file path
          final path = 'files/${pickedFile!.name}';
          final file = File(pickedFile!.path!);
          final ref = FirebaseStorage.instance.ref().child(path);

          await ref.putFile(file);

          String downloadURL = await ref.getDownloadURL();
          addReport(downloadURL);
        }
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print('service disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.locality},${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report Us',
          style: appBartitleStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey.shade100,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
            _animatedHeadingSec(),
            gyap(10, 0),
            AppText(
                txt: 'Inform us if you see Stray dogs in your Locality',
                size: 13,
                color: const Color.fromARGB(255, 10, 93, 104)),
            gyap(10, 0),
            const SizedBox(height: 20.0),
            pickedFile == null
                ? Image.asset('assets/images/savedog.jpg',
                    height: 300.0, width: 300)
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: kIsWeb
                        ? Image.memory(
                            Uint8List.fromList(pickedFile!.bytes!),
                            fit: BoxFit.fill,
                            width: 200,
                            height: 400,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              height: 400,
                              child: Card(
                                shadowColor: Colors.grey,
                                elevation: 14,
                                child: Image.file(
                                  File(pickedFile!.path!),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ),
            gyap(10, 0),
            OutlinedButton.icon(
              label: AppText(
                txt: 'Add Stray dog photo',
                size: 10,
                color: Colors.black54,
              ),
              onPressed: () async {
                if (kIsWeb) {
                  // For web, use FilePicker to select files
                  await selectFile();
                } else {
                  // For other platforms, show the image picker
                  showImagePicker(context);
                }
              },
              icon: const Icon(
                Icons.add_a_photo,
                color: Colors.blue,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () async {
                _currentLocation = await _getCurrentLocation();
                await _getAddressFromCoordinates();
                print("${_currentLocation}");
                print("${_currentAddress}");
              },
              icon: const Icon(
                Icons.location_pin,
                color: Colors.red,
              ),
              label: AppText(
                  txt: 'Get Current Location', size: 10, color: Colors.black54),
            ),
            gyap(20, 0),
            AppText(
              txt: 'Location Address',
              fw: FontWeight.bold,
            ),
            AppText(
              txt: "${_currentAddress}",
              size: 12,
            ),
            AppText(
              txt: 'Location Coordinates',
              fw: FontWeight.bold,
            ),
            AppText(
              txt:
                  "Latitude =${_currentLocation?.latitude}; Longitude=${_currentLocation?.longitude}",
              size: 10,
            ),
            gyap(10, 0),
            _customTextField(
              'Name',
              1,
              _nameController,
            ),
            gyap(10, 0),
            _customTextField(
              'Phone',
              1,
              _phoneController,
            ),
            gyap(10, 0),
            _customTextField(
              'Report',
              4,
              _reportController,
            ),
            gyap(10, 0),
            Obx(() => TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  fixedSize: MaterialStateProperty.all(
                    Size(300, 50),
                  ),
                ),
                label: loading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Submit',
                        style: buttonStyle,
                      ),
                icon: const Icon(Icons.document_scanner, color: Colors.white),
                onPressed: () {
                  addReport(downloadURL);
                  Navigator.of(context).pushReplacementNamed('finalScreen');
                  loading.value = false;
                })),
            gyap(5, 0),
          ]),
        ),
      ),
    );
  }

  _animatedHeadingSec() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 50,
      width: 250,
      child: DefaultTextStyle(
        style: const TextStyle(
            fontSize: 20.0, color: Colors.black54, fontWeight: FontWeight.bold),
        child: AnimatedTextKit(
          pause: const Duration(milliseconds: 200),
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText('SAVE STRAY DOGS_'),
          ],
        ),
      ),
    );
  }

  final picker = ImagePicker();
  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    child: const Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 50.0,
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          "Gallery",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        )
                      ],
                    ),
                    onTap: () {
                      selectFile();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 50.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Camera",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> selectFile() async {
    try {
      if (kIsWeb) {
        final result = await FilePicker.platform.pickFiles();
        if (result == null) return;

        setState(() {
          pickedFile = result.files.first;
        });
      } else {
        final result = await FilePicker.platform.pickFiles();
        if (result == null) return;

        setState(() {
          pickedFile = result.files.first;
        });
      }
    } catch (e) {
      print('Error selecting file: $e');
    }
  }

  _customTextField(
    String textName,
    int count,
    final dynamic controller,
  ) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        label: AppText(
          txt: textName,
          size: 12,
        ),
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade200,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLines: count,
    );
  }

//Camera

  _imgFromCamera() async {
    try {
      final image =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      if (image != null) {
        final length = await File(image.path!)
            .length(); // Await the result of the function call
        setState(() {
          pickedFile = PlatformFile(
            name: 'image.jpg',
            size: length,
            path: image.path,
          );
        });
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }
}
