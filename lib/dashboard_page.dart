import 'package:flutter/material.dart';
import 'package:genio/main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo_genio_remove_bg.png', height: 40), // Tambahkan logo Genio
            SizedBox(width: 8), // Ruang antar logo dan teks
            Text('HOME'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Genio!!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10, // Replace with API data length
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    elevation: 4, // Tambahkan efek bayangan
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding tambahan
                      leading: Icon(Icons.videocam, color: Colors.blue),
                      title: Text(
                        'CCTV Video $index', // Replace with API data
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Details about video $index'), // Replace dengan API data
                      trailing: Icon(Icons.play_arrow, color: Colors.blue),
                      onTap: () {
                        print('Play video $index');
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> allData = List.generate(20, (index) => 'CCTV Video $index'); // Data awal
  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults = allData; // Awalnya, tampilkan semua data
  }

  void updateSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        searchResults = allData;
      } else {
        searchResults = allData
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search CCTV',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                updateSearchResults(value);
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.videocam),
                    title: Text(searchResults[index]),
                    subtitle: Text('Details for ${searchResults[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy user data for demonstration
    final user = {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'company': 'PT. Global Data Inspirasi',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['company']?? 'No company available',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text
                    (
                      user['email'] ?? 'No email available',  // Memberikan nilai default jika null
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('My Account'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAccountPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Face ID / Touch ID'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FaceIDPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Two-Factor Authentication'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TwoFactorPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Support'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpSupportPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About App'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutAppPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,  // Menghapus semua route sebelumnya
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Judul
          Text(
            'My Account',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          SizedBox(height: 20),

          // Profil Pengguna
          Card(
            child: ListTile(
              leading: Icon(Icons.account_circle, color: Colors.teal),
              title: Text('Profil Pengguna'),
              subtitle: Text('Lihat dan edit profil pengguna Anda.'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileDetailsPage()),
                );
              },
            ),
          ),
          SizedBox(height: 10),

          // Ubah Detail Akun
          Card(
            child: ListTile(
              leading: Icon(Icons.edit, color: Colors.teal),
              title: Text('Ubah Detail Akun'),
              subtitle: Text('Ganti informasi seperti nama, email, nomor telepon, dll.'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditDetailsPage()),
                );
              },
            ),
          ),
          SizedBox(height: 10),

          // Pengaturan Keamanan
          Card(
            child: ListTile(
              leading: Icon(Icons.security, color: Colors.teal),
              title: Text('Pengaturan Keamanan'),
              subtitle: Text(
                  'Atur kata sandi'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecuritySettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Halaman Profil Pengguna
class ProfileDetailsPage extends StatefulWidget {
  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  String name = "John Doe";
  String email = "johndoe@example.com";
  String phone = "+628123456789";
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(Icons.account_circle, size: 50, color: Colors.teal)
                    : null,
              ),
            ),
            SizedBox(height: 16),
            Text('Nama: $name', style: TextStyle(fontSize: 18)),
            Text('Email: $email', style: TextStyle(fontSize: 18)),
            Text('Telepon: $phone', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditDetailsPage()),
                );
              },
              child: Text('Edit Profil'),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Ubah Detail Akun
class EditDetailsPage extends StatefulWidget {
  @override
  _EditDetailsPageState createState() => _EditDetailsPageState();
}

class _EditDetailsPageState extends State<EditDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      // Proses penyimpanan data
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah menyimpan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) => value?.isEmpty ?? true ? 'Nama tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value?.isEmpty ?? true ? 'Email tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Telepon'),
                validator: (value) => value?.isEmpty ?? true ? 'Telepon tidak boleh kosong' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman Pengaturan Keamanan
class SecuritySettingsPage extends StatefulWidget {
  @override
  _SecuritySettingsPageState createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    if (_oldPasswordController.text.isNotEmpty && _newPasswordController.text.isNotEmpty) {
      print("Kata sandi baru disimpan");
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah mengganti kata sandi
    } else {
      print("Silakan masukkan kata sandi lama dan kata sandi baru");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Keamanan'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _oldPasswordController,
              decoration: InputDecoration(labelText: 'Kata Sandi Lama'),
              obscureText: true,
            ),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'Kata Sandi Baru'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text('Ganti Kata Sandi'),
            ),
          ],
        ),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyAccountPage(),
  ));
}

class FaceIDPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keamanan Biometrik'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.security, size: 50, color: Colors.teal),
            SizedBox(height: 16),
            Text(
              'Login dengan Face ID',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 8),
            Text(
              'Gunakan fitur keamanan biometrik untuk masuk dengan Face ID.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Simulasi mengaktifkan Face ID
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Face ID diaktifkan!')),
                );
              },
              child: Text('Aktifkan Face ID'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Simulasi menonaktifkan Face ID
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Face ID dinonaktifkan!')),
                );
              },
              child: Text('Nonaktifkan Face ID'),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Text(
              'Panduan Penggunaan Face ID',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 8),
            Text(
              'Informasi lengkap mengenai cara menggunakan fitur Face ID.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

class TwoFactorPage extends StatefulWidget {
  @override
  _TwoFactorPageState createState() => _TwoFactorPageState();
}

class _TwoFactorPageState extends State<TwoFactorPage> {
  bool isChecked = false; // Inisialisasi status checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifikasi Dua Faktor'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lock, size: 50, color: Colors.teal),
            SizedBox(height: 16),
            Text(
              'Aktifkan/Nonaktifkan Two-Factor Authentication',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 8),
            Text(
              'Pilih untuk mengaktifkan atau menonaktifkan fitur verifikasi dua faktor.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                    // Show a message based on the checkbox state
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(isChecked ? 'Two-Factor Authentication diaktifkan!' : 'Two-Factor Authentication dinonaktifkan!')),
                    );
                  },
                ),
                Expanded(
                  child: Text('Aktifkan Two-Factor Authentication'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Text(
              'Panduan Penggunaan Two-Factor Authentication',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 8),
            Text(
              'Informasi lengkap mengenai cara menggunakan fitur Two-Factor Authentication.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              'Troubleshooting & Bantuan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 8),
            Text(
              'Solusi umum dan bantuan jika Anda mengalami masalah dengan Two-Factor Authentication.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dukungan Pengguna'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 5, blurRadius: 10)],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.help_outline, size: 50, color: Colors.teal),
            SizedBox(height: 16),
            Text(
              'FAQ',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 8),
            Text('Jawaban atas pertanyaan yang sering diajukan.', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Text(
              'Kontak Dukungan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 8),
            Text('Hubungi tim dukungan untuk bantuan langsung.', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Text(
              'Laporan Masalah',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 8),
            Text('Kirimkan laporan masalah yang Anda temui.', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About GENIO'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 5, blurRadius: 10)],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 50, color: Colors.teal),
              SizedBox(height: 16),
              Text(
                'Tentang PT Global Data Inspirasi',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 8),
              Text(
                'PT Global Data Inspirasi (DataIns) adalah perusahaan yang berfokus pada solusi Big Data & Applied Artificial Intelligence. GENIO adalah aplikasi CCTV Data Inspirasi yang kami kembangkan untuk memberikan solusi canggih dalam manajemen data keamanan. Aplikasi ini menyediakan berbagai fitur yang membantu pengguna untuk mengelola, mengintegrasikan, dan menganalisis data dari perangkat CCTV dengan mudah dan aman.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              Text(
                'Deskripsi Produk',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 8),
              Text(
                'GENIO hadir dengan solusi siap pakai yang mencakup pengelolaan data CCTV, pengenalan wajah, deteksi kendaraan, serta integrasi data real-time untuk meningkatkan efisiensi dan keamanan.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              Text(
                'Sejarah Perusahaan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 8),
              Text(
                'GENIO dikembangkan oleh PT Global Data Inspirasi untuk memberikan solusi berbasis teknologi tinggi yang membantu organisasi dan individu dalam pengelolaan keamanan yang lebih cerdas dan efisien.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              Text(
                'Kebijakan Privasi dan Syarat & Ketentuan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 8),
              Text(
                'Kami menjaga privasi pengguna dengan aman dan mengikuti standar tinggi dalam melindungi data pribadi Anda. Silakan baca Kebijakan Privasi dan Syarat & Ketentuan kami untuk informasi lebih lanjut.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
