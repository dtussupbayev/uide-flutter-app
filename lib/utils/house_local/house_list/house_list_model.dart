import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/domain/models/house_entity/house_entity.dart';
import 'package:uide/navigation/main_navigation.dart';

class HouseListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final List<HouseEntity> _houses = [];
  List<HouseEntity> get houses => List.unmodifiable(_houses);

  void setupHouses(BuildContext context) {
    _houses.clear();
    _loadHouses(context);
  }

  Future<void> _loadHouses(BuildContext context) async {
    await _apiClient.allHousesResponse(0, context);
    // if (housesResponse != null) {
    //   _houses.addAll(housesResponse.content ?? []);
    //   notifyListeners();
    // }
  }

  void onHouseTap(BuildContext context, int index) {
    final id = _houses[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.houseDetails,
      arguments: id,
    );
  }
}
