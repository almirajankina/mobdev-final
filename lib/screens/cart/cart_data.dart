List<Map<String, dynamic>> cartItems = [];

void addToCart(Map<String, dynamic> product) {
  cartItems.add(product);
}

List<Map<String, dynamic>> getCartItems() => cartItems;
