import 'package:flutter/material.dart';

import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/entities/details.dart';

class ProductDetailsProvider extends ChangeNotifier{
  String name = '';
  String price = '';
  String seller = '';
  String description = "The first title in the series, Age of Empires, focused on events in Europe, Africa and Asia, spanning from the Stone Age to the Iron Age; the expansion game explored the formation and expansion of the Roman Empire. The sequel, Age of Empires II: The Age of Kings, was set in the Middle Ages, while its expansion focused partially on the Spanish conquest of the Aztec Empire.";
  Image? image;
  List<Widget> image_cards = [];

  bool isLoading = false;
  String? errorMessage;
  
  ProductsRepository productsRepository;

  ProductDetailsProvider({required this.productsRepository});

  void clearAll(){
    name = '';
    price = '';
    seller = '';
    image_cards.clear();
    image = null;
    errorMessage = null;
    isLoading = false;
    notifyListeners();
  }
  
  Future<void> getProductDetails(String id) async{
    print('primer flag');
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try{
      print('segundo flag');
      Details details = await productsRepository.productDetails(id);
      print('tercer flag');
      name = details.name;
      price = details.price.toString();
      seller = "Vendedor: ${details.seller}";
      
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
