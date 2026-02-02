const String createNewProduct = r'''
  mutation PublicarProducto($name: String!, $price: Float!, $stock: Int!, $image: Upload, $description: String) {
  createProduct(
    name: $name
    price: $price
    stock: $stock
    image: $image
    description: $description
  ) {
    id
    name
    price
    stock
    image
    description
    created_at
    updated_at
    user_id
    user {
      id
      name
      email
      number
    }
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


const String myProductsQuery = r'''
query MisProductos{
  myProducts {
    id
    name
    price
    stock
    image
  }
}
''';
  
const String getProductsToBuyQuery = r'''
query getProducts($page: Int!) {
  allProducts(first: 10, page: $page) {
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

const String deleteProductMutation = r'''
mutation DeleteProduct($id: ID!) {
  deleteProduct(id: $id) {
    id
    name
  }
}
''';
