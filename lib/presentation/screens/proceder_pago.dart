import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:marketplace/presentation/providers/cart_provider.dart';
import 'package:marketplace/presentation/providers/checkout_provider.dart';
import 'package:marketplace/presentation/screens/order_confirmation_screen.dart';

class ProcederPagoScreen extends StatefulWidget {
  const ProcederPagoScreen({super.key});

  @override
  State<ProcederPagoScreen> createState() => _ProcederPagoScreenState();
}

class _ProcederPagoScreenState extends State<ProcederPagoScreen> {
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Color principal de la app
    const Color primaryColor = Color(0xFF4DB6AC);
    
    final cartProvider = context.watch<CartProvider>();
    final checkoutProvider = context.watch<CheckoutProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Confirmación de Pedido", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // --- DIRECCIÓN ---
            const Text(
              "Dirección de envío", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5)
                  )
                ]
              ),
              child: TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.location_on, color: primaryColor),
                  hintText: "Ingresa tu dirección completa",
                  border: InputBorder.none,
                  labelText: "Dirección de entrega"
                ),
                maxLines: 2,
                minLines: 1,
              ),
            ),
            
            const SizedBox(height: 25),

            const Text(
              "Método de Pago", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)
            ),
            const SizedBox(height: 10),

            // Opcion 1: Mastercard
            _PaymentMethodCard(
               value: 1, 
               groupValue: checkoutProvider.selectedPaymentMethod, 
               label: "Mastercard  •••• 1234",
               icon: Icons.credit_card,
               color: primaryColor,
               onChanged: (_) => checkoutProvider.changePaymentMethod(1),
            ),
            const SizedBox(height: 10),

            // Opcion 2: Visa
            _PaymentMethodCard(
               value: 2, 
               groupValue: checkoutProvider.selectedPaymentMethod, 
               label: "Visa  •••• 5678",
               icon: Icons.credit_card_outlined, // You might want a different icon
               color: Colors.blueAccent, // Just for the icon potentially
               onChanged: (_) => checkoutProvider.changePaymentMethod(2),
            ),
            const SizedBox(height: 10),

            // Opcion 3: Efectivo
            _PaymentMethodCard(
               value: 3, 
               groupValue: checkoutProvider.selectedPaymentMethod, 
               label: "Pago en Efectivo",
               icon: Icons.money,
               color: Colors.green,
               onChanged: (_) => checkoutProvider.changePaymentMethod(3),
            ),
            const SizedBox(height: 10),

            // Opcion 4: PayPal
            _PaymentMethodCard(
               value: 4, 
               groupValue: checkoutProvider.selectedPaymentMethod, 
               label: "PayPal",
               icon: Icons.account_balance_wallet,
               color: Colors.blue[800]!,
               onChanged: (_) => checkoutProvider.changePaymentMethod(4),
            ),

            const SizedBox(height: 25),
            
            // --- RESUMEN DE COMPRA ---
            const Text(
              "Resumen de Compra", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)
            ),
            const SizedBox(height: 10),
            
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                 boxShadow: [
                   BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5)
                  )
                ]
              ),
              child: Column(
                children: [
                  _OrderRow(label: "Subtotal", amount: cartProvider.subTotal),
                  const SizedBox(height: 10),
                  _OrderRow(label: "Envío", amount: cartProvider.shipping),
                  const SizedBox(height: 10),
                  _OrderRow(label: "Impuestos", amount: cartProvider.tax),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(thickness: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(
                        "\$${cartProvider.total.toStringAsFixed(2)}", 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: primaryColor)
                      )
                    ],
                  ),
                ],
              ),
            ),


            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: checkoutProvider.isLoading 
                  ? null 
                  : () async {
                      if (_addressController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                             content: Text('Por favor ingresa una dirección de envío'),
                             backgroundColor: Colors.orange,
                           )
                         );
                         return;
                      }

                      final success = await checkoutProvider.processPayment(
                        _addressController.text.trim(),
                        cartProvider.items
                      );
                      
                      if (context.mounted && success) {
                        cartProvider.clearCart();
                        context.go('/order-confirmation');
                        
                      } else if (context.mounted && !success) {
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                             content: Text('Error al procesar el pago'),
                             backgroundColor: Colors.red,
                           )
                         );
                      }
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  elevation: 2
                ),
                child: checkoutProvider.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "PAGAR AHORA", 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)
                    )
              ),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final int value;
  final int groupValue;
  final String label;
  final IconData icon;
  final Color color;
  final ValueChanged<int?> onChanged;

  const _PaymentMethodCard({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.icon,
    required this.color,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF4DB6AC);
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          boxShadow: [
             BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5)
            )
          ]
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: value == 3 ? Colors.green : (value == 2 ? Colors.blue : Colors.black54)),
            const SizedBox(width: 15),
            Expanded(
              child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
            ),
            Radio<int>(
              value: value, 
              groupValue: groupValue, 
              onChanged: onChanged,
              activeColor: primaryColor,
            )
          ],
        ),
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  final String label;
  final double amount;

  const _OrderRow({
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
        Text("\$${amount.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16))
      ],
    );
  }
}
