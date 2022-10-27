import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/auth_token_model.dart';

abstract class FirebaseService {
  String? _token;
  String? _userId;
  late final String? databaseUrl;

  FirebaseService([AuthTokenModel? authToken])
      : _token = authToken?.token,
        _userId = authToken?.userId {
    databaseUrl = dotenv.env['FIREBASE_URL'];
  }

  set authToken(AuthTokenModel? authToken) {
    _token = authToken?.token;
    _userId = authToken?.userId;
  }

  @protected
  String? get token => _token;

  @protected
  String? get userId => _userId;
}
