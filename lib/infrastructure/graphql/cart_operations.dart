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

const String removeFromCartMutation = r'''
mutation Delete($cart_item_id: ID!) {
  removeFromCart(cart_item_id: $cart_item_id) {
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
    taxes
    shipping
    total
  }
}
''';

const String updateCartItemMutation = r'''
mutation Update($cart_item_id: ID!, $quantity: Int!) {
  updateCartItem(
    cart_item_id: $cart_item_id
    quantity: $quantity
  ) {
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
    taxes
    shipping
    total
  }
}
''';
