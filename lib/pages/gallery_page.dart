// lib/pages/gallery_page.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  String _selectedFilter = 'Semua';

  final List<String> _filters = ['Semua', 'Pantai', 'Bawah Laut', 'Aktivitas', 'Kuliner'];

  // Data sudah benar menggunakan 'imagePath' sesuai pubspec.yaml kamu
  final List<Map<String, dynamic>> _photos = [
    {
      'imagePath': 'assets/images/pantai_poganda.jpg',
      'caption': 'Pantai Poganda — Tolitoli',
      'kategori': 'Pantai',
      'tall': true,
    },
    {
      'imagePath': 'assets/images/terumbu_karang.jpg',
      'caption': 'Terumbu Karang Bawah Laut',
      'kategori': 'Bawah Laut',
      'tall': false,
    },
    {
      'imagePath': 'assets/images/snorkeling.jpg',
      'caption': 'Snorkeling di Perairan Jernih',
      'kategori': 'Aktivitas',
      'tall': true,
    },
    {
      'imagePath': 'assets/images/ikan_bakar.jpg',
      'caption': 'Kuliner Khas Pantai Poganda',
      'kategori': 'Kuliner',
      'tall': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredPhotos {
    if (_selectedFilter == 'Semua') return _photos;
    return _photos.where((p) => p['kategori'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.textDark,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded, color: AppTheme.textDark),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text(
          'Galeri Pantai Poganda',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppTheme.textDark,
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                itemBuilder: (_, i) {
                  final f = _filters[i];
                  final selected = _selectedFilter == f;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = f),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? AppTheme.primary : const Color(0xFFE0F4F4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: selected ? Colors.white : AppTheme.primary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Grid foto
          Expanded(
            child: _filteredPhotos.isEmpty
                ? const Center(
                    child: Text('Tidak ada foto', style: TextStyle(fontFamily: 'Poppins', color: AppTheme.textGrey)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _filteredPhotos.length,
                    itemBuilder: (_, i) {
                      final photo = _filteredPhotos[i];
                      final tag = 'photo_$i';

                      return GestureDetector(
                        onTap: () => _openLightbox(context, photo, tag),
                        child: Hero(
                          tag: tag,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Perbaikan: Menggunakan Image.asset dengan Null-safety agar tidak crash
                                Image.asset(
                                  (photo['imagePath'] ?? '') as String,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: AppTheme.feedbackBg,
                                    child: const Icon(Icons.broken_image, color: AppTheme.primary, size: 36),
                                  ),
                                ),

                                // Counter badge
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primary.withValues(alpha:0.8),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${i + 1}/${_filteredPhotos.length}',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _openLightbox(BuildContext context, Map<String, dynamic> photo, String tag) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (_, __, ___) => _LightboxPage(photo: photo, heroTag: tag),
      ),
    );
  }
}

// ─── LIGHTBOX (SUDAH DISESUAIKAN) ──────────────────────────────────────────

class _LightboxPage extends StatelessWidget {
  final Map<String, dynamic> photo;
  final String heroTag;
  const _LightboxPage({required this.photo, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(color: Colors.black87),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: heroTag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      // PERBAIKAN KRUSIAL: Ganti Image.network ke Image.asset
                      (photo['imagePath'] ?? '') as String,
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width - 32,
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white, size: 50),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    (photo['caption'] ?? '') as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              right: 16,
              child: CircleAvatar(
                backgroundColor: Colors.white24,
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}