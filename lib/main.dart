import 'package:flutter/material.dart';
import 'package:genio/dashboard_page.dart';
import 'forgot_password_page.dart'; // Import halaman lupa password
import 'analisis_page.dart';


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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      // Simulasi validasi login
      if (username == "user@genio.com" && password == "password123") {
        setState(() {
          _errorMessage = '';
        });
        // Navigasi ke halaman dashboard (tanpa tombol back)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
      } else {
        setState(() {
          _errorMessage =
              'Login failed, please check your credentials and try again';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CCTV DATA INSPIRASI',
          style: TextStyle(
            fontSize: 18, // Ukuran teks diperkecil
            fontWeight: FontWeight.bold, // Teks dibuat bold (opsional)
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text('Enter Your Username & Password'),
              SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
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
      ),
    );
  }
}
