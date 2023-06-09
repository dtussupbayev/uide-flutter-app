import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/domain/models/house_entity/house_entity.dart';
import 'package:uide/navigation/main_navigation.dart';

class AdminScreenModel extends ChangeNotifier {
  final bool _isLoading = true;
  final _apiClient = ApiClient();
  final _houses = <HouseEntity>[];
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgres = false;
  bool isContentEmpty = false;
  List<HouseEntity> get houses => List.unmodifiable(_houses.toList());
  bool get isLoading => _isLoading;

  void setupHouses(BuildContext context) {
    _houses.clear();
    _loadHouses(context);
  }

  Future<void> _loadHouses(BuildContext context) async {
    if (_isLoadingInProgres || _currentPage + 1 >= _totalPage) return;

    _isLoadingInProgres = true;

    final nextPage = _currentPage + 1;

    try {
      final housesResponse =
          await _apiClient.adminHousesResponse(nextPage, context);
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

  void onHouseTap(BuildContext context, int index) {
    final id = _houses[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.houseDetails,
      arguments: id,
    );
  }
}
