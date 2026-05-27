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
        backgroundColor: Colors.transparent,
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

//HERO SECTION 

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
          // Gradient overlay
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
                      'Banggai Kepulauan, Sulawesi Tengah',
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

// MENU GRID SECTION 

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

  String? _getBackgroundImage() {
    switch (data.label) {
      case 'Jelajahi':
        return 'assets/images/pantai_poganda_masuk.jpg';
      case 'Kuis':
        return 'assets/images/pantai_poganda_kuis.jpg';
      case 'Galeri':
        return 'assets/images/pantai_poganda_galeri.jpg';
      case 'Peta':
        return 'assets/images/pantai_poganda_peta.jpg';
      default:
        return null;
    }
  }

  String _getSubtitle() {
    switch (data.label) {
      case 'Jelajahi':
        return 'Temukan spot wisata';
      case 'Kuis':
        return 'Uji pengetahuanmu';
      case 'Galeri':
        return 'Lihat koleksi foto';
      case 'Peta':
        return 'Lihat lokasi wisata';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgImage = _getBackgroundImage();

    return InkWell(
      onTap: () {
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
        Navigator.push(context, MaterialPageRoute(builder: (_) => targetPage));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          // Border gradient teal tetap dipertahankan
          border: Border.all(
            color: const Color(0xFF006D6D).withValues(alpha: 0.15),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Strip foto atas (55% tinggi card)
            Expanded(
              flex: 55,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (bgImage != null)
                      Image.asset(
                        bgImage,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFE0F4F4),
                        ),
                      )
                    else
                      Container(color: const Color(0xFFE0F4F4)),

                    // Overlay gradient tipis di bagian bawah foto
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bagian bawah: icon + teks (45% tinggi card)
            Expanded(
              flex: 45,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon kecil dengan accent teal
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFF006D6D).withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(data.icon, color: const Color(0xFF006D6D), size: 18),
                    ),
                    const SizedBox(width: 8),

                    // Label + subtitle
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.label,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF212121),
                            ),
                          ),
                          Text(
                            _getSubtitle(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[500],
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrow kecil sebagai hint clickable
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// FAKTA MENARIK SECTION 

class _FaktaMenarikSection extends StatelessWidget {
  const _FaktaMenarikSection();

  final List<Map<String, dynamic>> _fakta = const [
    {
      'icon': Icons.water_drop_rounded,
      'judul': 'Air Sejernih Kaca',
      'deskripsi': 'Dasar laut terlihat jelas dari permukaan, bahkan tanpa alat bantu selam.',
      'accentColor': Color(0xFF006D6D), // teal
    },
    {
      'icon': Icons.beach_access_rounded,
      'judul': 'Pasir Putih Halus',
      'deskripsi': 'Tekstur pasir selembut tepung, nyaman untuk berjalan tanpa alas kaki.',
      'accentColor': Color(0xFF4FC3F7), // biru muda
    },
    {
      'icon': Icons.auto_awesome_rounded,
      'judul': 'Hidden Gem',
      'deskripsi': 'Belum banyak wisatawan yang tahu, suasana masih sepi dan alami.',
      'accentColor': Color(0xFFFFB347), // oranye
    },
    {
      'icon': Icons.eco_rounded,
      'judul': 'Ekosistem Sehat',
      'deskripsi': 'Terumbu karang masih terjaga baik, menjadi rumah bagi ratusan spesies ikan.',
      'accentColor': Color(0xFF66BB6A), // hijau
    },
    {
      'icon': Icons.wb_sunny_rounded,
      'judul': 'Sunset Indah',
      'deskripsi': 'Pemandangan senja yang memukau dengan langit keemasan di ufuk barat.',
      'accentColor': Color(0xFFEF5350), // merah-oranye
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title dengan left accent border
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Fakta Menarik',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
          ),

          // Vertical list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: _fakta.length,
            itemBuilder: (_, i) {
              final f = _fakta[i];
              final accent = f['accentColor'] as Color;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Left accent bar
                    Container(
                      width: 5,
                      height: 80,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                    ),

                    // Icon dengan background accent tipis
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(f['icon'] as IconData, color: accent, size: 24),
                      ),
                    ),

                    // Teks
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badge nomor + judul
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: accent.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Fakta #${i + 1}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                      color: accent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              f['judul'] as String,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              f['deskripsi'] as String,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: AppTheme.textGrey,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}