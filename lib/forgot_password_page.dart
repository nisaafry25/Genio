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
            // Logo di tengah atas
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                // Navigasi ke halaman verifikasi kode
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerificationCodePage(),
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
}

class VerificationCodePage extends StatelessWidget {
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
            // Logo di tengah atas
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('A code has been sent to your email.'),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Verification Code',
                hintText: 'Enter the code',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman sukses
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccessPage(),
                  ),
                );
              },
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

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genio - Success'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo di tengah atas
            Center(
              child: Image.asset(
                'assets/images/logo_genio_remove_bg.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Thank you.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('You will be redirected to the login page in 5 seconds.'),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Kembali ke halaman login
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Click here if you are not redirected automatically'),
            ),
            SizedBox(height: 16),
            Text('Need help? Visit our help center'),
          ],
        ),
      ),
    );
  }
}
