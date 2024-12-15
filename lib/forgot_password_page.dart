import 'package:flutter/material.dart';
import '../auth_db_helper.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _newPasswordController, decoration: InputDecoration(labelText: 'New Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                final newPassword = _newPasswordController.text;

                final success = await AuthDBHelper().resetPassword(email, newPassword);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password reset successfully')));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email not found')));
                }
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
