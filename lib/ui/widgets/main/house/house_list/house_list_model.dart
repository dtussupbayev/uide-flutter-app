import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/models/filters_response/filters_response.dart';
import 'package:uide/models/house_list_entity_response/house_entity.dart';
import 'package:uide/models/house_list_entity_response/photo.dart';
import 'package:uide/ui/navigation/main_navigation.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class HouseListModel extends ChangeNotifier {
  bool _isLoading = true;
  final _apiClient = ApiClient();
  final _houses = <HouseEntity>[];
  final _savedHouses = <HouseEntity>[];
  List<HouseEntity> _filteredHouses = <HouseEntity>[];
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgres = false;
  bool isContentEmpty = false;
  final _savedHouseIds = <String?>{};
  List<HouseEntity> get houses => List.unmodifiable(_houses.toList());
  List<HouseEntity> get savedHouses => List.unmodifiable(_savedHouses.toList());
  List<HouseEntity> get filteredHouses =>
      List.unmodifiable(_filteredHouses.toList());
  bool get isLoading => _isLoading;
  bool isConnected = true;
  Uint8List? bytesImage;
  bool isLoadingImage = false;
  bool hasError = false;
  String _searchString = '';
  bool isFilterMenuOpen = false;
  RangeValues initialPriceRangeValues = const RangeValues(0.0, 0.0);
  RangeValues priceRangeValues = const RangeValues(0.0, 0.0);
  RangeValues initialResidencesRangeValues = const RangeValues(0.0, 0.0);
  RangeValues residencesRangeValues = const RangeValues(0.0, 0.0);
  String get searchString => _searchString;

  set searchString(String value) {
    _searchString = value;
    notifyListeners();
  }

  void setupHouses(BuildContext context) async {
    _isLoading = true;
    isContentEmpty = false;

    notifyListeners();
    _currentPage = -1;
    _totalPage = 1;
    _houses.clear();
    _filteredHouses.clear();
    _savedHouseIds.clear();
    checkConnectivity();

    await fetchFilters(context);
    print('fetched filters');
    await loadSavedHouses(context);
    await _loadHouses(context);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> setupHousesWithFilters(BuildContext context) async {
    _isLoading = true;
    isContentEmpty = false;

    notifyListeners();
    _currentPage = -1;
    _totalPage = 1;
    _houses.clear();
    _filteredHouses.clear();
    _savedHouseIds.clear();
    checkConnectivity();
    await Future.delayed(const Duration(milliseconds: 800));

    if (context.mounted) {
      await loadSavedHouses(context);
      if (context.mounted) await _loadHouses(context);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadHouses(BuildContext context) async {
    if (_isLoadingInProgres || _currentPage + 1 >= _totalPage) return;

    _isLoadingInProgres = true;

    final nextPage = _currentPage + 1;

    try {
      final housesResponse = await _apiClient.allHousesResponse(
        nextPage,
        context,
        minPrice: priceRangeValues.start.toInt(),
        maxPrice: priceRangeValues.end.toInt(),
        minValueOfResidence: residencesRangeValues.start.toInt(),
        maxValueOfResidence: residencesRangeValues.end.toInt(),
      );
      if (housesResponse != null) {
        _houses.addAll(housesResponse.content ?? []);

        _currentPage = housesResponse.pageable!.pageNumber!;
        _totalPage = housesResponse.totalPages!;
        final filteredHouses = _houses.where((house) =>
            house.description
                .toLowerCase()
                .contains(searchString.toLowerCase()) ||
            house.address.description
                .toLowerCase()
                .contains(searchString.toLowerCase()));

        _filteredHouses = filteredHouses.toList();
        if (_filteredHouses.isEmpty) {
          print('empty');
          isContentEmpty = true;
        } else {
          isContentEmpty = false;
        }
        _isLoadingInProgres = false;

        notifyListeners();
      }
    } catch (e) {
      _isLoadingInProgres = false;
    }
  }

  Future<void> fetchFilters(BuildContext context) async {
    final response = await _apiClient.getFiltersResponse(context);
    print('getfiltersResponse : $response');
    setFilterValues(response);
  }

  void setFilterValues(FiltersResponse? filters) async {
    initialPriceRangeValues = RangeValues(
      filters?.priceMinValue?.toDouble() ?? 0,
      filters?.priceMaxValue!.toDouble() ?? 0,
    );
    priceRangeValues = RangeValues(
      filters?.priceMinValue?.toDouble() ?? 0,
      filters?.priceMaxValue!.toDouble() ?? 0,
    );

    initialResidencesRangeValues = RangeValues(
      filters?.minNumberOfResidence?.toDouble() ?? 0,
      filters?.maxNumberOfResidence!.toDouble() ?? 0,
    );

    residencesRangeValues = RangeValues(
      filters?.minNumberOfResidence?.toDouble() ?? 0,
      filters?.maxNumberOfResidence!.toDouble() ?? 0,
    );
  }

  void setPriceRangeValues(RangeValues values) {
    priceRangeValues = values;
    notifyListeners();
  }

  void setResidentsRangeValues(RangeValues values) {
    residencesRangeValues = values;
    notifyListeners();
  }

  void applyFilters(BuildContext context) {
    // Close the filter menu
    toggleFilterMenu();

    // Trigger house setup with filters applied
    setupHouses(context);
  }

  void toggleFilterMenu() {
    isFilterMenuOpen = !isFilterMenuOpen;
    notifyListeners();
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
    _apiClient.addToSaved(houseId: houseId ?? '', context: context);

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
      arguments: {'id': id, 'pageIndex': 1},
    );
    if (result != null && result is bool && result) {
      if (context.mounted) setupHouses(context);
      notifyListeners();
    }
  }

  bool isImageLinkValid(String imageUrl) {
    RegExp urlPattern = RegExp(
        r'^(http(s)?:\/\/)?[^\s]+(\.[^\s]+)+(\/[^\s]+)*\.(jpg|jpeg|png|gif)$',
        caseSensitive: false,
        multiLine: false);
    return urlPattern.hasMatch(imageUrl);
  }

  Future<Uint8List> loadImageBytes(List<Photo>? image) async {
    if (image != null && image.isNotEmpty) {
      final imageUrl = image.first.link;
      bool isValid = imageUrl != null ? isImageLinkValid(imageUrl) : false;
      if (isValid) {
        print('$imageUrl: Image link is valid.');
      } else {
        print('$imageUrl Image link is not valid.');
      }
      final response = await http.get(Uri.parse(imageUrl!));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    }

    throw Exception('Failed to load image');
  }

  void showedHouseAtIndex(int index, BuildContext context) {
    if (index < _filteredHouses.length - 1) return;
    _loadHouses(context);
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected = connectivityResult != ConnectivityResult.none;
  }
}
