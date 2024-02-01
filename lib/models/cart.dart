import 'package:flutterdev/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem(this.pizza, [this.quantity = 1]);
}

class Cart {
  List<CartItem> _items = [];

  int totalItems() {
    return _items.length;
  }

  CartItem getCartItem(int index) {
    return _items[index];
  }

  void addProduct(Pizza pizza) {
    int index = findCartItemIndex(pizza.id);
    if (index == -1) {
      _items.add(CartItem(pizza));
    } else {
      CartItem item = _items[index];
      item.quantity++;
    }
  }

  void RemoveProduct(Pizza pizza) {
    int index = findCartItemIndex(pizza.id);
    if (index != -1) {
      CartItem item = _items[index];
      if(item.quantity > 1){
        item.quantity--;
      }
      else{
        _items.removeAt(index);
      }
    }
  }
  
  num getTotalPrice(){
    num total = 0;
    for(CartItem item in _items){
      total += item.pizza.total * item.quantity;
    }
    return total;
  }


  int findCartItemIndex(int id) {
    return _items.indexWhere((element) => element.pizza.id == id);
  }
}
