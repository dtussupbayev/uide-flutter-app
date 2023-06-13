import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/models/house_list_entity_response/house_entity.dart';
import 'package:uide/models/house_list_entity_response/photo.dart';
import 'package:uide/ui/navigation/main_navigation.dart';
import 'package:uide/utils/connectivity_check_widget.dart';
import 'package:http/http.dart' as http;

class SavedHouseListModel extends ChangeNotifier {
  bool _isLoading = true;
  final _apiClient = ApiClient();
  final _houses = <HouseEntity>[].toList();
  bool isContentEmpty = false;
  bool result = false;
  final _savedHouseIds = <String?>{};
  List<HouseEntity> _filteredHouses = <HouseEntity>[];
  List<HouseEntity> get filteredHouses =>
      List.unmodifiable(_filteredHouses.toList());
  bool get isLoading => _isLoading;
  bool isConnected = true;
  Uint8List? bytesImage;
  bool isLoadingImage = false;
  bool hasError = false;
  String _searchString = '';
  bool isFilterMenuOpen = false;
  String get searchString => _searchString;

  ConnectivityResult? connectivityResult;
  GlobalKey<ConnectivityCheckWidgetState> connectivityWidgetKey = GlobalKey();

  List<HouseEntity> get houses => List.unmodifiable(_houses);

  set searchString(String value) {
    _searchString = value;
    notifyListeners();
  }

  Future<void> setupHouses(BuildContext context) async {
    _isLoading = true;
    isContentEmpty = false;

    notifyListeners();

    _houses.clear();
    _filteredHouses.clear();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityResult = result;
      notifyListeners();
    });

    await Future.delayed(const Duration(milliseconds: 1100));

    await loadSavedHouses(context);

    await loadHouses(context);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadHouses(BuildContext context) async {
    final savedHouseListResponse = await _apiClient.savedHousesResponse(
      context,
    );

    if (savedHouseListResponse != null) {
      if (savedHouseListResponse.isEmpty) {
        isContentEmpty = true;
        notifyListeners();
        return;
      }

      _houses.addAll(savedHouseListResponse);

      final filteredHouses = _houses.where((house) =>
          house.description
              .toLowerCase()
              .contains(searchString.toLowerCase()) ||
          house.address.description
              .toLowerCase()
              .contains(searchString.toLowerCase()));

      _filteredHouses = filteredHouses.toList();
      print('filteredHouses: $_filteredHouses');
      if (_filteredHouses.isEmpty) {
        print('empty');
        isContentEmpty = true;
      } else {
        isContentEmpty = false;
      }

      notifyListeners();
    }
  }

  void toggleFilterMenu() {
    isFilterMenuOpen = !isFilterMenuOpen;
    notifyListeners();
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
    print('delete');
    _apiClient.deleteFromSaved(houseId: houseId ?? '', context: context);

    _savedHouseIds.remove(houseId);
    print('removed');
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));
    await setupHouses(context);
    print('es');
    notifyListeners();
  }

  void onHouseTap(BuildContext context, int index) async {
    final id = _houses[index].id;
    const pageIndex = 0;
    final result = await Navigator.of(context).pushNamed(
      MainNavigationRouteNames.houseDetails,
      arguments: {'id': id, 'pageIndex': pageIndex},
    );
    if (result != null && result is bool && result) {
      // Reload the parent widget
      if (context.mounted) setupHouses(context);

      notifyListeners();
    }
  }

  Future<Uint8List> loadImageBytes(List<Photo>? image) async {
    if (image != null && image.isNotEmpty) {
      final imageUrl = image.first.link;
      final response = await http.get(Uri.parse(imageUrl!));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    }

    throw Exception('Failed to load image');
  }

  void reloadConnectivityWidget() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connectivityWidgetKey.currentState?.retryConnectivity();
    });
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
