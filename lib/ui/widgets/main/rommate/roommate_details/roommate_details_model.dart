import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/models/house_details_response/house_details_response.dart';
import 'package:uide/models/house_details_response/photo.dart';
import 'package:uide/models/house_list_entity_response/house_entity.dart';

class RoommateDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final String? roommateId;
  HouseDetailsResponse? _roommateDetails;
  bool? _isSaved;

  bool? get isSaved => _isSaved;

  HouseDetailsResponse? get roommateDetails => _roommateDetails;

  RoommateDetailsModel(this.roommateId);

  Future<void> loadDetails(BuildContext context) async {
    _roommateDetails = await _apiClient.houseDetails(
        roommateId ?? '2c9180de88ab97520188adf0c53d0013', context);
    if (context.mounted)
      await checkIsSaved(
          roommateId ?? '2c9180de88ab97520188adf0c53d0013', context);
    notifyListeners();
  }

  Future<void> checkIsSaved(String roommateId, BuildContext context) async {
    List<HouseEntity>? savedRoommateList =
        await _apiClient.savedHousesResponse(context);

    if (savedRoommateList!
        .where((element) => element.id == roommateId)
        .isNotEmpty) {
      _isSaved = true;
      notifyListeners();
      return;
    } else {
      _isSaved = false;
      notifyListeners();
    }
  }

  Future<void> addToSaved(String roommateId, BuildContext context) async {
    _apiClient.addToSaved(houseId: roommateId, context: context);

    _isSaved = true;
    notifyListeners();
  }

  Future<void> deleteFromSaved(String roommateId, BuildContext context) async {
    _apiClient.deleteFromSaved(
      houseId: roommateId,
      context: context,
    );
    _isSaved = false;

    notifyListeners();
  }

  String loadImageUrl(List<Photo>? image) {
    if (image!.isNotEmpty) {
      if (image.first.link !=
              'https://rent-house.s3.amazonaws.com/1681924531659-1681754004396-Screenshot%202023-04-13%20at%2016.45.21.png' &&
          !image.contains(null) &&
          image.isNotEmpty) {
        if (image.first.link ==
            '"https://rent-house-main.s3.ap-south-1.amazonaws.com/1685484765494-bedroom_1.jpg"') {
          String imageLink = image.first.link as String;
          return imageLink.substring(1, imageLink.length - 1);
        }
        return image.first.link as String;
      } else {
        return 'https://www.pngkey.com/png/detail/233-2332677_ega-png.png';
      }
    } else {
      return 'https://www.pngkey.com/png/detail/233-2332677_ega-png.png';
    }
  }
}
