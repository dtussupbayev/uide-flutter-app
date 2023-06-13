import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/models/house_list_entity_response/house_entity.dart';
import 'package:uide/models/house_list_entity_response/photo.dart';
import 'package:uide/ui/navigation/main_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:uide/utils/connectivity_check_widget.dart';

class AdminModel extends ChangeNotifier {
  bool _isLoading = true;
  final _apiClient = ApiClient();
  final _houses = <HouseEntity>[].toList();
  bool isContentEmpty = false;
  bool result = false;

  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgress = false;
  var isApprovingInProgres = false;

  bool isConnected = true;

  Uint8List? bytesImage;
  bool isLoadingImage = false;
  bool hasError = false;

  ConnectivityResult? connectivityResult;
  GlobalKey<ConnectivityCheckWidgetState> connectivityWidgetKey = GlobalKey();

  List<HouseEntity> get houses => List.unmodifiable(_houses);
  bool get isLoading => _isLoading;

  Future<void> setupHouses(BuildContext context) async {
    _isLoading = true;
    isContentEmpty = false;

    notifyListeners();

    _houses.clear();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityResult = result;
      notifyListeners();
    });

    await Future.delayed(const Duration(milliseconds: 1100));

    await _loadHouses(context);
    _isLoading = false;
    print(_isLoading);
    notifyListeners();
  }

  void reloadConnectivityWidget() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connectivityWidgetKey.currentState?.retryConnectivity();
    });
  }

  Future<void> _loadHouses(BuildContext context) async {
    final adminHouseListResponse = await _apiClient.adminHousesResponse(
      context,
    );

    print('loaded');

    if (adminHouseListResponse != null) {
      _houses.addAll(adminHouseListResponse.content ?? []);
      if (_houses.isEmpty) {
        print('empty');
        isContentEmpty = true;
      } else {
        isContentEmpty = false;
      }

      notifyListeners();
    }
  }

  Future<void> approveAd(String? houseId, BuildContext context) async {
    isApprovingInProgres = true;
    _apiClient.approveAdAdmin(houseId: houseId ?? '', context: context);

    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));
    await setupHouses(context);
    isApprovingInProgres = false;

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

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected = connectivityResult != ConnectivityResult.none;
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
