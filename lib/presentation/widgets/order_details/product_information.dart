import 'package:flutter/material.dart';

class ProductInformation extends StatelessWidget{
  final String name;
  final double price;
  final int quantity;
  const ProductInformation({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
  });

  Widget build(BuildContext context){
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                    )
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                    )
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Cantidad: ',
                        style: TextStyle(
                          fontSize: 14,
                        )
                      ),
                      Text(
                        '${quantity}',
                        style: TextStyle(
                          fontSize: 14,
                        )
                      ),
                    ]
                  )
                ]
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: SizedBox(
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/679/679821.png',
                    fit: BoxFit.cover
                  )
                )
              )
            )
          ]
        )
      ),
    );
  }
}
