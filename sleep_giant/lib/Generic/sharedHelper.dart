library preference;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleep_giant/API%20Models/signup_response.dart';

final SharedPreferencesHelper preference = SharedPreferencesHelper._private();


class SharedPreferencesHelper {

  SharedPreferencesHelper._private() { print('#2'); }
  ///
  /// Instantiation of the SharedPreferences library
  ///
  final String _kLogin = "loginState";
  final String _kPaymentState = "paymentState";

  /// ------------------------------------------------------------
  /// Method that returns the user login state
  /// ------------------------------------------------------------
  Future<bool> getLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kLogin) ?? false;

  }
  /// ----------------------------------------------------------
  /// Method that saves the user login state
  /// ----------------------------------------------------------
  Future<bool> setLoginState(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_kLogin, value);

  }

  /// ------------------------------------------------------------
  /// Method that returns the user payment state
  /// ------------------------------------------------------------
  Future<bool> getPaymentState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kPaymentState) ?? false;

  }

  /// ----------------------------------------------------------
  /// Method that saves the user payment state
  /// ----------------------------------------------------------
  Future<bool> setPaymentState(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_kPaymentState, value);

  }
  /// ----------------------------------------------------------
  /// Method that saves dynamic values
  /// ----------------------------------------------------------
  sharedPreferencesSet (String key, dynamic value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);

  }
  /// ----------------------------------------------------------
  /// Method that returns the dynamic value
  /// ----------------------------------------------------------
  dynamic sharedPreferencesGet (String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  await prefs.get(key) ?? null;

  }


  saveModel(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  readModel(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }


  Future<UserData> readUserModel(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return UserData.fromJson( json.decode(prefs.getString(key)));
  }
}


