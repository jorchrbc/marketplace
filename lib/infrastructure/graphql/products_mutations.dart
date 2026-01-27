const String createNewProduct = r'''
  mutation PublicarProducto($name: String!, $price: Float!, $image: Upload) {
  createProduct(name: $name, price: $price, image: $image) {
    id
    name
    price
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

const String getProductsToBuyQuery = r'''
query getProducts {
  allProducts(first: 10, page: 1) {
    paginatorInfo {
      count
      currentPage
      firstItem
      hasMorePages
      lastItem
      lastPage
      perPage
      total
    }
    data {
      id
      name
      price
      stock
      image
      created_at
      updated_at
      user_id
      user{
        name
      }
    }
  }
}
''';
