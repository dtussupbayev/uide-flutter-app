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
  ConnectivityResult? connectivityResult;

  List<HouseEntity> get houses => List.unmodifiable(_houses);
  bool get isLoading => _isLoading;

  void setupHouses(BuildContext context) {
    _isLoading = true;
    notifyListeners();
    _houses.clear();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityResult = result;
      notifyListeners();
    });
    loadHouses(context);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadHouses(BuildContext context) async {
    final savedHouseListResponse =
        await _apiClient.savedHousesResponse(context);
    print(savedHouseListResponse);
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

  void onHouseTap(BuildContext context, int index) async {
    final id = _houses[index].id;
    final result = await Navigator.of(context).pushNamed(
      MainNavigationRouteNames.houseDetails,
      arguments: id,
    );
    if (result != null && result is bool && result) {
      // Reload the parent widget
      setupHouses(context);
      notifyListeners();
    }

    // Reload the parent widget
  }
}
