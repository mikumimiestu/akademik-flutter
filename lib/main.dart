import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/jadwal_page.dart';
import 'pages/nilai_page.dart';
import 'pages/profile_page.dart';
import 'pages/chat_page.dart'; // Pastikan import ini aktif untuk ke halaman chat yang benar

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Akademik',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor:
            Colors.grey.shade50, // Latar belakang sedikit abu-abu
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade600,
          brightness: Brightness.light,
        ),
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    JadwalPage(),
    NilaiPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // --- PERUBAHAN UTAMA: MENGGUNAKAN STACK ---
    return Scaffold(
      // Properti bottomNavigationBar dihapus dan dipindahkan ke dalam Stack
      body: Stack(
        children: [
          // 1. Konten Halaman (tetap di lapisan bawah)
          _pages[_currentIndex],

          // 2. Navigasi Melayang (ditempatkan di atas konten)
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: _buildFloatingNavBar(),
          ),
        ],
      ),
    );
  }

  // --- WIDGET BARU UNTUK MEMBUAT NAVIGASI MELAYANG ---
  Widget _buildFloatingNavBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, 'Home', 0),
          _buildNavItem(Icons.schedule_rounded, 'Jadwal', 1),
          _buildNavItem(Icons.bar_chart_rounded, 'Nilai', 2),
          _buildNavItem(Icons.person_rounded, 'Profile', 3),
        ],
      ),
    );
  }

  // --- WIDGET BARU UNTUK SETIAP ITEM NAVIGASI ---
  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        HapticFeedback.lightImpact();
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue.shade700 : Colors.grey.shade600,
              size: 24,
            ),
            // Menampilkan label hanya jika item terpilih
            if (isSelected) ...[
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ... Sisa kode (HomePage, Post, PostWidget) tetap sama seperti sebelumnya ...
class HomePage extends StatelessWidget {
  final List<Post> posts = [
    Post(
      username: 'admin_kampus',
      userAvatar: 'https://www.astbyte.com/icon.png',
      imageUrl:
          'https://assets.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/2022/06/26/3019852258.jpeg',
      caption:
          'Selamat datang di semester baru! Jangan lupa untuk mengecek jadwal kuliah kalian. 📚✨',
      likes: 245,
      timeAgo: '2j',
      isVerified: true,
    ),
    Post(
      username: 'admin_kampus',
      userAvatar: 'https://www.astbyte.com/icon.png',
      imageUrl:
          'https://assets.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/2022/06/26/3019852258.jpeg',
      caption:
          'Selamat datang di semester baru! Jangan lupa untuk mengecek jadwal kuliah kalian. 📚✨',
      likes: 245,
      timeAgo: '2j',
      isVerified: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Welcome Header
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.blue.shade800],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat Datang! 👋',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Halo, John Doe!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatListPage(),
                              ), // Panggil ChatListPage
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons
                                  .forum_rounded, // Ikon baru yang lebih modern
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return PostWidget(post: posts[index]);
              }, childCount: posts.length),
            ),
            SliverToBoxAdapter(
              // Padding tambahan di bawah agar tidak tertutup nav bar
              child: SizedBox(height: 120),
            ),
          ],
        ),
      ),
    );
  }
}

class Post {
  final String username;
  final String userAvatar;
  final String imageUrl;
  final String caption;
  final int likes;
  final String timeAgo;
  final bool isVerified;

  Post({
    required this.username,
    required this.userAvatar,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.timeAgo,
    required this.isVerified,
  });
}

class PostWidget extends StatefulWidget {
  final Post post;

  PostWidget({required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> with TickerProviderStateMixin {
  bool isLiked = false;
  late int likesCount;
  late AnimationController _likeAnimationController;
  late Animation<double> _likeAnimation;

  @override
  void initState() {
    super.initState();
    likesCount = widget.post.likes;
    _likeAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _likeAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _likeAnimationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.post.userAvatar),
                    onBackgroundImageError: (exception, stackTrace) {
                      setState(() {});
                    },
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.post.username,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          if (widget.post.isVerified) ...[
                            SizedBox(width: 4),
                            Icon(Icons.verified, color: Colors.blue, size: 16),
                          ],
                        ],
                      ),
                      Text(
                        widget.post.timeAgo,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz, color: Colors.grey.shade600),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Image
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.post.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value:
                          loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                    ),
                  );
                },
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.broken_image_rounded,
                        size: 60,
                        color: Colors.grey.shade400,
                      ),
                    ),
              ),
            ),
          ),

          // Action buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: _likeAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _likeAnimation.value,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isLiked = !isLiked;
                            likesCount += isLiked ? 1 : -1;
                          });
                          _likeAnimationController.forward().then((_) {
                            _likeAnimationController.reverse();
                          });
                          HapticFeedback.lightImpact();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey.shade700,
                            size: 24,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () => HapticFeedback.lightImpact(),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: Colors.grey.shade700,
                      size: 22,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => HapticFeedback.lightImpact(),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.share_rounded,
                      color: Colors.grey.shade700,
                      size: 22,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => HapticFeedback.lightImpact(),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.bookmark_border_rounded,
                      color: Colors.grey.shade700,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Likes count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${likesCount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} suka',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),

          // Caption
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: widget.post.username,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: ' ${widget.post.caption}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
