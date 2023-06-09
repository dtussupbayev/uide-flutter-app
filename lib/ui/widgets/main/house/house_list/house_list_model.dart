import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/domain/models/house_entity/house_entity.dart';
import 'package:uide/domain/models/house_entity/photo.dart';
import 'package:uide/navigation/main_navigation.dart';

class HouseListModel extends ChangeNotifier {
  bool _isLoading = true;
  final _apiClient = ApiClient();
  final _houses = <HouseEntity>[];
  final _savedHouses = <HouseEntity>[];
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgres = false;
  bool isContentEmpty = false;
  final _savedHouseIds = <String?>{};
  List<HouseEntity> get houses => List.unmodifiable(_houses.toList());
  List<HouseEntity> get savedHouses => List.unmodifiable(_savedHouses.toList());
  bool get isLoading => _isLoading;
  bool isConnected = true;

  void setupHouses(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    _currentPage = -1;
    _totalPage = 1;
    _houses.clear();
    _savedHouseIds.clear();
    checkConnectivity();
    await Future.delayed(const Duration(milliseconds: 800));

    if (context.mounted) {
      loadSavedHouses(context);
      _loadHouses(context);
    }

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

  Future<void> loadSavedHouses(BuildContext context) async {
    final savedHouseListResponse =
        await _apiClient.savedHousesResponse(context);
    if (savedHouseListResponse != null) {
      for (var house in savedHouseListResponse) {
        _savedHouseIds.add(house.id);
      }
      notifyListeners();
    }
  }

  bool checkIsSaved(String? houseId, BuildContext context) {
    if (_savedHouseIds.where((element) => element == houseId).isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addToSaved(String? houseId, BuildContext context) async {
    _apiClient.addToSaved(houseId: houseId ?? '');

    _savedHouseIds.add(houseId);
    notifyListeners();
  }

  Future<void> deleteFromSaved(String? houseId, BuildContext context) async {
    _apiClient.deleteFromSaved(houseId: houseId ?? '', context: context);

    _savedHouseIds.remove(houseId);
    notifyListeners();
  }

  void onHouseTap(BuildContext context, int index) async {
    final id = _houses.toList()[index].id;
    final result = await Navigator.of(context).pushNamed(
      MainNavigationRouteNames.houseDetails,
      arguments: id,
    );
    if (result != null && result is bool && result) {
      if(context.mounted) setupHouses(context);
      notifyListeners();
    }
  }

  void showedHouseAtIndex(int index, BuildContext context) {
    if (index < _houses.length - 1) return;
    _loadHouses(context);
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected = connectivityResult != ConnectivityResult.none;
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
