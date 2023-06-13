import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uide/domain/api_client/api_client.dart';
import 'package:uide/models/house_list_entity_response/house_entity.dart';
import 'package:uide/models/house_list_entity_response/photo.dart';
import 'package:uide/ui/navigation/main_navigation.dart';
import 'package:uide/utils/connectivity_check_widget.dart';
import 'package:http/http.dart' as http;

class MyAdsModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _houses = <HouseEntity>[];
  bool isContentEmpty = false;
  List<HouseEntity> get houses => List.unmodifiable(_houses);

  Uint8List? bytesImage;
  bool isLoadingImage = false;
  bool hasError = false;

  ConnectivityResult? connectivityResult;
  GlobalKey<ConnectivityCheckWidgetState> connectivityWidgetKey = GlobalKey();

  Future<void> loadHouses(BuildContext context) async {
    _houses.clear();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityResult = result;
      notifyListeners();
    });
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

  void reloadConnectivityWidget() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connectivityWidgetKey.currentState?.retryConnectivity();
    });
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
}
