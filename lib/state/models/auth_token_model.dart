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

  bool get isValid => token != null;
  String get userId => _userId;
  DateTime get expiryDate => _expiryDate;

  String? get token {
    if (_expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'authToken': _token,
      'expiryDate': _expiryDate.toIso8601String(),
    };
  }

  static AuthTokenModel fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      userId: json['userId'],
      token: json['authToken'],
      expiryDate: DateTime.parse(json['expiryDate']),
    );
  }
}
