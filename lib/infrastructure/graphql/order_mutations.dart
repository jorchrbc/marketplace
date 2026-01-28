const String createOrderMutation = r'''
mutation newOrder($address: String!, $payment_method: PaymentMethod!, $items: [OrderItemInput!]!) {
  newOrder(
    address: $address
    payment_method: $payment_method
    items: $items
  ) {
    id
    user {
      id
      name
      email
    }
    address
    status
    payment_method
    sub_total
    tax
    shipping
    total
    created_at
    items {
      id
      quantity
      price
      product {
        id
        name
      }
    }
  }
}
''';

const String getOrderDetailsQuery = r'''
query OrderById($id: ID!)
{
  orderById(id: $id) {
    user {
      id
      name
      email
      number
    }
    address
    status
    payment_method
    sub_total
    tax
    shipping
    total
    items {
      product{
        name
      }
      quantity
      price
    }
  }
}
''';
