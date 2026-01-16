const String addToCartMutation = r'''
mutation addToCart($product_id: ID!, $quantity: Int!) {
  addToCart(product_id: $product_id, quantity: $quantity) {
    id
    items {
      id
      quantity
      product {
        id
        name
        price
      }
    }
    subtotal
    shipping
    taxes
    total
  }
}
''';

const String myCartQuery = r'''
query carrito {
  myCart {
    id
    items {
      id
      product {
        id
        name
        price
      }
      quantity
    }
    subtotal
    taxes
    shipping
    total
  }
}
''';
