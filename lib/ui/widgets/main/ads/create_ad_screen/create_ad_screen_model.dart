import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/navigation/main_navigation.dart';
import 'package:uide/ui/theme/project_colors.dart';

class CreateAdScreenModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final formKey = GlobalKey<FormState>();

  TextEditingController typeOfHouseController = TextEditingController();
  TextEditingController addressCityIdController = TextEditingController();
  TextEditingController addressDescriptionController = TextEditingController();
  TextEditingController addressPostalCodeController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController numberOfRoomsController = TextEditingController();
  TextEditingController numberOfResidentsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> photos = [];
  String city = '';

  bool isUploading = false;
  int selectedRoomIndex = 0;
  bool isCustomSelected = false;

  // ignore: unused_field
  File? _image;

  createImageUrl() async {
    String imageUrl = await chooseAndUploadImage();
    imageUrl =
        imageUrl.length > 2 ? imageUrl.substring(1, imageUrl.length - 1) : '';
    print(imageUrl);
    if (imageUrl.length > 2) {
      photos.add(imageUrl);
    }
  }

  Future<void> createAd(BuildContext context) async {
    notifyListeners();

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: ProjectColors.kLightGreen,
          ));
        });

    if (addressCityIdController.text == 'Алматы') {
      city = '2c918118885dfac501885e0b1a110005';
    } else if (addressCityIdController.text == 'Астана') {
      city = '2c918118885dfac501885dfcfdf80001';
    }
    final id = await _apiClient.createAd(
      typeOfHouse: typeOfHouseController.text,
      addressCityId: city,
      addressDescription: addressDescriptionController.text,
      addressName: '',
      addressPostalCode: addressPostalCodeController.text,
      area: int.parse(areaController.text),
      description: descriptionController.text,
      floor: int.parse(floorController.text),
      numberOfResidents: int.parse(numberOfResidentsController.text),
      numberOfRooms: int.parse(numberOfRoomsController.text),
      photos: photos,
      price: double.parse(priceController.text),
    );

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Объявление создано!'),
          content:
              const Text('Хотите перейти на страницу созданной объявлении?'),
          actions: [
            TextButton(
              child: const Text('Нет'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Перейти'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(
                  MainNavigationRouteNames.houseDetails,
                  arguments: id,
                );
              },
            ),
          ],
        ),
      );
    }
    notifyListeners();

    // Navigator.of(context).pushNamed(MainNavigationRouteNames.myAdsScreen);
  }

  Future<String> chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      _image = imageFile;
      isUploading = true;
      notifyListeners();
      final uploadedImageUrl = await _uploadImage(imageFile);

      isUploading = false; // Reset the flag after the upload is finished
      notifyListeners();
      return uploadedImageUrl;
    }
    return '';
  }

  Future<String> _uploadImage(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://rent-house-production-82fe.up.railway.app/aws'),
    );
    print(imageFile.path);
    // Replace the file path with the actual path of the image you want to upload
    var file = await http.MultipartFile.fromPath(
      'file',
      imageFile.path,
      contentType: MediaType(
          'image', 'jpeg'), // Adjust the content type based on your image file
    );

    request.files.add(file);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();

        print('Image uploaded successfully. Response: $responseBody');
        return responseBody;
      } else {
        print('Image upload failed with status code ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }
}
