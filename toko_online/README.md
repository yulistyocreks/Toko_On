# Toko Online (Aplikasi Flutter)

Aplikasi toko online sederhana: katalog produk → keranjang → checkout kirim pesanan ke WhatsApp.
Berjalan di Android 9 (API 28) ke atas, termasuk versi terbaru.

## Isi project ini
Project ini berisi **kode aplikasi (folder `lib/`) dan `pubspec.yaml`**.
Folder `android/`, `ios/`, dsb belum ada — ini normal, akan dibuat otomatis di langkah pertama di bawah.

```
lib/
  main.dart                     -> titik masuk aplikasi
  config.dart                   -> nomor WhatsApp & nama toko (WAJIB diisi)
  models/product.dart           -> struktur data produk
  data/sample_products.dart     -> DAFTAR PRODUK, edit di sini
  providers/cart_provider.dart  -> logika keranjang belanja
  screens/                      -> halaman: beranda, detail produk, keranjang
  widgets/product_card.dart     -> tampilan kartu produk
  utils/format.dart             -> format harga ke Rupiah
```

---

## 1. WAJIB: isi nomor WhatsApp

Buka `lib/config.dart`, ganti baris ini dengan nomor WhatsApp toko kamu
(kode negara tanpa tanda +, contoh 0812xxxxxxx menjadi 62812xxxxxxx):

```dart
const String whatsappNumber = 'GANTI_DENGAN_NOMOR_WA_ANDA';
```

## 2. Edit / tambah produk

Buka `lib/data/sample_products.dart`. Tinggal copy salah satu blok `Product(...)`
untuk menambah produk baru, atau ubah `name`, `description`, `price`, `stock` yang sudah ada.

---

## Cara mendapatkan file APK (2 opsi)

### Opsi A — Build online tanpa install apapun (paling mudah untuk pemula)

Sudah disiapkan file `.github/workflows/build-apk.yml` yang otomatis mem-build APK
lewat GitHub Actions (gratis).

1. Buat akun GitHub (kalau belum punya) di github.com
2. Buat repository baru, lalu upload semua isi folder project ini ke repository tersebut
   (lewat web GitHub: "Add file" → "Upload files", drag semua file & folder)
3. Buka tab **Actions** di repository → akan otomatis mulai proses build
   (atau klik **Run workflow** kalau belum jalan otomatis)
4. Tunggu sekitar 5-10 menit sampai selesai (tanda centang hijau)
5. Klik hasil build tersebut → scroll ke bagian **Artifacts** → download **toko-online-apk**
6. Extract file zip-nya, di dalamnya ada `app-release.apk` — itu file APK yang siap diinstall

### Opsi B — Build di komputer sendiri (kalau nanti sudah mau lebih fleksibel)

1. Install Flutter SDK: https://docs.flutter.dev/get-started/install
2. Di folder project ini, jalankan di terminal:
   ```
   flutter create --platforms=android .
   flutter pub get
   flutter build apk --release
   ```
3. File APK hasil build ada di:
   `build/app/outputs/flutter-apk/app-release.apk`
4. Salin file itu ke HP, lalu install (aktifkan dulu "Izinkan dari sumber tidak dikenal"
   di pengaturan HP kalau diminta)

---

## Menjalankan langsung untuk uji coba (opsional, butuh Flutter SDK + HP/emulator terhubung)

```
flutter create --platforms=android .
flutter pub get
flutter run
```

---

## Rencana pengembangan selanjutnya (kalau sudah nyaman)
- Simpan data produk di Firebase, supaya bisa update produk tanpa edit kode / build ulang APK
- Tambah fitur login pembeli & riwayat pesanan
- Integrasi payment gateway otomatis (Midtrans / Xendit) menggantikan checkout manual via WhatsApp
- Ganti ikon placeholder produk dengan foto asli (taruh di `assets/images/`, lalu daftarkan di `pubspec.yaml`)
