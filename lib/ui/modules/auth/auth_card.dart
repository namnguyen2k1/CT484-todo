import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/services/http_exception.dart';
import '../../shared/custom_dialog.dart';
import '../../../state/controllers/auth_controller.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.login;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    _isSubmitting.value = true;
    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        await context.read<AuthController>().login(
              _authData['email']!,
              _authData['password']!,
            );
      } else {
        // Sign user up
        await context.read<AuthController>().signup(
              _authData['email']!,
              _authData['password']!,
            );
      }
    } catch (error) {
      CustomDialog.showAlert(
        context,
        '',
        (error is HttpException)
            ? error.toString()
            : 'Xác thực người dùng thất bại',
      );
    }
    _isSubmitting.value = false;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.signup ? 360 : 280,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.signup ? 320 : 260,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildEmailField(),
                const SizedBox(height: 10),
                _buildPasswordField(),
                if (_authMode == AuthMode.signup) ...[
                  const SizedBox(height: 10),
                  _buildPasswordConfirmField(),
                ],
                const SizedBox(height: 20),
                ValueListenableBuilder<bool>(
                  valueListenable: _isSubmitting,
                  builder: (context, isSubmitting, child) {
                    if (isSubmitting) {
                      return const CircularProgressIndicator();
                    }
                    return _buildSubmitButton();
                  },
                ),
                _buildAuthModeSwitchButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthModeSwitchButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _authMode == AuthMode.login
              ? 'Bạn là người mới? '
              : 'Đã có tài khoản? ',
        ),
        TextButton(
          onPressed: _switchAuthMode,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Text(
            _authMode == AuthMode.login ? 'đăng kí' : 'đăng nhập',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).focusColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Theme.of(context).focusColor,
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
        textStyle: TextStyle(
          color: Theme.of(context).primaryTextTheme.headline6?.color,
        ),
      ),
      child: Text(
        _authMode == AuthMode.login ? 'ĐĂNG NHẬP' : 'ĐĂNG KÍ',
      ),
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      enabled: _authMode == AuthMode.signup,
      decoration: InputDecoration(
        labelText: 'Xác nhận mật khẩu',
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.lock,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordConfirmVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _passwordConfirmVisible = !_passwordConfirmVisible;
            });
          },
        ),
      ),
      obscureText: !_passwordConfirmVisible,
      validator: _authMode == AuthMode.signup
          ? (value) {
              if (value != _passwordController.text) {
                return 'Mật khẩu nhập không khớp!';
              }
              return null;
            }
          : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: 'Mật khẩu',
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.lock_outline,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.length < 5) {
          return 'Mật khẩu phải trên 5 kí tự!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.email,
          ),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Email không họp lệ!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
    );
  }
}
