const String createNewProduct = r'''
  mutation PublicarProducto($name: String!, $price: Float!, $image: Upload) {
  createProduct(name: $name, price: $price, image: $image) {
    id
    name
    price
    image_path
    created_at
  }
}
''';
