class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  HttpException.firebase(String code)
      : message = _translateFirebaseErrorCode(code);

  static String _translateFirebaseErrorCode(code) {
    switch (code) {
      case 'EMAIL_EXISTS':
        return 'Địa chỉ email đã được sử dụng';
      case 'INVALID_EMAIL':
        return 'Địa chỉ email không hợp lệ';
      case 'WEAK_PASSWORD':
        return 'Mật khẩu quá yếu';
      case 'EMAIL_NOT_FOUND':
        return 'Không thể tìm tài khoản với email này';
      case 'INVALID_PASSWORD':
        return 'Mật khẩu không khớp';
      default:
        return code;
    }
  }

  @override
  String toString() {
    return message;
  }
}
