// lib/data/app_data.dart
import 'package:flutter/material.dart';

class MateriItem {
  final String id;
  final String kategori;
  final String judul;
  final String deskripsiSingkat;
  final String konten;
  final String kontenLanjutan;
  final String imageUrl;      // thumbnail di list
  final String heroImageUrl;  // gambar besar di halaman detail
  final Color badgeColor;
  final String aktivitasUtama;
  final List<String> aktivitasChips;

  const MateriItem({
    required this.id,
    required this.kategori,
    required this.judul,
    required this.deskripsiSingkat,
    required this.konten,
    required this.kontenLanjutan,
    required this.imageUrl,
    required this.heroImageUrl,
    required this.badgeColor,
    this.aktivitasUtama = '',
    this.aktivitasChips = const [],
  });
}

final List<MateriItem> daftarMateri = [
  const MateriItem(
    id: 'profil',
    kategori: 'Profil Pantai',
    judul: 'Mengenal Pantai Poganda',
    deskripsiSingkat: 'Destinasi wisata tersembunyi dengan pasir putih lembut dan air laut yang jernih.',
    konten:
        'Pantai Poganda di Banggai Kepulauan, Sulawesi Tengah, merupakan salah satu destinasi wisata yang jarang diketahui namun punya banyak pesona yang siap dieksplor. Terletak di sebuah daerah yang masih cukup alami, pantai ini menawarkan keindahan yang mempesona dengan pasir putihnya yang lembut, air laut yang sangat jernih, dan suasana yang menenangkan.',
    kontenLanjutan:
        'Bagi pecinta fotografi, waktu terbaik untuk berkunjung adalah menjelang senja. Langit Poganda akan berubah menjadi kanvas raksasa dengan gradasi warna jingga, ungu, dan merah muda yang memantul indah di permukaan air laut yang tenang.',
    imageUrl: 'assets/images/pantai_poganda.jpg',
    heroImageUrl: 'assets/images/pantai_poganda.jpg',
    badgeColor: Color(0xFF006D6D),
    aktivitasUtama: 'Menikmati keindahan pantai dengan pasir putih yang bersih dan air jernih yang tenang.',
    aktivitasChips: ['Bersantai', 'Fotografi', 'Piknik', 'Sunset'],
  ),
  const MateriItem(
    id: 'terumbu',
    kategori: 'Daya Tarik',
    judul: 'Terumbu Karang dan Snorkeling',
    deskripsiSingkat: 'Keanekaragaman hayati bawah laut yang memukau, cocok untuk snorkeling.',
    konten:
        'Pantai Poganda bukan sekadar destinasi wisata biasa; ini adalah permata tersembunyi di Banggai Kepulauan yang menawarkan ketenangan yang sulit ditemukan di tempat lain. Di bawah permukaan airnya yang bening, tersembunyi ekosistem terumbu karang yang kaya.',
    kontenLanjutan:
        'Kejernihan air yang luar biasa memungkinkan Anda melihat dasar laut dengan jelas bahkan tanpa peralatan selam khusus. Berbagai jenis ikan tropis berwarna-warni berenang bebas di antara terumbu karang yang sehat.',
    imageUrl: 'assets/images/terumbu_karang.jpg',
    heroImageUrl: 'assets/images/terumbu_karang.jpg',
    badgeColor: Color(0xFF1565C0),
    aktivitasUtama: 'Menikmati keindahan bawah laut dengan peralatan snorkeling yang bisa disewa di sekitar pantai.',
    aktivitasChips: ['Snorkeling', 'Diving', 'Fotografi Bawah Laut', 'Observasi Ikan'],
  ),
  const MateriItem(
    id: 'aktivitas',
    kategori: 'Aktivitas Wisata',
    judul: 'Aktivitas Seru di Pantai Poganda',
    deskripsiSingkat: 'Beragam aktivitas seru menanti Anda, dari snorkeling hingga keliling pulau.',
    konten:
        'Pantai Poganda menawarkan berbagai aktivitas wisata yang sayang untuk dilewatkan. Airnya yang tenang dan jernih menjadikan pantai ini ideal untuk berenang, snorkeling, hingga menyewa perahu nelayan lokal.',
    kontenLanjutan:
        'Momen sunset di Pantai Poganda adalah atraksi wajib yang tidak boleh dilewatkan. Duduk di tepi pantai sambil menikmati siluet pohon kelapa berlatar langit jingga keemasan adalah pengalaman yang akan selalu dikenang.',
    imageUrl: 'assets/images/snorkeling.jpg',
    heroImageUrl: 'assets/images/snorkeling.jpg',
    badgeColor: Color(0xFFE65100),
    aktivitasUtama: 'Beragam aktivitas mulai dari snorkeling, berenang, hingga mengelilingi pulau dengan perahu nelayan.',
    aktivitasChips: ['Snorkeling', 'Berenang', 'Sunset Watching', 'Keliling Pulau', 'Piknik'],
  ),
  const MateriItem(
    id: 'kuliner',
    kategori: 'Kuliner Lokal',
    judul: 'Ikan Bakar dan Sambal Dabu',
    deskripsiSingkat: 'Nikmati hidangan laut segar hasil tangkapan nelayan Poganda yang lezat.',
    konten:
        'Pengalaman wisata ke Pantai Poganda tidak akan lengkap tanpa mencicipi kuliner laut khas yang lezat. Sajian ikan bakar segar hasil tangkapan nelayan lokal menjadi primadona di sini.',
    kontenLanjutan:
        'Jangan lewatkan juga minuman segar kelapa muda yang banyak dijual di sekitar pantai. Air kelapa yang manis dan segar sangat pas untuk melepas dahaga setelah beraktivitas.',
    imageUrl: 'assets/images/ikan_bakar.jpg',
    heroImageUrl: 'assets/images/ikan_bakar.jpg',
    badgeColor: Color(0xFFB71C1C),
    aktivitasUtama: 'Menikmati hidangan ikan bakar segar dengan sambal dabu-dabu khas Sulawesi di warung tepi pantai.',
    aktivitasChips: ['Ikan Bakar', 'Sambal Dabu', 'Kelapa Muda', 'Seafood Segar'],
  ),
];

