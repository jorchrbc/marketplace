import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  final String? status;
  final String? address;
  final String? payment_method;
  final double? sub_total;
  final double? shipping;
  final double? tax;
  final double? total;

  const InformationCard({
    super.key,
    required this.status,
    required this.address,
    required this.payment_method,
    required this.sub_total,
    required this.shipping,
    required this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estado del pedido',
              style: TextStyle(fontSize: 16),
            ),
            Text(status ?? 'Desconocido'),
            const SizedBox(height: 16),

            const Text(
              'Dirección de envío',
              style: TextStyle(fontSize: 16),
            ),
            Text(address ?? 'Desconocido'),
            const SizedBox(height: 16),

            const Text(
              'Método de pago',
              style: TextStyle(fontSize: 16),
            ),
            Text(payment_method ?? 'Desconocido'),
            const SizedBox(height: 16),

            const Text(
              'Costos',
              style: TextStyle(fontSize: 16),
            ),

            Column(
              children: [
                _costRow('Subtotal', sub_total),
                _costRow('Envío', shipping),
                _costRow('Impuestos', tax),
                _costRow('Total', total),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _costRow(String label, double? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label)
          ),
          Text(
            value != null
                ? '\$${value.toStringAsFixed(2)}'
                : 'Desconocido',
          ),
        ],
      ),
    );
  }
}
