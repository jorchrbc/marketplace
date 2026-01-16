import 'package:flutter/material.dart';
import 'package:marketplace/presentation/providers/cart_provider.dart';
import 'package:marketplace/domain/entities/cart_item.dart';
import 'package:provider/provider.dart';

class CarritoComprasScreen extends StatefulWidget {
  const CarritoComprasScreen({super.key});

  @override
  State<CarritoComprasScreen> createState() => _CarritoComprasScreenState();
}

class _CarritoComprasScreenState extends State<CarritoComprasScreen> {

  @override
  void initState() {
    super.initState();
    // Cargar el carrito al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().loadCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Primary color extracted from previous context (0xFF3EC6AF and 0xFF4DB6AC)
    const primaryColor = Color(0xFF4DB6AC);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Carrito',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          
          if (cartProvider.isLoading) {
             return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lista de productos
                  if (cartProvider.items.isEmpty)
                    const Center(child: Text("El carrito está vacío")),
                  
                  ...cartProvider.items.map((item) => Column(
                    children: [
                      _CartItem(
                        item: item,
                        primaryColor: primaryColor,
                      ),
                      const SizedBox(height: 20),
                    ],
                  )),

                  if (cartProvider.items.isNotEmpty) ...[

                    const SizedBox(height: 10),
                    const Divider(color: Colors.grey, thickness: 0.5),
                    const SizedBox(height: 10),
      
                    // Resumen
                    _SummaryRow(
                      label: "Sub Total", 
                      amount: "\$${cartProvider.subTotal.toStringAsFixed(2)}"
                    ),
                    const SizedBox(height: 10),
                    _SummaryRow(
                      label: "Envío", 
                      amount: "\$${cartProvider.shipping.toStringAsFixed(2)}"
                    ),
                    const SizedBox(height: 10),
                    _SummaryRow(
                      label: "Impuestos", 
                      amount: "\$${cartProvider.tax.toStringAsFixed(2)}"
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                          ),
                        ),
                        Text(
                          "\$${cartProvider.total.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black 
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 30),
      
                    // Botón Checkout
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Proceder al Pago',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String amount;

  const _SummaryRow({required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _CartItem extends StatelessWidget {
  final CartItem item;
  final Color primaryColor;

  const _CartItem({
    required this.item,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    // Determinar icono basado en nombre (provisional)
    IconData iconData = Icons.shopping_bag;
    if (item.name.toLowerCase().contains('laptop')) {
      iconData = Icons.computer;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(iconData, size: 40, color: Colors.grey[600]),
          ),
          const SizedBox(width: 15),

          // Detalles
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "\$${item.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                
                // Controles de cantidad
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                         context.read<CartProvider>().incrementQuantity(item.productId, item.quantity);
                      },
                      child: _QuantityButton(
                        icon: Icons.add,
                        color: primaryColor,
                        iconColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        context.read<CartProvider>().decrementQuantity(item.productId, item.quantity);
                      },
                      child: _QuantityButton(
                        icon: Icons.remove,
                        color: primaryColor.withOpacity(0.2),
                        iconColor: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Icono eliminar
          IconButton(
            onPressed: () {
              context.read<CartProvider>().removeItem(item.id);
            },
            icon: const Icon(Icons.delete_outline, size: 28),
            color: Colors.black54,
          )
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;

  const _QuantityButton({
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 18,
        color: iconColor,
      ),
    );
  }
}
