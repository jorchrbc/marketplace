import 'package:flutter/material.dart';
import 'package:marketplace/presentation/widgets/order_details/order_details_widgets.dart';
import 'package:marketplace/presentation/providers/order_details_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget{
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>{

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
        context.read<OrderDetailsProvider>().getOrderDetails('3');
    });
  }
  @override
  Widget build(BuildContext context){
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);

    if(orderDetailsProvider.isLoading){
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if(orderDetailsProvider.errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Text(orderDetailsProvider.errorMessage!)
        )
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles del pedido',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Información del pedido',
                        style: TextStyle(
                          fontSize: 18.0
                        )
                      ),
                    ),
                    InformationCard(
                      status: orderDetailsProvider.status,
                      address: orderDetailsProvider.address,
                      payment_method: orderDetailsProvider.payment_method,
                      sub_total: orderDetailsProvider.sub_total,
                      shipping: orderDetailsProvider.shipping,
                      tax: orderDetailsProvider.tax,
                      total: orderDetailsProvider.total,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 36.0),
                      child: Text(
                        'Productos',
                        style: TextStyle(
                          fontSize: 18.0
                        )
                      ),
                    ),
                  ]
                )
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index){
                  return ProductInformation(
                    name: orderDetailsProvider.products![index]['product']['name'] ?? 'Desconocido',
                    price: orderDetailsProvider.products![index]['price'].toDouble() ?? 0.0,
                    quantity: orderDetailsProvider.products![index]['quantity'] ?? 0,
                  );
                },
                childCount: orderDetailsProvider.products?.length ?? 0
              )
            )
          ]
        )
      )
    );
  }
}
