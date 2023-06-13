import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uide/domain/api_endpoints.dart';
import 'package:uide/domain/data_provider/token_data_provider.dart';
import 'package:uide/models/filters_response/filters_response.dart';
import 'package:uide/models/house_details_response/house_details_response.dart';
import 'package:uide/models/house_list_entity_response/all_house_response.dart';
import 'package:uide/models/house_list_entity_response/house_entity.dart';
import 'package:uide/models/payload/payload.dart';
import 'package:uide/models/user_profile_response/user_profile_response.dart';
import 'package:uide/ui/navigation/main_navigation.dart';
import 'package:uide/ui/widgets/app/main.dart';
import 'package:uide/ui/widgets/auth/auth_data.dart';
import 'package:http/http.dart' as http;

enum ApiClientExceptionType { network, auth, other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  Future<T?> _get<T>(
    String path,
    T Function(dynamic json) parser,
    BuildContext context,
  ) async {
    final token = await TokenDataProvider().getToken();
    final encodedPayload = token!.split('.')[1];
    final payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print(payloadData);
    final payload = Payload.fromJson(jsonDecode(payloadData));
    print(payload.role);
    var headers = {'Authorization': 'Bearer $token'};
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoints.baseUrl + path),
        headers: headers,
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        if (kDebugMode) {
          print('json: $json');
        }