// ─── DATA KUIS (Gambar Dihapus) ──────────────────────────────────────────────

class QuizQuestion {
  final String pertanyaan;
  final List<String> opsi;
  final int jawabanBenar; // index 0-3
  final String penjelasan;

  const QuizQuestion({
    required this.pertanyaan,
    required this.opsi,
    required this.jawabanBenar,
    required this.penjelasan,
  });
}

final List<QuizQuestion> daftarSoal = [
  const QuizQuestion(
    pertanyaan: 'Di provinsi manakah letak Pantai Poganda berada?',
    opsi: ['Sulawesi Selatan', 'Sulawesi Tengah', 'Sulawesi Tenggara', 'Sulawesi Utara'],
    jawabanBenar: 1,
    penjelasan: 'Pantai Poganda terletak di Kabupaten Banggai Kepulauan yang secara administratif merupakan bagian dari Provinsi Sulawesi Tengah.',
  ),
  const QuizQuestion(
    pertanyaan: 'Apa ciri khas utama dari perairan di Pantai Poganda?',
    opsi: [
      'Ombak yang sangat besar untuk surfing',
      'Air yang berwarna keruh kecokelatan',
      'Air yang sangat jernih dan tenang seperti kolam',
      'Memiliki banyak palung laut yang dalam',
    ],
    jawabanBenar: 2,
    penjelasan: 'Karakteristik utama pantai ini adalah perairannya yang sangat jernih dengan ombak yang tenang.',
  ),
  const QuizQuestion(
    pertanyaan: 'Pantai Poganda terletak di wilayah kabupaten apa?',
    opsi: ['Banggai Laut', 'Banggai Kepulauan', 'Tojo Una-Una', 'Morowali'],
    jawabanBenar: 1,
    penjelasan: 'Pantai ini adalah salah satu aset wisata unggulan di Kabupaten Banggai Kepulauan.',
  ),
  const QuizQuestion(
    pertanyaan: 'Pohon apa yang banyak tumbuh di pesisir Pantai Poganda?',
    opsi: ['Pohon Pinus', 'Pohon Kelapa', 'Pohon Jati', 'Pohon Mangga'],
    jawabanBenar: 1,
    penjelasan: 'Pesisir pantai ini didominasi oleh deretan pohon kelapa yang memberikan keteduhan.',
  ),
  const QuizQuestion(
    pertanyaan: 'Kegiatan air apa yang paling direkomendasikan di Pantai Poganda?',
    opsi: [
      'Memancing ikan paus',
      'Snorkeling dan berenang',
      'Bermain Jetski dengan kecepatan tinggi',
      'Berlayar dengan kapal pesiar besar',
    ],
    jawabanBenar: 1,
    penjelasan: 'Karena airnya yang sangat tenang dan jernih, kegiatan melihat keindahan bawah laut sangat aman dilakukan.',
  ),
  const QuizQuestion(
    pertanyaan: 'Mengapa Pantai Poganda disebut sebagai destinasi "Hidden Gem"?',
    opsi: [
      'Karena lokasinya berada di tengah hutan rimba',
      'Karena tiket masuknya sangat mahal',
      'Karena keindahannya luar biasa namun belum banyak diketahui wisatawan luas',
      'Karena pantai ini hanya muncul pada malam hari',
    ],
    jawabanBenar: 2,
    penjelasan: 'Istilah ini diberikan karena lokasinya yang masih asri dan belum banyak terjamah keramaian wisatawan massal.',
  ),
  const QuizQuestion(
    pertanyaan: 'Apa tekstur dominan dari bibir pantai di Poganda?',
    opsi: ['Bebatuan tajam', 'Lumpur hitam', 'Pasir putih yang halus', 'Kerikil berwarna-warni'],
    jawabanBenar: 2,
    penjelasan: 'Pantai ini memiliki bentangan pasir putih yang bersih dan halus.',
  ),
  const QuizQuestion(
    pertanyaan: 'Waktu terbaik untuk menikmati keindahan air laut di Poganda adalah...',
    opsi: [
      'Saat terjadi badai',
      'Pagi dan siang hari saat cuaca cerah',
      'Tengah malam',
      'Saat musim hujan lebat',
    ],
    jawabanBenar: 1,
    penjelasan: 'Pada waktu ini, cahaya matahari menembus air laut dengan maksimal sehingga kejernihan air terlihat paling indah.',
  ),
  const QuizQuestion(
    pertanyaan: 'Apa yang membuat pengunjung merasa nyaman berlama-lama di sini?',
    opsi: [
      'Adanya pusat perbelanjaan megah',
      'Suasana yang sunyi, asri, dan jauh dari kebisingan kota',
      'Adanya fasilitas bioskop di pinggir pantai',
      'Adanya sirkuit balap motor',
    ],
    jawabanBenar: 1,
    penjelasan: 'Daya tarik utamanya adalah ketenangan yang ditawarkan, cocok untuk melepas penat.',
  ),
  const QuizQuestion(
    pertanyaan: 'Apa yang harus dilakukan wisatawan untuk menjaga kelestarian Pantai Poganda?',
    opsi: [
      'Mengambil terumbu karang untuk kenang-kenangan',
      'Memberi makan ikan dengan sisa makanan manusia',
      'Tidak membuang sampah sembarangan dan menjaga kebersihan laut',
      'Membangun bangunan permanen di bibir pantai',
    ],
    jawabanBenar: 2,
    penjelasan: 'Penting bagi pengunjung untuk menjaga kebersihan laut agar ekosistem tetap terjaga.',
  ),
];