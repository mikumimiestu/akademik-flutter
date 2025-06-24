import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: colorScheme.primary,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.settings, color: colorScheme.primary),
              onPressed: () {
                // Navigasi ke pengaturan
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Modern Header Profile
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Profile Avatar with modern design
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: isTablet ? 60 : 50,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.network(
                            'https://digiroister.com/wp-content/uploads/2021/02/team-1.jpg',
                            width:
                                isTablet
                                    ? 120
                                    : 100, // Lebar 2x radius untuk mengisi lingkaran
                            height:
                                isTablet
                                    ? 120
                                    : 100, // Tinggi 2x radius untuk mengisi lingkaran
                            fit:
                                BoxFit
                                    .cover, // Untuk memastikan gambar mengisi lingkaran dengan proporsi yang benar
                            errorBuilder:
                                (context, error, stackTrace) => Icon(
                                  Icons
                                      .person, // Fallback icon jika gambar gagal dimuat
                                  size: isTablet ? 70 : 60,
                                  color: colorScheme.primary,
                                ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: isTablet ? 26 : 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'NIM: 23101152631001',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Profile Information with responsive layout
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:
                  isTablet
                      ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildAcademicInfo()),
                          SizedBox(width: 16),
                          Expanded(child: _buildPersonalInfo()),
                        ],
                      )
                      : Column(
                        children: [
                          _buildAcademicInfo(),
                          SizedBox(height: 16),
                          _buildPersonalInfo(),
                        ],
                      ),
            ),

            SizedBox(height: 20),

            // Modern Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildModernButton(
                          icon: Icons.edit_rounded,
                          label: 'Edit Profile',
                          isPrimary: true,
                          onPressed: () {
                            // Edit profile action
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildModernButton(
                          icon: Icons.logout_rounded,
                          label: 'Logout',
                          isPrimary: false,
                          onPressed: () {
                            _showLogoutDialog(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcademicInfo() {
    return ModernProfileInfoCard(
      title: 'Informasi Akademik',
      icon: Icons.school_rounded,
      items: [
        ProfileItem(
          icon: Icons.menu_book_rounded,
          label: 'Program Studi',
          value: 'Teknik Informatika',
        ),
        ProfileItem(
          icon: Icons.calendar_today_rounded,
          label: 'Semester',
          value: '4 (Empat)',
        ),
        ProfileItem(icon: Icons.grade_rounded, label: 'IPK', value: '3.64'),
        ProfileItem(
          icon: Icons.assignment_turned_in_rounded,
          label: 'SKS Tempuh',
          value: '120 SKS',
        ),
      ],
    );
  }

  Widget _buildPersonalInfo() {
    return ModernProfileInfoCard(
      title: 'Informasi Pribadi',
      icon: Icons.person_rounded,
      items: [
        ProfileItem(
          icon: Icons.email_rounded,
          label: 'Email',
          value: 'john@student.ac.id',
        ),
        ProfileItem(
          icon: Icons.phone_rounded,
          label: 'No. Telepon',
          value: '+62 1234-5678',
        ),
        ProfileItem(
          icon: Icons.location_on_rounded,
          label: 'Alamat',
          value: 'Jl. Ambatukan 193, Padang, Papua Nugini',
        ),
        ProfileItem(
          icon: Icons.cake_rounded,
          label: 'Tanggal Lahir',
          value: '31-12-2090',
        ),
      ],
    );
  }

  Widget _buildModernButton({
    required IconData icon,
    required String label,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient:
            isPrimary
                ? LinearGradient(
                  colors: [Colors.blueGrey.shade400, Colors.blueGrey.shade600],
                )
                : null,
        color: isPrimary ? null : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isPrimary ? null : Border.all(color: Colors.red.shade300),
        boxShadow: [
          BoxShadow(
            color:
                isPrimary
                    ? Colors.blueGrey.withOpacity(0.3)
                    : Colors.red.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isPrimary ? Colors.white : Colors.red.shade600,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: isPrimary ? Colors.white : Colors.red.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.logout_rounded, color: Colors.red.shade600),
              SizedBox(width: 12),
              Text(
                'Konfirmasi Logout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            'Apakah Anda yakin ingin logout?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey.shade600,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Implement logout logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

class ModernProfileInfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<ProfileItem> items;

  ModernProfileInfoCard({
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.blueGrey.shade600, size: 24),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Container(
                margin: EdgeInsets.only(
                  bottom: index == items.length - 1 ? 0 : 12,
                ),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        item.icon,
                        color: Colors.blueGrey.shade400,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Text(
                        item.label,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        item.value,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class ProfileItem {
  final IconData icon;
  final String label;
  final String value;

  ProfileItem({required this.icon, required this.label, required this.value});
}
