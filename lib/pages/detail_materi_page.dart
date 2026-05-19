// lib/pages/detail_materi_page.dart
import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';
import 'quiz_page.dart';

class DetailMateriPage extends StatelessWidget {
  final MateriItem item;
  const DetailMateriPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: AppTheme.primary,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: Colors.black26,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // TETAP PAKAI IMAGE.ASSET, TAPI PANGGIL PROPERTI YANG SUDAH ADA
                      Image.asset(
                        item.heroImageUrl, 
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppTheme.primary,
                          child: const Icon(Icons.broken_image, size: 80, color: Colors.white38),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.35)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Konten artikel
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge kategori
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          decoration: BoxDecoration(
                            color: item.badgeColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.kategori,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: item.badgeColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Judul
                        Text(
                          item.judul,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Meta info
                        const Row(
                          children: [
                             Icon(Icons.location_on_outlined, size: 16, color: AppTheme.textGrey),
                             SizedBox(width: 4),
                             Text('Tolitoli', style: TextStyle(fontFamily: 'Poppins', fontSize: 13, color: AppTheme.textGrey)),
                             SizedBox(width: 16),
                             Icon(Icons.access_time_rounded, size: 16, color: AppTheme.textGrey),
                             SizedBox(width: 4),
                             Text('5 min baca', style: TextStyle(fontFamily: 'Poppins', fontSize: 13, color: AppTheme.textGrey)),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Chips aktivitas (jika ada)
                        if (item.aktivitasChips.isNotEmpty) ...[
                          Text(
                            'Aktivitas Unggulan',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: item.badgeColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: item.aktivitasChips.map((chip) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.withValues(alpha:0.3)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(chip, style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: AppTheme.textDark)),
                            )).toList(),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Divider
                        Divider(color: Colors.grey.withValues(alpha:0.15)),
                        const SizedBox(height: 16),

                        // Konten paragraf 1
                        Text(
                          item.konten,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: AppTheme.textDark,
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Inline image + aktivitas utama card
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            // MENGGUNAKAN 'item.imagePath' SESUAI KONSTRUKTOR KAMU
                            item.imageUrl, 
                           height: 200,
                           width: double.infinity,
                           fit: BoxFit.cover,
                           errorBuilder: (context, error, stackTrace) => Container(
                              height: 200,
                              color: AppTheme.feedbackBg,
                             child: const Icon(
                               Icons.broken_image, 
                              size: 60, 
                               color: AppTheme.primary,
                             ),
                            ),
                         ),
                        ),
                        const SizedBox(height: 12),

                        // Card aktivitas utama
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.withValues(alpha:0.15)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Aktivitas Utama',
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item.aktivitasUtama,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  color: AppTheme.textGrey,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Konten lanjutan
                        Text(
                          item.kontenLanjutan,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: AppTheme.textDark,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Sticky bottom button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.08),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QuizPage()),
                  ),
                  icon: const Icon(Icons.quiz_rounded, size: 20),
                  label: const Text('Mulai Kuis Terkait'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
