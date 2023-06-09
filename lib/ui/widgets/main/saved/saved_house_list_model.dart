import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/domain/models/house_entity/house_entity.dart';
import 'package:uide/navigation/main_navigation.dart';

class SavedHouseListModel extends ChangeNotifier {
  bool _isLoading = true;
  final _apiClient = ApiClient();
  final _houses = <HouseEntity>[].toList();
  bool isContentEmpty = false;
  bool result = false;
  final _savedHouseIds = <String?>{};

  ConnectivityResult? connectivityResult;

  List<HouseEntity> get houses => List.unmodifiable(_houses);
  bool get isLoading => _isLoading;

  void setupHouses(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _houses.clear();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityResult = result;
      notifyListeners();
    });
    await Future.delayed(const Duration(milliseconds: 1100));

    if (context.mounted) {
      loadHouses(context);
      loadSavedHouses(context);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadHouses(BuildContext context) async {
    final savedHouseListResponse =
        await _apiClient.savedHousesResponse(context);
    if (savedHouseListResponse != null) {
      if (savedHouseListResponse.isEmpty) {
        isContentEmpty = true;
        notifyListeners();
        return;
      }
      _houses.addAll(savedHouseListResponse);
      notifyListeners();
    }
  }

  Future<void> loadSavedHouses(BuildContext context) async {
    final savedHouseListResponse =
        await _apiClient.savedHousesResponse(context);
    if (savedHouseListResponse != null) {
      _savedHouseIds.clear();
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

  Future<void> deleteFromSaved(String? houseId, BuildContext context) async {
    _apiClient.deleteFromSaved(houseId: houseId ?? '', context: context);

    _savedHouseIds.remove(houseId);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 100));
    if (context.mounted) setupHouses(context);
  }

  void onHouseTap(BuildContext context, int index) async {
    final id = _houses[index].id;
    final result = await Navigator.of(context).pushNamed(
      MainNavigationRouteNames.houseDetails,
      arguments: id,
    );
    if (result != null && result is bool && result) {
      // Reload the parent widget
      if (context.mounted) setupHouses(context);

      notifyListeners();
    }

    // Reload the parent widget
  }
}
