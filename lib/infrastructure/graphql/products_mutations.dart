const String createNewProduct = r'''
  mutation PublicarProducto($name: String!, $price: Float!,$stock: Float!, $image: Upload) {
  createProduct(name: $name, price: $price, image: $image) {
    id
    name
    price
    stock
    image
    created_at
  }
}
''';

const String productDetailsQuery = r'''
query DetallesProducto($id: ID!){
  viewProductsById(id: $id) {
    id
    name
    price
    image
    user{
      name
    }    
  }
}
''';
