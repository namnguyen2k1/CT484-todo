import 'package:flutter/material.dart';
import 'package:todoapp/ui/shared/response_message.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  bool _isEditing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              enabled: _isEditing,
              obscureText: false,
              onTap: () {
                setState(() {
                  _isEditing = true;
                });
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: Icon(
                  Icons.person,
                  size: 20,
                ),
                border: OutlineInputBorder(),
                labelText: 'Username',
                labelStyle: TextStyle(
                  // color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              enabled: _isEditing,
              onTap: () {
                setState(() {
                  _isEditing = true;
                });
              },
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  size: 20,
                ),
                border: OutlineInputBorder(),
                labelText: 'Email',
                labelStyle: TextStyle(
                  // color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              enabled: _isEditing,
              onTap: () {
                setState(() {
                  _isEditing = true;
                });
              },
              keyboardType: TextInputType.visiblePassword,
              obscureText: false,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  size: 20,
                ),
                border: OutlineInputBorder(),
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessengerCustom.showSuccessMessage(
                    context, 'Saved Profile!');
              },
              icon: const Icon(Icons.save),
              label: const Text('Save Changed'),
            ),
          ),
        ],
      ),
    );
  }
}
