// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'explore_page.dart';
import 'quiz_page.dart';
import 'gallery_page.dart';
import 'map_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparan agar Hero image terlihat penuh
        elevation: 0,
        
        title: const Text(
          'PogandaExplore',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image section
             _HeroSection(),
            // Jelajahi Pantai grid menu
             _MenuSection(),
            // Fakta Menarik
             _FaktaMenarikSection(),
             SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ─── HERO SECTION ──────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.52,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Gambar pantai
          Image.asset(
            // GANTI DENGAN PATH GAMBAR UTAMA KAMU LANGSUNG DI SINI
            'assets/images/pantai_poganda.jpg', 
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryDark, AppTheme.primary],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Center(
                child: Icon(Icons.beach_access, size: 80, color: Colors.white54),
              ),
            ),
          ),
          // Gradient overlay agar teks terbaca
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
          // Teks overlay
          const Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pantai Poganda',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white70, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Tolitoli, Sulawesi Tengah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── MENU GRID SECTION ─────────────────────────────────────────────────────

class _MenuSection extends StatelessWidget {
  const _MenuSection();

  @override
  Widget build(BuildContext context) {
    final menus = [
      const _MenuData(icon: Icons.explore_rounded, label: 'Jelajahi', color: Color(0xFF006D6D), bgColor: Color(0xFFE0F4F4)),
      const _MenuData(icon: Icons.quiz_rounded, label: 'Kuis', color: Color(0xFFE65100), bgColor: Color(0xFFFFF3E0)),
      const _MenuData(icon: Icons.photo_camera_rounded, label: 'Galeri', color: Color(0xFF1565C0), bgColor: Color(0xFFE3F2FD)),
      const _MenuData(icon: Icons.map_rounded, label: 'Peta', color: Color(0xFF2E7D32), bgColor: Color(0xFFE8F5E9)),
    ];

    return Container(
      color: AppTheme.background,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jelajahi Pantai',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 4),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: menus.map((m) => _MenuCard(data: m)).toList(),
          ),
        ],
      ),
    );
  }
}

class _MenuData {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  const _MenuData({required this.icon, required this.label, required this.color, required this.bgColor});
}

class _MenuCard extends StatelessWidget {
  final _MenuData data;
  const _MenuCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi menggunakan Navigator.push untuk menghindari error _MainNavigationState
        Widget targetPage;
        switch (data.label) {
          case 'Jelajahi':
            targetPage = const ExplorePage();
            break;
          case 'Kuis':
            targetPage = const QuizPage();
            break;
          case 'Galeri':
            targetPage = const GalleryPage();
            break;
          case 'Peta':
            targetPage = const MapPage();
            break;
          default:
            targetPage = const ExplorePage();
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: data.bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(data.icon, color: data.color, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              data.label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── FAKTA MENARIK SECTION ─────────────────────────────────────────────────

class _FaktaMenarikSection extends StatelessWidget {
  const _FaktaMenarikSection();

  final List<Map<String, dynamic>> _fakta = const [
    {'icon': Icons.water_drop_rounded, 'judul': 'Air Sejernih Kaca', 'deskripsi': 'Dasar laut terlihat jelas dari permukaan'},
    {'icon': Icons.beach_access_rounded, 'judul': 'Pasir Putih Halus', 'deskripsi': 'Tekstur pasir selembut tepung'},
    {'icon': Icons.auto_awesome_rounded, 'judul': 'Hidden Gem', 'deskripsi': 'Belum banyak wisatawan yang tahu'},
    {'icon': Icons.eco_rounded, 'judul': 'Ekosistem Sehat', 'deskripsi': 'Terumbu karang masih terjaga baik'},
    {'icon': Icons.wb_sunny_rounded, 'judul': 'Sunset Indah', 'deskripsi': 'Pemandangan senja yang memukau'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // Pastikan menggunakan AppTheme.surface jika background dianggap deprecated
      color: AppTheme.background, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Text(
              'Fakta Menarik',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16, // Sedikit diperkecil agar proporsional
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),
          ),
          SizedBox(
            // TINGGI DINAIKKAN ke 140 agar tidak overflow 8.0 pixels
            height: 140, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _fakta.length,
              itemBuilder: (_, i) {
                final f = _fakta[i];
                return Container(
                  width: 150, // Sedikit dipersempit agar lebih banyak kartu terlihat
                  margin: const EdgeInsets.only(right: 12, bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.withValues(alpha:0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(f['icon'] as IconData, color: AppTheme.primary, size: 22),
                      const SizedBox(height: 8),
                      Text(
                        f['judul'] as String,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // WRAP DENGAN EXPANDED/FLEXIBLE UNTUK MENGHINDARI OVERFLOW
                      Expanded(
                        child: Text(
                          f['deskripsi'] as String,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: AppTheme.textGrey,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}