        final result = parser(json);
        print('parsed result: $result');
        return result;
      } else if (response.statusCode == 500) {
        print(response.statusCode);
        print(response.body);
        return null;
      } else if (response.statusCode == 401) {
        TokenDataProvider().deleteAll();
        if (context.mounted) {
          RestartWidget.restartApp(context);
          Navigator.of(context).pushNamedAndRemoveUntil(
              MainNavigationRouteNames.authScreen, (route) => false);
        }
        return null;
      } else {
        print(response.statusCode);
        print(response.body);
        return null;
      }
    } catch (e) {
      if (context.mounted) {
        (
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Connection Error'),
              content: const Text('The connection was aborted.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    return null;
  }

  Future<AllHousesResponse?> adminHousesResponse(BuildContext context) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = AllHousesResponse.fromJson(jsonMap);
      return response;
    }

    final result = await _get('admin/houses?', parser, context);
    return result;
  }

  Future<List<HouseEntity>?> savedHousesResponse(BuildContext context) async {
    final token = await TokenDataProvider().getToken();
    const path = HouseEndPoints.savedHouses;
    final headers = {'Authorization': 'Bearer $token'};

    try {
      var response = await http.get(
        Uri.parse(ApiEndPoints.baseUrl + path),
        headers: headers,
      );
      if (response.statusCode == 200) {
        Iterable l = json.decode(utf8.decode(response.bodyBytes));
        List<HouseEntity> savedHouses = List<HouseEntity>.from(
            l.map((model) => HouseEntity.fromJson(model)));
        return savedHouses;
      } else if (response.statusCode == 401) {
        TokenDataProvider().deleteAll();
        if (context.mounted) {
          RestartWidget.restartApp(context);
          Navigator.of(context).pushNamedAndRemoveUntil(
              MainNavigationRouteNames.authScreen, (route) => false);
        }
        return null;
      } else {
        TokenDataProvider().deleteAll();

        if (context.mounted) {
          RestartWidget.restartApp(context);

          Navigator.of(context).pushNamedAndRemoveUntil(
              MainNavigationRouteNames.authScreen, (route) => false);
        }
        return null;
      }
    } catch (e) {
      if (context.mounted) {
        (
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Connection Error'),
              content: const Text('The connection was aborted.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    return null;
  }

  Future<AllHousesResponse?> allHousesResponse(
    int page,
    BuildContext context, {
    int? minPrice,
    int? maxPrice,
    int? maxValueOfResidence,
    int? minValueOfResidence,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = AllHousesResponse.fromJson(jsonMap);
      return response;
    }

    final screenWidth = MediaQuery.of(context).size.width;

    int determineCrossAxisCount() {
      if (screenWidth > 1000) {
        return 4;
      } else if (screenWidth > 502) {
        return 2;
      } else {
        return 1;
      }
    }

    if (minPrice != null &&
        maxPrice != null &&
        minValueOfResidence != null &&
        maxValueOfResidence != null) {
      final result = await _get(
          'houses?cityId=${ApiParameters.cityIdAstana}&size=${determineCrossAxisCount()}&page=$page&maxPrice=$maxPrice&minPrice=$minPrice&maxValueOfResidence=$maxValueOfResidence&minValueOfResidence=$minValueOfResidence',
          parser,
          context);
      return result;
    }
    final result = await _get(
        'houses?cityId=${ApiParameters.cityIdAstana}&size=${determineCrossAxisCount()}&page=$page',
        parser,
        context);
    return result;
  }

  Future<UserProfileResponse?> userProfileResponse(BuildContext context) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = UserProfileResponse.fromJson(jsonMap);
      print('response.email = ${response.email}');
      return response;
    }

    final result = await _get('users/profile', parser, context);
    return result;
  }

  Future<FiltersResponse?> getFiltersResponse(BuildContext context) async {
    pars(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = FiltersResponse.fromJson(jsonMap);
      print('parsed: $response');
      return response;
    }

    final result = await _get(
        'houses/filters?cityId=${ApiParameters.cityIdAstana}', pars, context);
    print('getFiltersResponse result: $result');
    return result;
  }

  Future<AllHousesResponse?> myAdsResponse(BuildContext context) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = AllHousesResponse.fromJson(jsonMap);
      return response;
    }

    final result = await _get('houses/my-adds', parser, context);
    return result;
  }

  Future<HouseDetailsResponse?> houseDetails(
    String houseId,
    BuildContext context,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = HouseDetailsResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get('houses/$houseId', parser, context);

    return result;
  }

  Future<http.Response?> _post(
    String path,
    BuildContext context,
    Map<String, dynamic> body, [
    Map<String, String>? headers,
  ]) async {
    final url = Uri.parse(ApiEndPoints.baseUrl + path);

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );
      return response;
    } catch (e) {
      (
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Connection Error'),
            content: const Text('The connection was aborted.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    return null;
  }

  Future<http.Response?> _put(
    String path,
    BuildContext context, [
    Map<String, String>? headers,
  ]) async {
    final url = Uri.parse(ApiEndPoints.baseUrl + path);

    try {
      final response = await http.put(
        url,
        headers: headers,
      );
      return response;
    } catch (e) {
      (
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Connection Error'),
            content: const Text('The connection was aborted.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    return null;
  }

  Future<http.Response?> auth({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    const path = AuthEndPoints.signIn;
    final Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };
    final headers = {'Content-Type': 'application/json'};

    http.Response? response = await _post(path, context, body, headers);

    return response;
  }

  Future<http.Response?> register({
    required UserAuthData userAuthData,
    required String password,
    required BuildContext context,
  }) async {
    const path = AuthEndPoints.signUp;
    final Map<String, dynamic> body = {
      'email': userAuthData.email,
      'username': userAuthData.username,
      'gender': userAuthData.sex,
      'phoneNumber': userAuthData.phone,
      'cityId': userAuthData.cityId,
      'password': password,
    };

    final headers = {'Content-Type': 'application/json'};

    http.Response? response = await _post(path, context, body, headers);

    return response;
  }

  Future<http.Response?> sendOtp({
    required Map<String, dynamic> body,
    required BuildContext context,
  }) async {
    const path = AuthEndPoints.sendOtp;
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    http.Response? response = await _post(path, context, body, headers);

    return response;
  }

  Future<http.Response?> checkOtp({
    required Map<String, dynamic> body,
    required BuildContext context,
  }) async {
    const path = AuthEndPoints.checkOtp;
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    http.Response? response = await _post(path, context, body, headers);

    return response;
  }

  Future<String> createAd({
    required String typeOfHouse,
    required String description,
    required List<String> photos,
    required double price,
    required String addressPostalCode,
    required String addressDescription,
    required String addressName,
    required String addressCityId,
    required int numberOfResidents,
    required int area,
    required int numberOfRooms,
    required int floor,
    required BuildContext context,
  }) async {
    final token = await TokenDataProvider().getToken();
    const path = HouseEndPoints.createHouse;
    final Map<String, dynamic> body = {
      'typeOfHouse': typeOfHouse,
      'description': description,
      'photos': photos,
      'price': price,
      'address': {
        'postalCode': addressPostalCode,
        'description': addressDescription,
        'name': addressName,
        'cityId': addressCityId
      },
      'numberOfResidents': numberOfResidents,
      'area': area,
      'numberOfRooms': numberOfRooms,
      'floor': floor
    };
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    if (context.mounted) {
      http.Response? response = await _post(
        path,
        context,
        body,
        headers,
      );

      if (response?.statusCode == 200) {
        final responseBody = response?.body;
        Map<String, dynamic> jsonData = json.decode(responseBody!);
        String id = jsonData['id'];
        return id;
      } else {
        return '0';
      }
    }
    return '0';
  }

  Future<http.Response?> addToSaved({
    required String houseId,
    required BuildContext context,
  }) async {
    final token = await TokenDataProvider().getToken();

    const path = HouseEndPoints.savedHouses;

    final Map<String, dynamic> body = {
      'houseId': houseId,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    if (context.mounted) {
      http.Response? response = await _post(
        path,
        context,
        body,
        headers,
      );
      return response;
    }
    return null;
  }

  Future<http.Response?> approveAdAdmin({
    required String houseId,
    required BuildContext context,
  }) async {
    final token = await TokenDataProvider().getToken();

    final path = 'admin/houses/$houseId/status';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    if (context.mounted) {
      http.Response? response = await _put(
        path,
        context,
        headers,
      );
      return response;
    }
    return null;
  }

  Future<http.Response?> _delete<T>(
    String path,
    BuildContext context,
  ) async {
    final token = await TokenDataProvider().getToken();

    var headers = {'Authorization': 'Bearer $token'};
    try {
      final response = await http.delete(
        Uri.parse(ApiEndPoints.baseUrl + path),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        TokenDataProvider().deleteAll();
        if (context.mounted) {
          RestartWidget.restartApp(context);
          Navigator.of(context).pushNamedAndRemoveUntil(
              MainNavigationRouteNames.authScreen, (route) => false);
        }
        return response;
      } else {
        return response;
      }
    } catch (e) {
      if (context.mounted) {
        (
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Connection Error'),
              content: const Text('The connection was aborted.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    return null;
  }

  Future<http.Response?> deleteHouse(
      String houseId, BuildContext context) async {
    final http.Response? result = await _delete('houses/$houseId', context);
    return result;
  }

  Future<http.Response?> deleteFromSaved({
    required String houseId,
    required BuildContext context,
  }) async {
    final http.Response? result =
        await _delete('houses/saved/$houseId', context);
    return result;
  }
}
