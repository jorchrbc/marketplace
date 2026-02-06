import 'package:flutter/material.dart';

import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/entities/details.dart';

class ProductDetailsProvider extends ChangeNotifier{
  bool _disposed = false;
  String name = '';
  String price = '';
  String seller = '';
  String description = "";
  Image? image;
  List<Widget> image_cards = [];

  bool isLoading = false;
  String? errorMessage;
  
  ProductsRepository productsRepository;

  ProductDetailsProvider({required this.productsRepository});

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
  
  void clearAll(){
    name = '';
    price = '';
    seller = '';
    description = '';
    image_cards.clear();
    image = null;
    errorMessage = null;
    isLoading = false;
    if (!_disposed) {
      notifyListeners(); // Solo notifica si el provider sigue activo
    }

  }
  
  Future<void> getProductDetails(String id) async{
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try{
      Details details = await productsRepository.productDetails(id);
      name = details.name;
      price = details.price.toString();
      seller = "Vendedor: ${details.seller}";
      description = details.description;
      image = Image.network(
        details.imagePath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace){
          return Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdpU431xPGZoWC2RW7DAlWe29mnpo2z5m13Q&s",
            fit: BoxFit.cover
          );
        }
      );
      image_cards.add(
        Card(
          child: SizedBox(
            width: double.infinity,
            height: 300,
            child: image
          )
        )
      );
    } catch(e){
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
