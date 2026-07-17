import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config.dart';
import '../providers/cart_provider.dart';
import '../utils/format.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _checkoutViaWhatsApp(BuildContext context, CartProvider cart) async {
    if (whatsappNumber == 'GANTI_DENGAN_NOMOR_WA_ANDA') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nomor WhatsApp belum diatur. Ubah di lib/config.dart'),
        ),
      );
      return;
    }

    final buffer = StringBuffer();
    buffer.writeln('Halo, saya ingin memesan:');
    for (final item in cart.itemList) {
      buffer.writeln(
        '- ${item.product.name} x${item.quantity} = ${formatRupiah(item.subtotal)}',
      );
    }
    buffer.writeln('');
    buffer.writeln('Total: ${formatRupiah(cart.totalPrice)}');

    final message = Uri.encodeComponent(buffer.toString());
    final url = Uri.parse('https://wa.me/$whatsappNumber?text=$message');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak bisa membuka WhatsApp')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: Consumer<CartProvider>(
        builder: (context, cart, _) {
          if (cart.isEmpty) {
            return const Center(
              child: Text('Keranjang masih kosong', style: TextStyle(color: Colors.grey)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: cart.itemList.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = cart.itemList[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.shopping_bag_outlined, color: Colors.teal),
                ),
                title: Text(item.product.name),
                subtitle: Text(formatRupiah(item.product.price)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => cart.decreaseQuantity(item.product.id),
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => cart.increaseQuantity(item.product.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, _) {
          if (cart.isEmpty) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 16)),
                    Text(
                      formatRupiah(cart.totalPrice),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _checkoutViaWhatsApp(context, cart),
                    icon: const Icon(Icons.chat),
                    label: const Text('Checkout via WhatsApp'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
