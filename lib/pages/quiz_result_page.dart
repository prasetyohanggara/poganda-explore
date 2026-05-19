// lib/pages/quiz_result_page.dart
import 'quiz_page.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/app_data.dart';
import 'main_navigation.dart';

class QuizResultPage extends StatefulWidget {
  final int score;
  final int totalSoal;
  final List<int?> jawabanUser;

  const QuizResultPage({
    super.key,
    required this.score,
    required this.totalSoal,
    required this.jawabanUser,
  });

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  int get _benar => widget.jawabanUser
      .asMap()
      .entries
      .where((e) => e.value == daftarSoal[e.key].jawabanBenar)
      .length;

  int get _salah => widget.totalSoal - _benar;

  String get _predikat {
    if (widget.score >= 90) return 'Luar Biasa!';
    if (widget.score >= 70) return 'Sangat Baik!';
    if (widget.score >= 50) return 'Baik!';
    if (widget.score >= 30) return 'Cukup';
    return 'Perlu Belajar Lagi';
  }

  String get _motivasi {
    if (widget.score >= 90) return 'Kamu benar-benar ahli tentang Pantai Poganda! Hebat sekali!';
    if (widget.score >= 70) return 'Kamu sudah mengenal Pantai Poganda dengan baik! Terus eksplorasi keindahannya.';
    if (widget.score >= 50) return 'Lumayan! Coba baca materi lagi untuk hasil yang lebih baik.';
    return 'Jangan menyerah! Pelajari materi dan coba lagi untuk mengenal Pantai Poganda lebih baik.';
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _scaleAnim = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = widget.score / (widget.totalSoal * 10);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          // Header teal
          Container(
            width: double.infinity,
            height: 260,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryDark, AppTheme.primary, Color(0xFF0097A7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.emoji_events_rounded, size: 64, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Kuis Selesai!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Score card (overlap dengan header)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Transform.translate(
                    offset: const Offset(0, -40),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha:0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Circular score
                          ScaleTransition(
                            scale: _scaleAnim,
                            child: SizedBox(
                              width: 140,
                              height: 140,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 140,
                                    height: 140,
                                    child: CircularProgressIndicator(
                                      value: percentage,
                                      strokeWidth: 10,
                                      backgroundColor: Colors.grey.shade200,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        widget.score >= 70 ? AppTheme.primary : AppTheme.error,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${widget.score}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 38,
                                          fontWeight: FontWeight.w700,
                                          color: widget.score >= 70 ? AppTheme.primary : AppTheme.error,
                                        ),
                                      ),
                                      const Text(
                                        '/100',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: AppTheme.textGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Badge predikat
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8E1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.amber.shade300),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                                const SizedBox(width: 6),
                                Text(
                                  _predikat,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF795548),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Benar / Salah
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _StatChip(
                                icon: Icons.check_circle_rounded,
                                color: AppTheme.success,
                                label: '$_benar Benar',
                              ),
                              Container(width: 1, height: 30, color: Colors.grey.shade200, margin: const EdgeInsets.symmetric(horizontal: 20)),
                              _StatChip(
                                icon: Icons.cancel_rounded,
                                color: AppTheme.error,
                                label: '$_salah Salah',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Motivasi
                          Text(
                            _motivasi,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: AppTheme.textGrey,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Tombol
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const QuizPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              child: const Text(
                                'Coba Lagi',
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => const MainNavigation()),
                                  (_) => false,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppTheme.primary, width: 1.5),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              child: const Text(
                                'Kembali ke Beranda',
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.primary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom nav dummy
          Container(
            height: 60,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  const _StatChip({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
