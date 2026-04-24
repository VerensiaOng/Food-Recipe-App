# 🍳 FoodRecipe - UTS Lab Mobile Development

Aplikasi **FoodRecipe** adalah katalog resep makanan modern berbasis mobile yang dibangun menggunakan Flutter. Aplikasi ini mengambil data secara dinamis dari Public API (TheMealDB) dan dilengkapi dengan fitur pencarian asinkron, filter kategori, serta dukungan akses offline (caching).

Proyek ini dikembangkan untuk memenuhi tugas Ujian Tengah Semester (UTS) mata kuliah Lab Pengembangan Aplikasi Mobile.

---

## 📁 Penjelasan Struktur Folder 

Berikut adalah struktur folder di dalam direktori `lib/` beserta fungsinya:

* **`models/`**
    Berisi class data (contoh: `recipe.dart`) yang bertugas memetakan atau mengonversi data mentah JSON dari API menjadi objek Dart yang terstruktur.
* **`services/`**
    Berisi logika jaringan/HTTP (contoh: `api_service.dart`). Semua proses request ke endpoint API TheMealDB diisolasi di sini. Jika ada perubahan pada API di masa depan, kita hanya perlu mengubah file di folder ini tanpa menyentuh UI.
* **`providers/`**
    Berisi class pengelola *state* dan logika bisnis aplikasi (contoh: `recipe_provider.dart`), termasuk di dalamnya logika penyimpanan *cache* secara offline menggunakan `shared_preferences`.
* **`views/`**
    Berisi file yang murni menangani layout halaman secara utuh (contoh: `home_screen.dart`, `detail_screen.dart`).
* **`widgets/`**
    Berisi komponen UI yang dipecah menjadi bagian-bagian kecil agar dapat digunakan berulang kali (*Reusable Widgets*), seperti `RecipeCard`, `CategoryFilter`, dan `ShimmerLoading`.

---

## 🛠️ Mengapa Menggunakan State Management "Provider"?

Dalam pengembangan aplikasi ini, saya memilih **Provider** sebagai *State Management* dengan alasan sebagai berikut:

1.  **Pendekatan yang Direkomendasikan:** Provider secara resmi direkomendasikan oleh tim Flutter untuk aplikasi skala kecil hingga menengah karena terintegrasi sangat baik dengan ekosistem bawaan Flutter.
2.  **Pemisahan Logika yang Bersih:** Provider memungkinkan saya memisahkan logika bisnis (pemanggilan API, *error handling*, dan *offline caching*) secara total dari UI (Widget Tree), sehingga kode UI menjadi lebih bersih dan deklaratif.
3.  **Minim Boilerplate:** Dibandingkan dengan BLoC yang membutuhkan banyak file untuk *Events* dan *States*, Provider jauh lebih ringkas (*low boilerplate*) namun tetap sangat tangguh untuk menangani fungsionalitas asinkron seperti fitur pencarian pada aplikasi ini.
4.  **Single Source of Truth:** Dengan menempatkan data resep di dalam `RecipeProvider`, data tersebut dapat diakses dari halaman mana saja (seperti saat berpindah dari Home ke Detail) tanpa harus melempar data yang rumit melalui *constructor*.
