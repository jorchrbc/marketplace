import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:marketplace/presentation/providers/cart_provider.dart';

class ProcederPagoScreen extends StatefulWidget {
  const ProcederPagoScreen({super.key});

  @override
  State<ProcederPagoScreen> createState() => _ProcederPagoScreenState();
}

class _ProcederPagoScreenState extends State<ProcederPagoScreen> {
  int _selectedMethod = 1;

  @override
  Widget build(BuildContext context) {
    // Color principal de la app
    const Color primaryColor = Color(0xFF4DB6AC);
    
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[50], // Fondo un poco gris para contraste
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle
                    ),
                    child: const Icon(Icons.location_on, color: primaryColor),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Casa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 4),
                        Text("Av. Principal 123, Col. Centro, CDMX", style: TextStyle(color: Colors.grey))
                      ],
                    )
                  ),
                  TextButton(
                    onPressed: (){}, 
                    child: const Text("Editar", style: TextStyle(color: primaryColor))
                  )
                ],
              ),
            ),
            
            const SizedBox(height: 25),

            const Text(
              "Método de Pago", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)
            ),
            const SizedBox(height: 10),

            // Opcion 1: Mastercard
            GestureDetector(
              onTap: () => setState(() => _selectedMethod = 1),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: _selectedMethod == 1 ? Border.all(color: primaryColor, width: 2) : null,
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
                    const Icon(Icons.credit_card, size: 30, color: Colors.black54),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text("Mastercard  •••• 1234", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                    ),
                    Radio(
                      value: 1, 
                      groupValue: _selectedMethod, 
                      onChanged: (v){ setState(() => _selectedMethod = v!); },
                      activeColor: primaryColor,
                    )
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 10),

            // Opcion 2: Visa
            GestureDetector(
              onTap: () => setState(() => _selectedMethod = 2),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: _selectedMethod == 2 ? Border.all(color: primaryColor, width: 2) : null,
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
                    const Icon(Icons.credit_card_outlined, size: 30, color: Colors.redAccent),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text("Visa  •••• 5678", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                    ),
                    Radio(
                      value: 2, 
                      groupValue: _selectedMethod, 
                      onChanged: (v){ setState(() => _selectedMethod = v!); },
                      activeColor: primaryColor,
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Opcion 3: Efectivo
            GestureDetector(
              onTap: () => setState(() => _selectedMethod = 3),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: _selectedMethod == 3 ? Border.all(color: primaryColor, width: 2) : null,
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
                    const Icon(Icons.paypal, size: 30, color: Color.fromARGB(255, 32, 6, 223)),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text("Paypal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                    ),
                    Radio(
                      value: 3, 
                      groupValue: _selectedMethod, 
                      onChanged: (v){ setState(() => _selectedMethod = v!); },
                      activeColor: primaryColor,
                    )
                  ],
                ),
              ),
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
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pago realizado con éxito'),
                        backgroundColor: primaryColor,
                      )
                    );
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  elevation: 2
                ),
                child: const Text(
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
