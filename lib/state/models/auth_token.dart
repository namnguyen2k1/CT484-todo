class AuthTokenModel {
  final String _token;
  final String _userId;
  final DateTime _expiryDate;

  AuthTokenModel({
    token,
    userId,
    expiryDate,
  })  : _token = token,
        _userId = userId,
        _expiryDate = expiryDate;

  bool get isValid {
    return token != null;
  }

  String? get token {
    if (_expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  DateTime get expiryDate {
    return _expiryDate;
  }

  Map<String, dynamic> toJson() {
    return {
      'authToken': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String(),
    };
  }

  static AuthTokenModel fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      token: json['authToken'],
      userId: json['userId'],
      expiryDate: DateTime.parse(json['expiryDate']),
    );
  }
}
