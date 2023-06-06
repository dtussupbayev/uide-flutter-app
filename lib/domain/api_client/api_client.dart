import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uide/domain/data_provider/token_data_provider.dart';
import 'package:uide/domain/models/house_details_response/house_details_response.dart';
import 'package:uide/domain/models/house_entity/all_movie_response.dart';
import 'package:uide/domain/models/user_profile/user_profile.dart';
import 'package:uide/navigation/main_navigation.dart';
import 'package:uide/ui/widgets/app/main.dart';
import 'package:uide/ui/widgets/auth/auth_data.dart';

import '../api_endpoints.dart';
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

    var headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(
      Uri.parse(ApiEndPoints.baseUrl + path),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
      final result = parser(json);
      return result;
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
  }

  Future<AllHousesResponse?> adminHousesResponse(
      int page, BuildContext context) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = AllHousesResponse.fromJson(jsonMap);
      return response;
    }

    final result =
        await _get('admin/houses?size=2&page=$page', parser, context);
    return result;
  }

  Future<AllHousesResponse?> allHousesResponse(
      int page, BuildContext context) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = AllHousesResponse.fromJson(jsonMap);
      return response;
    }

    final result = await _get(
        'houses?cityId=${ApiParameters.cityIdAlmaty}&size=2&page=$page',
        parser,
        context);
    return result;
  }

  Future<UserProfile?> userProfileResponse(BuildContext context) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = UserProfile.fromJson(jsonMap);
      return response;
    }

    final result = await _get('users/profile', parser, context);
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

  Future<http.Response> _post(
    String path,
    Map<String, dynamic> body, [
    Map<String, String>? headers,
  ]) async {
    final url = Uri.parse(ApiEndPoints.baseUrl + path);

    final response = await http.post(
      url,
      body: jsonEncode(body),
      headers: headers,
    );

    return response;
  }

  Future<http.Response> auth({
    required String email,
    required String password,
  }) async {
    const path = AuthEndPoints.signIn;
    final Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };
    final headers = {'Content-Type': 'application/json'};

    http.Response response = await _post(path, body, headers);

    return response;
  }

  Future<http.Response> register({
    required UserAuthData userAuthData,
    required String password,
  }) async {
    const path = AuthEndPoints.signUp;
    final Map<String, dynamic> body = {
      'email': userAuthData.email,
      'username': userAuthData.username,
      'gender': userAuthData.sex,
      'phoneNumber': userAuthData.phone,
      'password': password,
    };

    final headers = {'Content-Type': 'application/json'};

    http.Response response = await _post(path, body, headers);

    return response;
  }

  Future<http.Response> sendOtp({
    required Map<String, dynamic> body,
  }) async {
    const path = AuthEndPoints.sendOtp;
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    http.Response response = await _post(path, body, headers);

    return response;
  }

  Future<http.Response> checkOtp({
    required Map<String, dynamic> body,
  }) async {
    const path =  AuthEndPoints.checkOtp;
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    http.Response response = await _post(path, body, headers);

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
  }) async {
    final token = TokenDataProvider().getToken();
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
    http.Response response = await _post(
      path,
      body,
      headers,
    );

    if (response.statusCode == 200) {
      final responseBody = response.body;
      Map<String, dynamic> jsonData = json.decode(responseBody);
      String id = jsonData['id'];
      print(id);
      print(jsonData);
      return id;
    } else {
      print(response.reasonPhrase);
      return '0';
    }
  }

  Future<String> markAsSaved({
    required int houseId,
  }) async {
    final token = TokenDataProvider().getToken();
    const path = HouseEndPoints.savedHouses;

    final Map<String, dynamic> body ={
      'houseId': houseId,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Response response = await _post(
      path,
      body,
      headers,
    );

    if (response.statusCode == 200) {
      final responseBody = response.body;
      Map<String, dynamic> jsonData = json.decode(responseBody);
      String id = jsonData['id'];
      print(id);
      print(jsonData);
      return id;
    } else {
      print(response.reasonPhrase);
      return '0';
    }
  }

  Future<http.Response?> _delete<T>(
    String path,
    BuildContext context,
  ) async {
    final token = await TokenDataProvider().getToken();

    var headers = {'Authorization': 'Bearer $token'};
    final response = await http.delete(
      Uri.parse(ApiEndPoints.baseUrl + path),
      headers: headers,
    );
    print(response.body);
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
  }

  Future<http.Response?> deleteHouse(
      String houseId, BuildContext context) async {
    final http.Response? result = await _delete('houses/$houseId', context);
    return result;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((value) {
      final result = value.join();
      return result;
    }).then<dynamic>((v) => json.decode(v));
  }
}
