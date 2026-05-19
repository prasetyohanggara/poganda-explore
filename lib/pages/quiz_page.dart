// lib/pages/quiz_page.dart
import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';
import 'quiz_result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _answered = false;
  final List<int?> _jawabanUser = List.filled(10, null);

  late AnimationController _animController;
  late Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  QuizQuestion get _currentSoal => daftarSoal[_currentIndex];
  double get _progress => (_currentIndex + 1) / daftarSoal.length;

  void _pilihJawaban(int idx) {
    if (_answered) return;
    setState(() {
      _selectedOption = idx;
      _answered = true;
      _jawabanUser[_currentIndex] = idx;
      if (idx == _currentSoal.jawabanBenar) _score += 10;
    });
  }

  void _lanjut() {
    if (_currentIndex < daftarSoal.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _answered = false;
      });
      _animController.reset();
      _animController.forward();
    } else {
      // Selesai — ke halaman hasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizResultPage(
            score: _score,
            totalSoal: daftarSoal.length,
            jawabanUser: _jawabanUser,
          ),
        ),
      );
    }
  }
  

  Color _opsiColor(int idx) {
    if (!_answered) {
      return _selectedOption == idx ? AppTheme.primary : Colors.white;
    }
    if (idx == _currentSoal.jawabanBenar) return AppTheme.success;
    if (idx == _selectedOption && idx != _currentSoal.jawabanBenar) return AppTheme.error;
    return Colors.white;
  }

  Color _opsiTextColor(int idx) {
    if (!_answered) {
      return _selectedOption == idx ? Colors.white : AppTheme.textDark;
    }
    if (idx == _currentSoal.jawabanBenar) return Colors.white;
    if (idx == _selectedOption && idx != _currentSoal.jawabanBenar) return Colors.white;
    return AppTheme.textGrey;
  }

  Color _opsiCircleColor(int idx) {
    if (!_answered) return _selectedOption == idx ? Colors.white24 : AppTheme.feedbackBg;
    if (idx == _currentSoal.jawabanBenar) return Colors.white24;
    if (idx == _selectedOption) return Colors.white24;
    return Colors.grey.shade100;
  }

  Color _opsiCircleTextColor(int idx) {
    if (!_answered) return _selectedOption == idx ? Colors.white : AppTheme.primary;
    if (idx == _currentSoal.jawabanBenar) return Colors.white;
    if (idx == _selectedOption) return Colors.white;
    return AppTheme.textGrey;
  }

  Widget? _trailingIcon(int idx) {
    if (!_answered) return null;
    if (idx == _currentSoal.jawabanBenar) {
      return const Icon(Icons.check_circle_rounded, color: Colors.white, size: 22);
    }
    if (idx == _selectedOption) {
      return const Icon(Icons.cancel_rounded, color: Colors.white, size: 22);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final soal = _currentSoal;
    final labels = ['A', 'B', 'C', 'D'];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppTheme.textDark),
          onPressed: () => _showExitDialog(context),
        ),
        title: const Text(
          'Kuis Pantai Poganda',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.feedbackBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$_score pts',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Soal ${_currentIndex + 1} dari ${daftarSoal.length}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppTheme.textGrey,
                      ),
                    ),
                    Text(
                      '${((_currentIndex) / daftarSoal.length * 100).toInt()}% Selesai',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),

          // Soal & opsi
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: FadeTransition(
                opacity: _slideAnim,
                child: Column(
                  children: [
                    // Card soal
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.withValues(alpha:0.1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  color: AppTheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${_currentIndex + 1}',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  soal.pertanyaan,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textDark,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Opsi jawaban
                    ...List.generate(soal.opsi.length, (i) {
                      return GestureDetector(
                        onTap: () => _pilihJawaban(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: _opsiColor(i),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _answered
                                  ? (i == soal.jawabanBenar
                                      ? AppTheme.success
                                      : i == _selectedOption
                                          ? AppTheme.error
                                          : Colors.grey.withValues(alpha:0.2))
                                  : (_selectedOption == i
                                      ? AppTheme.primary
                                      : Colors.grey.withValues(alpha:0.2)),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: _opsiCircleColor(i),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    labels[i],
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: _opsiCircleTextColor(i),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  soal.opsi[i],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _opsiTextColor(i),
                                  ),
                                ),
                              ),
                              if (_trailingIcon(i) != null) _trailingIcon(i)!,
                            ],
                          ),
                        ),
                      );
                    }),

                    // Feedback penjelasan
                    if (_answered) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.feedbackBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppTheme.primary.withValues(alpha:0.25)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.info_outline_rounded, color: AppTheme.primary, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Penjelasan',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.primaryDark,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    soal.penjelasan,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      color: AppTheme.primaryDark,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),

          // Tombol lanjut
          AnimatedOpacity(
            opacity: _answered ? 1.0 : 0.4,
            duration: const Duration(milliseconds: 200),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _answered ? _lanjut : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _answered ? AppTheme.primary : Colors.grey.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentIndex < daftarSoal.length - 1
                            ? 'Lanjut ke Soal Berikutnya'
                            : 'Lihat Hasil Kuis',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Keluar dari Kuis?'),
      content: const Text('Progres kuis kamu akan hilang jika keluar sekarang.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext), // Tutup dialog saja
          child: const Text('Lanjutkan Kuis'),
        ),
        TextButton(
          onPressed: () {
            // 1. RESET data kuis secara manual
            setState(() {
              _currentIndex = 0;
              _score = 0;
              _selectedOption = null;
              _answered = false;
              _jawabanUser.fillRange(0, _jawabanUser.length, null);
            });

            // 2. NAVIGASI PAKSA (Buang semua tumpukan, balik ke awal)
            // Ganti '/' dengan nama route halaman utama kamu (biasanya '/' atau '/home')
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          },
          child: const Text(
            'Keluar',
            style: TextStyle(color: Colors.red, fontFamily: 'Poppins'),
          ),
        ),
      ],
    ),
  );
}
}
