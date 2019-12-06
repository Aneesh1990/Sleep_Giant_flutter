import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sleep_giant/API%20Models/all_programs_list_response.dart';
import 'package:sleep_giant/API%20Models/notification_response_model.dart';
import 'package:sleep_giant/API%20Models/profile_update.dart';
import 'package:sleep_giant/API%20Models/signin_request.dart';
import 'package:sleep_giant/API%20Models/signup_request.dart';
import 'package:sleep_giant/API%20Models/signup_response.dart';
import 'package:sleep_giant/API%20Models/sleep_deck_create_response.dart';
import 'package:sleep_giant/API%20Models/sleep_deck_save_model.dart';
import 'package:sleep_giant/Generic/sharedHelper.dart';

class ApiBaseHelper {
  final String _stagging = "http://hdeck.ignite-yourself.com/api/";
  //final String _stagging = "http://sleepgiant.cubettech.in/api/";

  // <editor-fold desc=" Network - API Call ">

  Future<SignUpResponse> userSignUp(SignUpRequest request) async {
    final response = await http.post('$_stagging' + 'register',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
//          HttpHeaders.authorizationHeader: ''
        },
        body: json.encode(request));
    SignUpResponse signUpResponse =
        SignUpResponse.fromJson(json.decode(response.body));
    return signUpResponse;
  }

  Future<dynamic> userProfileUpdate(ProfileUpdate request) async {
    final response = await http.post('$_stagging' + 'profile/update',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
//          HttpHeaders.authorizationHeader: ''
        },
        body: json.encode(request));

    return response;
  }

  Future<SignUpResponse> userSignIn(SignInRequest request) async {
    final response = await http.post('$_stagging' + 'login',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
//          HttpHeaders.authorizationHeader: ''
        },
        body: json.encode(request));
    SignUpResponse signUpResponse =
        SignUpResponse.fromJson(json.decode(response.body));
    return signUpResponse;
  }

  Future<AllProgramsResponse> getAllPrograms() async {
    var token =
        'Bearer ' + await preference.sharedPreferencesGet('token') ?? "";
    print(token);

    final response = await http.get(
      '$_stagging' + 'programs',
      headers: {
        // HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: token,
      },
    );

    AllProgramsResponse allProgramsResponse =
        AllProgramsResponse.fromJson(json.decode(response.body));
    return allProgramsResponse;
  }

  Future<SleepDeckResponse> saveSleepDeck(SleepDeckSaveModel request) async {
    var token =
        'Bearer ' + await preference.sharedPreferencesGet('token') ?? "";
    print(token);

    final response = await http.post('$_stagging' + 'sleep-decks',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token,
        },
        body: json.encode(request));

    SleepDeckResponse sleepDecks =
        SleepDeckResponse.fromJson(json.decode(response.body));

    return sleepDecks;
  }

  Future<http.Response> deleteSleepDeck(int songId) async {
    var token =
        'Bearer ' + await preference.sharedPreferencesGet('token') ?? "";
    print(token);

    final response = await http.post(
      '$_stagging' + 'sleep-decks/$songId/delete',
      headers: {
        // HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: token,
      },
    );

    print(response.toString());

    return response;
  }

  Future<http.Response> resetPassword(SignInRequest email) async {
    final response = await http.post('$_stagging' + 'password/email',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          // HttpHeaders.authorizationHeader: token,
        },
        body: json.encode(email));

    print(response.toString());

    return response;
  }

  Future<ProgramtypeData> getSong(String id) async {
    var token =
        'Bearer ' + await preference.sharedPreferencesGet('token') ?? "";
    print(token);
    final response = await http.get(
      '$_stagging' + 'programs/$id',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: token
      },
    );

    print(response.body);

    ProgramtypeData programTypeData =
        ProgramtypeData.fromJson(json.decode(response.body));
    return programTypeData;
  }

  Future<NotificationResponse> getNotification() async {
    var token =
        'Bearer ' + await preference.sharedPreferencesGet('token') ?? "";
    print(token);
    final response = await http.get(
      '$_stagging' + 'notifications',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: token
      },
    );
    print(response.body);
    NotificationResponse notificationResponse =
        NotificationResponse.fromJson(json.decode(response.body));

    return notificationResponse;
  }

  Future<dynamic> downloadFile(String url) async {
    print("Download start");
    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();

    try {
      await dio.download(url, "${dir.path}/$url",
          onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
      });
    } catch (e) {
      print(e);
    }
    print("Download completed");

    return "${dir.path}/$url";
  }

// </editor-fold>
}
