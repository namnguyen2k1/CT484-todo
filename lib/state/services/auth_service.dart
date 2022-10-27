import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/http_exception.dart';
import '../models/auth_token_model.dart';
import './local_key.dart';
import './shared_preference_service.dart';

class AuthService {
  late final String? _apiKey;

  AuthService() {
    _apiKey = dotenv.env['FIREBASE_API_KEY'];
  }

  String _buildAuthUrl(String method) {
    return 'https://identitytoolkit.googleapis.com/v1/accounts:$method?key=$_apiKey';
  }

  Future<AuthTokenModel> _authenticate(
    String email,
    String password,
    String method,
  ) async {
    try {
      final url = Uri.parse(_buildAuthUrl(method));
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseJson = json.decode(response.body);
      if (responseJson['error'] != null) {
        throw HttpException.firebase(responseJson['error']['message']);
      }

      final authToken = _fromJson(responseJson);
      _saveAuthToken(authToken);
      saveLocalAccount(email, password);

      return authToken;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<AuthTokenModel> signup(String email, String password) {
    return _authenticate(email, password, 'signUp');
  }

  Future<AuthTokenModel> login(String email, String password) {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> _saveAuthToken(AuthTokenModel authToken) async {
    await SharedPreferencesSerivce().setString(
      LocalSavedKey.authTokenKey,
      json.encode(authToken.toJson()),
    );
  }

  Future<void> deleteLocalAccount(String email) async {
    final savedAccount = await getAllLocalAccounts();

    for (int i = 0; i < savedAccount.length; i++) {
      if (savedAccount[i]['email'] == email) {
        savedAccount.removeAt(i);
      }
    }
    var savedData = <String>[];
    for (var account in savedAccount) {
      savedData.add(json.encode(account));
    }
    await SharedPreferencesSerivce().setStringList(
      LocalSavedKey.localAccountKey,
      savedData,
    );
  }

  Future<void> saveLocalAccount(String email, String password) async {
    final savedAccount = await getAllLocalAccounts();
    for (int i = 0; i < savedAccount.length; i++) {
      if (savedAccount[i]['email'] == email) {
        return;
      }
    }

    savedAccount.add({
      "email": email,
      "password": password,
    });
    var savedData = <String>[];
    for (var account in savedAccount) {
      savedData.add(json.encode(account));
    }
    await SharedPreferencesSerivce().setStringList(
      LocalSavedKey.localAccountKey,
      savedData,
    );
  }

  Future<List<Map<String, dynamic>>> getAllLocalAccounts() async {
    final result = <Map<String, dynamic>>[];
    final bool isExisted = await SharedPreferencesSerivce().isExisted(
      LocalSavedKey.localAccountKey,
    );
    if (!isExisted) {
      return result;
    }
    final savedAccountList = await SharedPreferencesSerivce().getStringList(
          LocalSavedKey.localAccountKey,
        ) ??
        [];
    for (var account in savedAccountList) {
      result.add(
        json.decode(account),
      );
    }
    return result;
  }

  AuthTokenModel _fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      token: json['idToken'],
      userId: json['localId'],
      expiryDate: DateTime.now().add(
        Duration(
          seconds: int.parse(
            json['expiresIn'],
          ),
        ),
      ),
    );
  }

  Future<AuthTokenModel?> loadSavedAuthToken() async {
    final bool isExisted = await SharedPreferencesSerivce().isExisted(
      LocalSavedKey.authTokenKey,
    );

    if (!isExisted) {
      return null;
    }

    final savedToken = await SharedPreferencesSerivce().getString(
      LocalSavedKey.authTokenKey,
    );

    final authToken = AuthTokenModel.fromJson(json.decode(savedToken));
    if (!authToken.isValid) {
      return null;
    }
    return authToken;
  }

  Future<void> clearSavedAuthToken() async {
    await SharedPreferencesSerivce().removeStorage(
      LocalSavedKey.authTokenKey,
    );
  }
}
