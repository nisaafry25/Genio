import 'package:flutter/material.dart';
import 'forgot_password_page.dart'; // Import halaman lupa password

void main() {
  runApp(GenioApp());
}

class GenioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CCTV DATA INSPIRASI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              'Welcome Back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Enter Your Username & Password'),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman lupa password
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),
                  ),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Navigasi ke halaman lupa password
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),
                  ),
                );
              },
              child: Text('Forgot Password?'),
            ),
            SizedBox(height: 8),
            Text('Need help? Visit our help center v1.0.5'),
          ],
        ),
      ),
    );
  }
}
