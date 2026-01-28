import 'package:flutter/material.dart';

class ProductInformationList extends StatelessWidget{
  final List<String> items = List<String>.generate(20, (i) => 'Item $i');
  
  ProductInformationList();

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(items[index]),
          leading: Icon(Icons.list),
          trailing: Icon(Icons.arrow_forward)
        );
      }
    );
  }
}
