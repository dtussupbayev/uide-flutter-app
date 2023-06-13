import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/models/house_details_response/house_details_response.dart';
import 'package:uide/models/house_details_response/photo.dart';
import 'package:uide/ui/navigation/main_navigation.dart';
import 'package:uide/ui/theme/project_colors.dart';

class MyAdsDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  bool isLoading = false;
  final String houseId;
  HouseDetailsResponse? _houseDetails;

  HouseDetailsResponse? get houseDetails => _houseDetails;

  MyAdsDetailsModel(this.houseId);

  Future<void> loadDetails(BuildContext context) async {
    _houseDetails = await _apiClient.houseDetails(houseId, context);
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

  void onDeleteTap(BuildContext context) {
    Get.defaultDialog(
      title: '',
      content: const Text(
        'Вы точно хотите удалить объявление?',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: ProjectColors.kWhite,
          fontSize: 16,
        ),
      ),
      titlePadding: const EdgeInsets.all(0),
      textConfirm: 'Удалить',
      textCancel: 'Отменить',
      cancelTextColor: ProjectColors.kDarkerDarkGreen,
      confirmTextColor: ProjectColors.kWhite,
      buttonColor: ProjectColors.kTransparent,
      backgroundColor: ProjectColors.kDialogBackgroundColor,
      radius: 20,
      onConfirm: () async {
        isLoading = true;
        if (isLoading) {
          showDialog(
            context: context,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            },
          );
        }
        await _apiClient.deleteHouse(houseId, context);
        isLoading = false;
        Get.defaultDialog(
          title: '',
          content: const Text(
            'Обьявление успешно удалено',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: ProjectColors.kWhite,
              fontSize: 16,
            ),
          ),
          titlePadding: const EdgeInsets.all(0),
          textConfirm: 'Ок',
          cancelTextColor: ProjectColors.kDarkerDarkGreen,
          confirmTextColor: ProjectColors.kWhite,
          buttonColor: ProjectColors.kTransparent,
          backgroundColor: ProjectColors.kDialogBackgroundColor,
          radius: 20,
          onConfirm: () async {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(child: CircularProgressIndicator());
              },
            );
            Navigator.of(context).popAndPushNamed(
              MainNavigationRouteNames.myAdsScreen,
            );
          },
        );
      },
    );
  }
}
