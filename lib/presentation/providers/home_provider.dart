import 'package:flutter/material.dart';
import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/repositories/auth_repository.dart';
import 'package:marketplace/domain/entities/details.dart';

class HomeProvider extends ChangeNotifier{
  List productsToBuy = [];
  bool isLoading = false;
  String? errorMessage;

  ProductsRepository productsRepository;
  AuthRepository authRepository;

  HomeProvider({
      required this.productsRepository,
      required this.authRepository,
  });

  void clearAll(){
    notifyListeners();
  }
  
  Future<void> getProductsToBuy() async{
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try{
    productsToBuy = await productsRepository.getProductsToBuy();
    notifyListeners();
    } catch(e){
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logoutUser() async{
    await authRepository.logoutUser();
  }

  void getProductsToBuyTemporal(){
    productsToBuy= [
      Details(
        id: "1",
        name: "Xbox Series X",
        price: "499.99",
        imagePath: "https://i5-mx.walmartimages.com/samsmx/images/product-images/img_large/981028738l.jpg",
        seller: "Tienda",
      ),
      Details(
        id: "2",
        name: "Age Of Empires 2",
        price: "19.99",
        imagePath: "https://store-images.s-microsoft.com/image/apps.55056.13678235101671609.c350aa6a-23e2-407c-94fd-5050e9bedb6f.f8b5d931-11f6-46e3-859f-54981d5b9d1b",
        seller: "Tienda",
      ),
      Details(
        id: "3",
        name: "Ajedrez",
        price: "3.99",
        imagePath: "https://m.media-amazon.com/images/I/81dVfAv6npL._AC_UF894,1000_QL80_.jpg",
        seller: "Tienda",
      ),
      Details(
        id: "4",
        name: "Ajedrez",
        price: "3.99",
        imagePath: "https://m.media-amazon.com/images/I/71jlJZoeuiL.jpg",
        seller: "Tienda",
      ),
      Details(
        id: "5",
        name: "Laptop",
        price: "2000",
        imagePath: "https://m.media-amazon.com/images/I/61LdecwlWYL.jpg",
        seller: "Tienda",
      ),
      Details(
        id: "6",
        name: "Laptop pirata",
        price: "100",
        imagePath: "https://cdn.homedepot.com.mx/productos/223608/223608-d.jpg",
        seller: "Tienda",
      ),
      Details(
        id: "7",
        name: "Laptop",
        price: "12",
        imagePath: "https://cdn.homedepot.com.mx/productos/223608/223608-d.jpg",
        seller: "Tienda",
      ),
      Details(
        id: "8",
        name: "otra laptop",
        price: "12",
        imagePath: "https://www.cnet.com/a/img/resize/c96d367d070d264bc94b4e984cbd5e0aeb8af18a/hub/2025/03/10/d190e21d-9634-440d-8f33-396c8cb3da6a/m4-macbook-air-15-11.jpg?auto=webp&fit=crop&height=720&width=1280",
        seller: "Tienda",
      ),
      Details(
        id: "9",
        name: "laptop",
        price: "12",
        imagePath: "https://s3.us-east-2.amazonaws.com/ccp-prd-s3-uploads/2022/6/30/a751cb634fcf303a18782f156241b52c0d11822e.png",
        seller: "Tienda",
      ),
      Details(
        id: "10",
        name: "Laptop",
        price: "344",
        imagePath: "https://s3.us-east-2.amazonaws.com/ccp-prd-s3-uploads/2022/6/30/a751cb634fcf303a18782f156241b52c0d11822e.png",
        seller: "Tienda",
      ),
      Details(
        id: "11",
        name: "Laptop",
        price: "344",
        imagePath: "https://s3.us-east-2.amazonaws.com/ccp-prd-s3-uploads/2022/6/30/a751cb634fcf303a18782f156241b52c0d11822e.png",
        seller: "Tienda",
      ),
      Details(
        id: "12",
        name: "Laptop",
        price: "344",
        imagePath: "https://s3.us-east-2.amazonaws.com/ccp-prd-s3-uploads/2022/6/30/a751cb634fcf303a18782f156241b52c0d11822e.png",
        seller: "Tienda",
      ),
      Details(
        id: "13",
        name: "otra laptop mas",
        price: "23",
        imagePath: "https://s3.us-east-2.amazonaws.com/ccp-prd-s3-uploads/2022/6/30/a751cb634fcf303a18782f156241b52c0d11822e.png",
        seller: "Tienda",
      ),
      Details(
        id: "14",
        name: "Laptop",
        price: "30",
        imagePath: "https://http2.mlstatic.com/D_NQ_NP_699140-MLA83177821136_042025-B.webp",
        seller: "Tienda",
      ),
      Details(
        id: "15",
        name: "Laptop",
        price: "6700",
        imagePath: "https://media.gq.com.mx/photos/61e70ca25def32c5619cef06/16:9/w_1280,c_limit/Lenovo%20Yoga%20Slim%207%20Pro.jpg",
        seller: "Tienda",
      ),
    ];
  }
}

