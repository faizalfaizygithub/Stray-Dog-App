import 'dart:io';
import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stray_dog_app/Application/tools/AppText.dart';

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

  String imageURL = '';
  var loading = false.obs;

  void addReport() {
    final data = {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'incident': _reportController.text,
      'image': imageURL,
      'location': _currentAddress,
      'value': _currentLocation.toString()
    };
    _items.add(data);
  }

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAddress = '';

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

  Uint8List? _image;
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
            _image != null
                ? CircleAvatar(
                    radius: 100,
                    backgroundImage: MemoryImage(_image!),
                  )
                : CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(
                      'assets/images/savedog.jpg',
                    ),
                  ),
            gyap(10, 0),
            OutlinedButton.icon(
              label: AppText(
                txt: 'Add Stray dog photo',
                size: 10,
                color: Colors.black54,
              ),
              onPressed: () {
                showImagePickerOption(context);
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
            Obx(
              () => TextButton.icon(
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
                onPressed: () async {
                  try {
                    loading.value = true;
                    if (imageURL.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please Select and Upload Image'),
                        ),
                      );
                      loading.value = false;
                      return;
                    }

                    addReport();

                    Navigator.of(context).pushReplacementNamed('finalScreen');
                    loading.value = false;
                  } catch (e) {}
                },
              ),
            ),
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
                      onTap: () async {
                        _pickImageFromGallery();
                        Navigator.pop(context);
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
                        String fileName =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        Navigator.pop(context);
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

    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
//Get the reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();

    Reference referenceDirectImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirectImages.child(fileName);

    try {
      await referenceImageToUpload.putFile(File(returnImage.path));

      imageURL = await referenceImageToUpload.getDownloadURL();
    } catch (error) {}
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
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
//Get the reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();

    Reference referenceDirectImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirectImages.child(fileName);

    try {
      await referenceImageToUpload.putFile(File(returnImage.path));

      imageURL = await referenceImageToUpload.getDownloadURL();
    } catch (error) {}
  }
}
