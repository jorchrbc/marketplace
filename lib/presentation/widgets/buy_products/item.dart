import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final void Function(String productId) goProductDetails;
  final void Function(String productId, int quantity) addProduct;
  final VoidCallback goCart;
  final String text;
  final String price;
  final String image;
  final String id;
  final int stock;

  const Item({
    super.key,
    required this.goProductDetails,
    required this.addProduct,
    required this.goCart,
    required this.text,
    required this.price,
    required this.image,
    required this.id,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goProductDetails(id);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                  return const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 48,
                      color: Colors.grey
                    )
                  );
                }
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            price,
                            style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    if(stock == 0)
                    Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: const Text(
                        'Agotado',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    )
                    else
                    FilledButton(
                      onPressed: () {
                        addProduct(id, 1);
                        goCart();
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(36, 36),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
