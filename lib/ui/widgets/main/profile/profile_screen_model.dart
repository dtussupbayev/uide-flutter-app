import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uide/domain/data_provider/token_data_provider.dart';
import 'package:uide/models/payload/payload.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/models/user_profile_response/user_profile_response.dart';
import 'package:uide/utils/connectivity_check_widget.dart';
import 'package:http/http.dart' as http;

class UserProfileModel extends ChangeNotifier {
  bool? isAdmin = false;

  bool _isLoading = true;
  final _apiClient = ApiClient();
  String? _userAvatarUrl;
  String? get userAvatarUrl => _userAvatarUrl;
  UserProfileResponse? _userProfileResponse;
  UserProfileResponse? get userProfileResponse => _userProfileResponse;

  bool get isLoading => _isLoading;
  bool isConnected = true;
  Uint8List? bytesImage;
  bool isLoadingImage = false;
  bool hasError = false;

  bool isUploading = false;
  // ignore: unused_field
  File? _image;

  ConnectivityResult? connectivityResult;
  GlobalKey<ConnectivityCheckWidgetState> connectivityWidgetKey = GlobalKey();

  Future<void> loadProfile(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityResult = result;
      notifyListeners();
    });

    final token = await TokenDataProvider().getToken();
    final encodedPayload = token!.split('.')[1];
    final payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    final payload = Payload.fromJson(jsonDecode(payloadData));
    if (payload.role == 'ADMIN') {
      isAdmin = true;
    }
    final userProfileResponse = await _apiClient.userProfileResponse(
      context,
    );
    print('userProfileResponse = $userProfileResponse');

    if (userProfileResponse != null) {
      _userProfileResponse = userProfileResponse;
      print(_userProfileResponse!.photo);
      print('not null profile');
      notifyListeners();
    }

    _isLoading = false;

    notifyListeners();
  }

  createImageUrl() async {
    print('image');
    String imageUrl = await chooseAndUploadImage();
    imageUrl =
        imageUrl.length > 2 ? imageUrl.substring(1, imageUrl.length - 1) : '';
    if (imageUrl.length > 2) {
      _userAvatarUrl = imageUrl;
    }
  }

  bool isImageLinkValid(String imageUrl) {
    RegExp urlPattern = RegExp(
        r'^(http(s)?:\/\/)?[^\s]+(\.[^\s]+)+(\/[^\s]+)*\.(jpg|jpeg|png|gif)$',
        caseSensitive: false,
        multiLine: false);
    return urlPattern.hasMatch(imageUrl);
  }

  Future<Uint8List> loadImageBytes(String? imageUrl) async {
    if (imageUrl != null) {
      bool isValid = isImageLinkValid(imageUrl);
      if (isValid) {
        print('$imageUrl: Image link is valid.');
      } else {
        print('$imageUrl Image link is not valid.');
      }
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    }
    print('Failed to load image');
    throw Exception('Failed to load image');
  }

  void reloadConnectivityWidget() {
    print('reloaded');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connectivityWidgetKey.currentState?.retryConnectivity();
    });
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected = connectivityResult != ConnectivityResult.none;
  }

  Future<void> updateImageOfUser() async{
    
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

      isUploading = false;
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
    var file = await http.MultipartFile.fromPath(
      'file',
      imageFile.path,
      contentType: MediaType('image', 'jpeg'),
    );

    request.files.add(file);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();

        return responseBody;
      } else {
        return '';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return '';
    }
  }
}
