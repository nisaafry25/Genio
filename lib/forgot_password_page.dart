import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genio - Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_genio_remove_bg.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text('Please enter your email'),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Simulasi pengiriman email dengan kode verifikasi
                String email = 'user@genio.com'; // Ganti dengan input pengguna
                String verificationCode = _generateVerificationCode();

                // Navigasi ke halaman verifikasi kode
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerificationCodePage(
                      email: email,
                      verificationCode: verificationCode,
                    ),
                  ),
                );
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Kembali ke halaman login
                Navigator.pop(context);
              },
              child: Text('Back to Login'),
            ),
            SizedBox(height: 16),
            Text('Need help? Visit our help center'),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menghasilkan kode verifikasi (simulasi)
  String _generateVerificationCode() {
    return '123456'; // Kode verifikasi statis (bisa diganti dengan logika yang lebih kompleks)
  }
}

class VerificationCodePage extends StatefulWidget {
  final String email;
  final String verificationCode;

  VerificationCodePage({required this.email, required this.verificationCode});

  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final _codeController = TextEditingController();
  String _errorMessage = '';

  void _verifyCode() {
    String enteredCode = _codeController.text;

    if (enteredCode == widget.verificationCode) {
      // Navigasi ke halaman ubah password
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangePasswordPage(email: widget.email),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid verification code. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genio - Verification Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_genio_remove_bg.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Enter Verification Code',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text('A code has been sent to ${widget.email}.'),
            SizedBox(height: 16),
            TextFormField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Verification Code',
                hintText: 'Enter the code',
              ),
            ),
            SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _verifyCode,
              child: Text('Verify'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Kembali ke halaman lupa password
                Navigator.pop(context);
              },
              child: Text('Resend Code (05)'),
            ),
            SizedBox(height: 16),
            Text('Need help? Visit our help center'),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  final String email;

  ChangePasswordPage({required this.email});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _errorMessage = '';

  void _changePassword() {
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields.';
      });
    } else if (newPassword != confirmPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match.';
      });
    } else {
      // Simulasi perubahan password
      print('Password changed for ${widget.email} to: $newPassword');

      // Kembali ke halaman login
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genio - Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_genio_remove_bg.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Change Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                hintText: 'Enter your new password',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm your new password',
              ),
            ),
            SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text('Change Password'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Kembali ke halaman login
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
