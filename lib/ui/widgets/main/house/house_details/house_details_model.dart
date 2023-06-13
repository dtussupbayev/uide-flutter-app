import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/models/house_details_response/house_details_response.dart';
import 'package:uide/models/house_details_response/photo.dart';
import 'package:uide/models/house_list_entity_response/house_entity.dart';

class HouseDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final String? houseId;
  HouseDetailsResponse? _houseDetails;
  bool? _isSaved;

  bool? get isSaved => _isSaved;

  HouseDetailsResponse? get houseDetails => _houseDetails;

  HouseDetailsModel(this.houseId);

  Future<void> loadDetails(BuildContext context) async {
    _houseDetails = await _apiClient.houseDetails(
        houseId ?? '2c9180de88ab97520188adf0c53d0013', context);
    if (context.mounted)
      await checkIsSaved(
          houseId ?? '2c9180de88ab97520188adf0c53d0013', context);
    notifyListeners();
  }

  Future<void> checkIsSaved(String houseId, BuildContext context) async {
    List<HouseEntity>? savedHousesList =
        await _apiClient.savedHousesResponse(context);

    if (savedHousesList!.where((element) => element.id == houseId).isNotEmpty) {
      _isSaved = true;
      notifyListeners();
      return;
    } else {
      _isSaved = false;
      notifyListeners();
    }
  }

  Future<void> addToSaved(String houseId, BuildContext context) async {
    _apiClient.addToSaved(houseId: houseId, context: context);

    _isSaved = true;
    notifyListeners();
  }

  Future<void> deleteFromSaved(String houseId, BuildContext context) async {
    _apiClient.deleteFromSaved(
      houseId: houseId,
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
