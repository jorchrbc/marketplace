import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:marketplace/presentation/providers/providers.dart';

class VendorProductsView extends StatefulWidget {
  const VendorProductsView({super.key});

  @override
  State<VendorProductsView> createState() => _VendorProductsViewState();
}

class _VendorProductsViewState extends State<VendorProductsView> {
  
  @override
  void initState() {
    super.initState();
    // Cargar productos al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VendorProductsProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vendorProvider = context.watch<VendorProductsProvider>();
    final products = vendorProvider.products;
    final isLoading = vendorProvider.isLoading;

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? const Center(child: Text('No tienes productos publicados.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      elevation: 3,
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            product.image ?? 'https://via.placeholder.com/150',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green[700],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Stock: ${product.stock}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: product.stock > 0 ? Colors.grey[700] : Colors.red,
                                  fontWeight: product.stock > 0 ? FontWeight.normal : FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Delete Icon
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Eliminar producto"),
                                  content: const Text("¿Realmente quieres eliminar este producto?"),
                                  actions: [
                                    TextButton(
                                      child: const Text("Cancelar"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
                                      onPressed: () {
                                        context.read<VendorProductsProvider>().deleteProduct(product.id);
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Producto eliminado'))
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/create-product');
        },
        label: const Text('Nuevo Producto'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
