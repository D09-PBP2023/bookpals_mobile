# Bookpals 📚 (mobile version)

"Rajin Membaca, Cerewet di BookPals"
> Sebuah karya dari kami, kelompok D09 untuk Indonesia.

> Proyek ini dibuat untuk memenuhi tugas Proyek Akhir Semester pada mata kuliah Pemograman Berbasis Platform (PBP) yang diselenggarakan oleh Fakultas Ilmu Komputer, Universitas Indonesia di Semester Gasal Tahun Ajaran 2023/2024.

# 👨‍💻 Pengembang Aplikasi 👩‍💻
- [Arvin](https://github.com/ArvinCS) (2206041562)
- [Gilang Fajar Pratama](https://github.com/gilangp03) (2206082631)
- [Marvel Martin Everthard](https://github.com/marvelm57) (2206081345)
- [Muhammad Radhitya Utomo](https://github.com/MRadhityaUtomo) (2206830744)
- [Taniella](https://github.com/eilalleinat) (2206082316)
- [Tengku Laras Malahayati](https://github.com/rxa15) (2206081641)

# 🔗 Tautan Aplikasi 🔗
- [Tautan Berita Acara](https://docs.google.com/spreadsheets/d/1dwBu493kp0h4Anzdz9OODnPPbjOiwGEW/edit#gid=122745094)

# ✏️ Latar Belakang Aplikasi ✏️
Pada Proyek Tengah Semester, BookPals hanya berbentuk aplikasi web. Kini, BookPals hadir kembali dalam bentuk aplikasi mobile!

Buku adalah jendela dunia. Ungkapan tersebut mengandung arti yang sangat luas sekaligus mengajak semua orang untuk membaca buku karena orang yang membaca buku akan memperoleh wawasan pengetahuan yang sangat bermanfaat. Beragam karya tulis semakin berkembang sejak manusia menemukan aksara. Dari kitab susastra kuno, kita dapat menggali kemampuan manusia dalam memahami beragam fenomena dalam kehidupan. Diseminasi pengetahuan ke berbagai belahan dunia semakin pesat sejak manusia menemukan mesin cetak. Penemuan teknologi komputer dan internet awalnya diharapkan akan semakin mendukung penyebaran informasi. Sayangnya, minat baca tidak berbanding lurus dengan penemuan teknologi tersebut. Secara singkat, dapat disimpulkan bahwa minat membaca di berbagai belahan dunia semakin menurun yang akhirnya juga mempengaruhi kemampuan literasi seseorang. 

Dalam sebuah riset yang dilakukan oleh UNESCO, Indonesia dinyatakan sebagai salah satu negara yang menduduki urutan bawah literasi dunia. Riset tersebut menunjukkan bahwa minat baca masyarakat Indonesia **HANYA 0.001%**. Akan tetapi, Indonesia menduduki peringkat kelima dunia dalam negara yang memiliki gadget terbanyak (Sumber: [KOMINFO](https://www.kominfo.go.id/content/detail/10862/teknologi-masyarakat-indonesia-malas-baca-tapi-cerewet-di-medsos/0/sorotan_media#:~:text=Fakta%20pertama%2C%20UNESCO%20menyebutkan%20Indonesia,1%20orang%20yang%20rajin%20membaca)). Dengan kondisi yang sedemikian rupa, kami ingin menumbuhkan kembali minat baca tanpa mengabaikan kemajuan teknologi. Dalam projek ini, kami akan merancang sebuah aplikasi berbasis web bernama **BookPals** yang dapat digunakan untuk menghubungkan para penikmat buku dan literasi. Perancangan aplikasi ini terinspirasi dari kegiatan [**BACA BARENG**](https://instagram.com/bacabareng.sbc?igshid=MzRlODBiNWFlZA==) yang diadakan oleh Silent Book Club Jakarta di Taman Literasi Martha Tiahahu. Setiap anggota komunitas tersebut biasanya memilih satu buku pilihan masing-masing yang kemudian akan diceritakan kembali di hadapan anggota lainnya. Dengan mengandaikan kegiatan anggota komunitas tersebut, kami membuat perancangan fitur yang mampu mengajak pengguna untuk saling bertukar buku dan memberikan ulasan setelah membacanya. Tidak hanya itu, kami juga mengundang pengguna kami untuk menjelajahi buku-buku baru melalui opsi pemilihan buku berdasarkan genre, kategori, serta rating yang diberikan oleh pengguna lain. 

Kami berharap kehadiran BookPals tidak hanya dapat mengembalikan minat literasi masyarakat Indonesia, tetapi juga memberikan wadah bagi para peminat buku untuk saling bertukar pandangan. Melalui aplikasi ini, kami berupaya menciptakan lingkungan bagi para pembaca untuk berinteraksi, berbagi ulasan, dan mendiskusikan berbagai buku yang mereka baca. Mari bersama-sama menjelajahi dunia literasi bersama BookPals. 

# ✍️ Daftar Modul yang Akan Diimplementasikan ✍️
Berikut adalah daftar modul yang akan diimplementasikan dalam proyek ini beserta penjelasannya:
1. **Modul Kelompok**
   
| Modul | Penjelasan |
| -- | -- |
| **Authentication** | Pengguna BookPals dapat melakukan registrasi akun, *login*, dan *logout* - Handled by [Arvin](https://github.com/ArvinCS) (2206041562)|
| **About Us** | Pengguna BookPals dapat melihat deskripsi dan latar belakang pembuatan BookPals oleh Kelompok D09 - Handled by all members|

2. **Modul Buku**
   
| Modul | Penjelasan |
| ------ | -- |
| **Book Catalog** | Modul ini terdiri dari submodul **list book**, **book view**, **list owner**, dan **bookmark/add to favorites**, yang masing-masing berperan agar pengguna BookPals dapat **melihat list buku-buku yang tersedia**, **menampilkan judul dan informasi terkait suatu buku yang dipilih**, **menampilkan *username* pengguna-pengguna lain yang memiliki buku tersebut**, serta **menambahkan buku yand dipilih ke *bookmark*** - Home page and headers handled by [Arvin](https://github.com/ArvinCS) (2206041562) - Book details page, bookmark handled by [Taniella](https://github.com/eilalleinat) (2206082316) - Book review handled by [Marvel Martin Everthard](https://github.com/marvelm57) (2206081345)|
| **Profiles and Profile Page for Users** | User akan diberikan **Profile** oleh admin django saat selesai register yang valid dan dapat melihat Profile serta attribute lain seperti **Favorite Book 1-3** dan **Bookmarked Books** pada Profile Page masing - masing - Book entry handled by [Muhammad Radhitya Utomo](https://github.com/MRadhityaUtomo) (2206830744)| 
| **Book Sharing** | Modul ini terdiri dari submodul **Book Review** dan **Book Swap** yang berperan agar pengguna BookPals dapat mengisi dan menampilkan ulasannya terhadap suatu buku dan menginisiasi pertukaran buku dengan pengguna yang lain - Book Swap handled by [Gilang Fajar Pratama](https://github.com/gilangp03) (2206082631)|
| **Book Entry & Review for Admin** | Admin BookPals akan mengecek apakah suatu buku yang akan ditambahkan ke list buku telah tersedia di database. Kemudian, admin akan menyetujui/menolak *request* menambah suatu buku dari pengguna BookPals - Book entry handled by [Tengku Laras Malahayati](https://github.com/rxa15) (2206081641)| 
# 🛜 Sumber Dataset Katalog Buku 🛜
Kami akan menggunakan *dataset* dari Kaggle: https://www.kaggle.com/datasets/drahulsingh/best-selling-books sebagai *database* dari list buku yang akan ditampilkan di BookPals.
# [*Role* Pengguna]
Berikut adalah jenis peran pengguna BookPals beserta penjelasannya:
## 1. User
### User yang Telah Terautentikasi
- Melakukan pencarian dan *filter* buku
- Melihat list buku
- Menambahkan buku ke *bookmark*
- Memberikan rating dan ulasan terkait buku yang telah dibaca
- Melakukan pertukaran buku dengan pengguna lain
- Membuat *request* penambahan buku ke *database*
### User yang Belum Terautentikasi (*Guest*)
- Melakukan pencarian dan *filter* buku
- Melihat list buku
## 2. Admin
- Mengecek apakah buku yang di-*request* oleh User telah tersedia di list buku atau tidak
- Menyetujui/Menolak permintaan menambah buku dari User

# [Integration Guide]

1. Persiapkan endpoint yang akan digunakan untuk mengirim atau menerima request.
2. Beberapa endpoint akan memiliki response yang berupa HttpResponse, jika iya, bikin endpoint baru dengan penambahan `[nama_view/url]-mobile` yang mengembalikan JsonResponse.
3. Persiapkan frontend pada mobile.
4. Setiap endpoint yang akan digunakan masukkan sebagai string di file `lib/core/environments/endpoints.dart`.
5. Lakukan pengiriman/penerimaan request dengan `APIHelper`. Contohnya, 'APIHelper.get(Endpoints.getBooksUrl)'.
6. Response yang diberikan akan berupa JSON yang sudah menjadi tipe `Map<String, dynamic>`.
7. Manfaatkan request yang telah diterima untuk dimunculkan di frontend.
8. Integrasi selesai~.

# [Setup the development]

1. Git clone repository.
2. Pastikan fitur `formatOnSave` menyala agar tertata rapi.
3. Untuk jaga-jaga, jalankan `flutter pub get` sebelum memulai development.
4. Jika kalian menambah package baru saat development, jangan lupa full restart aplikasi!
5. Fitur-fitur yang dibikin masukkan ke folder `features/`.
6. Jika bagian tampilan, masukkan ke subfolder `screens/`. Jika bagian provider, masukkan ke subfolder `providers/`. Sedangkan, jika bagian tersebut merupakan komponen widget "kecil", masukkan ke subfolder `widgets/`. Jika lainnya, tanyakan ke teman-teman kelompok!
7. Push commit Anda ke branch fitur masing-masing, pastikan tidak ada eror.