import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Tambahkan package ini di pubspec.yaml
import 'dart:io';

// Halaman untuk mengedit profil pengguna.
class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk setiap field dalam formulir.
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _dobController; // DOB = Date of Birth

  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data profil yang ada (data tiruan).
    _nameController = TextEditingController(text: 'John Doe');
    _emailController = TextEditingController(text: 'john@student.ac.id');
    _phoneController = TextEditingController(text: '+62 1234-5678');
    _addressController = TextEditingController(
      text: 'Jl. Ambatukan 193, Padang, Papua Nugini',
    );
    _dobController = TextEditingController(text: '31-12-2090');
  }

  @override
  void dispose() {
    // Pastikan untuk membuang controller saat widget tidak lagi digunakan.
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  // Fungsi untuk membuka galeri dan memilih gambar.
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Fungsi untuk menampilkan dialog pemilih tanggal.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Tanggal awal yang ditampilkan
      firstDate: DateTime(1950), // Batas tanggal paling awal
      lastDate: DateTime(2101), // Batas tanggal paling akhir
    );
    if (picked != null) {
      setState(() {
        // Format tanggal dan perbarui controller.
        _dobController.text =
            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      });
    }
  }

  // Fungsi untuk menyimpan perubahan profil.
  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Jika formulir valid, lakukan proses penyimpanan.
      // Di sini Anda akan menambahkan logika untuk mengirim data ke backend/database.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profil berhasil disimpan!'),
          backgroundColor: Colors.green,
        ),
      );
      // Kembali ke halaman sebelumnya setelah menyimpan.
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('Edit Profil'),
        backgroundColor: Colors.white,
        foregroundColor: colorScheme.primary,
        elevation: 1,
        actions: [
          // Tombol untuk menyimpan perubahan.
          IconButton(
            icon: Icon(Icons.save_as_rounded, color: colorScheme.primary),
            onPressed: _saveProfile,
            tooltip: 'Simpan',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Widget untuk mengedit gambar profil.
              _buildProfileImageEditor(),
              SizedBox(height: 32),

              // Bagian Informasi Pribadi
              _buildSectionTitle('Informasi Pribadi'),
              SizedBox(height: 16),
              _buildTextFormField(
                controller: _nameController,
                label: 'Nama Lengkap',
                icon: Icons.person_outline_rounded,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null ||
                      !value.contains('@') ||
                      !value.contains('.')) {
                    return 'Masukkan format email yang valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                controller: _phoneController,
                label: 'No. Telepon',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                controller: _addressController,
                label: 'Alamat',
                icon: Icons.location_on_outlined,
                maxLines: 3,
              ),
              SizedBox(height: 16),
              _buildDateField(),
              SizedBox(height: 32),

              // Bagian Informasi Akademik (Read-Only)
              _buildSectionTitle('Informasi Akademik'),
              SizedBox(height: 16),
              _buildReadOnlyField(
                'NIM',
                '23101152631001',
                Icons.badge_outlined,
              ),
              SizedBox(height: 16),
              _buildReadOnlyField(
                'Program Studi',
                'Teknik Informatika',
                Icons.menu_book_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget untuk membangun editor gambar profil.
  Widget _buildProfileImageEditor() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade200,
            backgroundImage:
                _image != null
                    ? FileImage(_image!)
                    : NetworkImage(
                          'https://digiroister.com/wp-content/uploads/2021/02/team-1.jpg',
                        )
                        as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: _pickImage,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(Icons.edit, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget untuk membangun judul setiap bagian.
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade800,
      ),
    );
  }

  // Helper widget untuk membangun field input teks.
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }

  // Helper widget untuk membangun field input tanggal.
  Widget _buildDateField() {
    return TextFormField(
      controller: _dobController,
      readOnly: true, // Membuat field ini tidak bisa diketik manual.
      onTap:
          () => _selectDate(context), // Menampilkan date picker saat diketuk.
      decoration: InputDecoration(
        labelText: 'Tanggal Lahir',
        prefixIcon: Icon(Icons.cake_outlined, color: Colors.grey.shade600),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  // Helper widget untuk membangun field read-only.
  Widget _buildReadOnlyField(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 22),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
