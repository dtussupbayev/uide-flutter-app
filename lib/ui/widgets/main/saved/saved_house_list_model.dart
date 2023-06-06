import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/domain/models/house_entity/house_entity.dart';
import 'package:uide/navigation/main_navigation.dart';

class SavedHouseListModel extends ChangeNotifier {
  bool _isLoading = true;
  final _apiClient = ApiClient();
  final _houses = <HouseEntity>[].toList();
  bool isContentEmpty = false;
  List<HouseEntity> get houses => List.unmodifiable(_houses);
  bool get isLoading => _isLoading;

  void setupHouses(BuildContext context) {
    _isLoading = true;
    notifyListeners();
    _houses.clear();
    loadHouses(context);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadHouses(BuildContext context) async {
    final savedHouseListResponse =
        await _apiClient.savedHousesResponse(context);
    if (savedHouseListResponse != null) {
      print(savedHouseListResponse.first.id);
      if (savedHouseListResponse.isEmpty) {
        print('list empty');
        isContentEmpty = true;
        notifyListeners();
        return;
      }
      _houses.addAll(savedHouseListResponse);
      print(_houses);
      notifyListeners();
    }
  }

  void onHouseTap(BuildContext context, int index) {
    final id = _houses[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.houseDetails,
      arguments: id,
    );
  }
}
