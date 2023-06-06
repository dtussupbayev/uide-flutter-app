import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/domain/models/house_entity/house_entity.dart';
import 'package:uide/domain/models/house_entity/photo.dart';
import 'package:uide/navigation/main_navigation.dart';

class HouseListModel extends ChangeNotifier {
  bool _isLoading = true;
  final _apiClient = ApiClient();
  final _houses = <HouseEntity>[];
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgres = false;
  bool isContentEmpty = false;
  List<HouseEntity> get houses => List.unmodifiable(_houses.toList());
  bool get isLoading => _isLoading;

  void setupHouses(BuildContext context) {
    _isLoading = true;
    notifyListeners();
    _currentPage = -1;
    _totalPage = 1;
    _houses.clear();
    _loadHouses(context);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadHouses(BuildContext context) async {
    if (_isLoadingInProgres || _currentPage + 1 >= _totalPage) return;

    _isLoadingInProgres = true;

    final nextPage = _currentPage + 1;

    try {
      final housesResponse =
          await _apiClient.allHousesResponse(nextPage, context);
      if (housesResponse != null) {
        if (housesResponse.numberOfElements == 0) {
          isContentEmpty = true;
          notifyListeners();
        }
        _houses.addAll(housesResponse.content ?? []);
        _currentPage = housesResponse.pageable!.pageNumber!;
        _totalPage = housesResponse.totalPages!;
        _isLoadingInProgres = false;
        notifyListeners();
      }
    } catch (e) {
      _isLoadingInProgres = false;
    }
  }

  void showedHouseAtIndex(int index, BuildContext context) {
    if (index < _houses.length - 1) return;
    _loadHouses(context);
  }

  void onHouseTap(BuildContext context, int index) {
    final id = _houses.toList()[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.houseDetails,
      arguments: id,
    );
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
