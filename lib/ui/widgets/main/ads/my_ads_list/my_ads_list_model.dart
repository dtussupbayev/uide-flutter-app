import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/domain/models/house_entity/house_entity.dart';
import 'package:uide/navigation/main_navigation.dart';

class MyAdsModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _houses = <HouseEntity>[];
  bool isContentEmpty = false;
  List<HouseEntity> get houses => List.unmodifiable(_houses);

  Future<void> loadHouses(BuildContext context) async {
    _houses.clear();

    final housesResponse = await _apiClient.myAdsResponse(context);
    if (housesResponse != null) {
      if (housesResponse.numberOfElements == 0) {
        isContentEmpty = true;
        notifyListeners();
      }
      _houses.addAll(housesResponse.content ?? []);

      notifyListeners();
    }
  }

  void onHouseTap(BuildContext context, int index) {
    final id = _houses[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.myAdsDetails,
      arguments: id,
    );
  }

  void showedHouseAtIndex(int index, BuildContext context) {
    if (index < _houses.length - 2) return;
    loadHouses(context);
  }
}
