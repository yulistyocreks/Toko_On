import '../models/product.dart';

// ============================================================
// DAFTAR PRODUK — tambah, hapus, atau ubah produk di sini.
// Tinggal copy salah satu blok Product(...) untuk menambah produk baru.
// ============================================================
final List<Product> sampleProducts = [
  const Product(
    id: '1',
    name: 'Kaos Polos Hitam',
    description:
        'Kaos polos bahan katun combed 30s, adem dan nyaman dipakai sehari-hari. Tersedia ukuran S-XL.',
    price: 75000,
    stock: 20,
  ),
  const Product(
    id: '2',
    name: 'Celana Jogger Abu',
    description:
        'Celana jogger bahan fleece tebal, cocok untuk santai maupun olahraga ringan.',
    price: 120000,
    stock: 15,
  ),
  const Product(
    id: '3',
    name: 'Topi Baseball Navy',
    description: 'Topi baseball adjustable, bahan kanvas tebal, warna navy elegan.',
    price: 45000,
    stock: 30,
  ),
  const Product(
    id: '4',
    name: 'Tas Selempang Kanvas',
    description:
        'Tas selempang unisex bahan kanvas kuat, muat untuk dompet, HP, dan buku kecil.',
    price: 95000,
    stock: 10,
  ),
  const Product(
    id: '5',
    name: 'Sandal Slop Karet',
    description: 'Sandal slop bahan karet empuk, ringan, dan tidak licin.',
    price: 55000,
    stock: 25,
  ),
  const Product(
    id: '6',
    name: 'Jaket Hoodie Maroon',
    description:
        'Hoodie bahan fleece tebal dengan kantong depan, hangat dipakai saat malam hari.',
    price: 150000,
    stock: 8,
  ),
];
