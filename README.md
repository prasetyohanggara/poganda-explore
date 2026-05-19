# PogandaExplore 
**Aplikasi Wisata Edukasi Pantai Poganda**
> Media Digital Interaktif berbasis Flutter

---

## Struktur Proyek

```
lib/
├── main.dart                  # Entry point aplikasi
├── theme/
│   └── app_theme.dart         # Warna, tipografi, tema global
├── data/
│   └── app_data.dart          # Data materi & 10 soal kuis
└── pages/
    ├── splash_page.dart        # Splash screen animasi
    ├── main_navigation.dart    # Bottom nav controller (Home/Explore/Quiz/Gallery)
    ├── home_page.dart          # Halaman beranda + hero + grid menu + fakta menarik
    ├── explore_page.dart       # Daftar materi dengan filter & search
    ├── detail_materi_page.dart # Detail konten artikel (SliverAppBar + hero image)
    ├── quiz_page.dart          # Kuis interaktif + progress bar + feedback warna
    ├── quiz_result_page.dart   # Hasil kuis + skor + predikat + animasi
    ├── gallery_page.dart       # Galeri foto + filter + hero animation lightbox
    └── map_page.dart           # Peta Google Maps + marker lokasi + navigasi eksternal
```

---

## Cara Setup & Menjalankan

### 1. Clone / Ekstrak proyek

```bash
cd poganda_explore
flutter pub get
```

### 2. Setup Google Maps API Key

**Android** — buka `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="MASUKKAN_API_KEY_ANDA_DI_SINI"/>
```

> Dapatkan API key gratis di: https://console.cloud.google.com/
> Aktifkan: **Maps SDK for Android**

### 3. Tambahkan Assets (Opsional)


```
assets/
├── fonts/
│   ├── Poppins-Regular.ttf
│   ├── Poppins-Medium.ttf
│   ├── Poppins-SemiBold.ttf
│   └── Poppins-Bold.ttf
└── images/
    ├── pantai_poganda.jpg
    ├── ikan_bakar.jpg
    └── [gambar_materi_lainnya].jpg
```

### 4. Jalankan aplikasi

```bash
flutter run
```

---

## Fitur Aplikasi

| Fitur | Deskripsi |
|---|---|
| 🌊 Splash Screen | Animasi logo + wave loader 2.8 detik |
| 🏠 Home | Hero image pantai + grid menu 4 fitur + fakta menarik scroll |
| 🔍 Explore | Daftar materi dengan search bar + filter kategori |
| 📖 Detail Materi | SliverAppBar + konten artikel + gambar inline |
| 🧠 Kuis | 10 soal pilihan ganda + warna hijau/merah + penjelasan jawaban |
| 🏆 Hasil Kuis | Skor lingkaran + predikat + motivasi + coba lagi |
| 🖼️ Galeri | Grid foto + filter + Hero Animation lightbox fullscreen |
| 🗺️ Peta | Google Maps satellite + 4 marker lokasi + buka Google Maps |

---

## Warna Tema

| Nama | Hex | Penggunaan |
|---|---|---|
| Primary Teal | `#006D6D` | AppBar, tombol, aksen |
| Primary Dark | `#004F4F` | Header gelap, gradient |
| Sky Blue | `#4FC3F7` | Sekunder, chip aktif |
| Background | `#F5F5F0` | Latar halaman |
| Success | `#4CAF50` | Jawaban benar kuis |
| Error | `#F44336` | Jawaban salah kuis |
| Feedback BG | `#E0F4F4` | Card penjelasan kuis |

---

## Lokasi Pantai Poganda

- **Koordinat:** -1.5120, 123.0450
- **Kabupaten:** Banggai Kepulauan
- **Provinsi:** Sulawesi Tengah

---

## Catatan Tambahan

- Semua gambar materi dan ikon sekarang menggunakan aset lokal yang disimpan di dalam folder assets/images/
- Font **Poppins** sudah dikonfigurasi di `pubspec.yaml`
- Aplikasi mendukung **Android** dan **iOS** (Flutter multiplatform)
