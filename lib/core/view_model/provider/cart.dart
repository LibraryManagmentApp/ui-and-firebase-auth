import 'package:flutter/material.dart';

class cartitem {
  final String? id;
  final String? product_name;
  final int? quantity;
  final int? price;

  cartitem({
    required this.id,
    required this.product_name,
    required this.quantity,
    required this.price,
  });
}

class cart with ChangeNotifier {
  Map<String, cartitem> _items = {};

  Map<String, cartitem> get items {
    return {..._items};
  }


  int get itemcount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartitem) {
      total += cartitem.price! * cartitem.quantity!;
    });
    return total;
  }

  void addItem(String productid, double price, String title) {
    if (_items.containsKey(productid)) {
      _items.update(productid, (exisitingcartitem) =>
          cartitem(
              id: exisitingcartitem.id,
              product_name: exisitingcartitem.product_name,
              quantity: exisitingcartitem.quantity! + 1,
              price: exisitingcartitem.price
          ),
      );
    }
    else {
      _items.putIfAbsent(
        productid,
            () =>
            cartitem(
              id: DateTime.now().toString(),
              product_name: title,
              quantity: 1,
              price: price.toInt(),
            ),
      );
    }
    print('nnnn');
    notifyListeners();
  }

  void removItem(String productid) {
    _items.remove(productid);
    notifyListeners();
  }

  void removeSingleItem(String productid) {
    if (!_items.containsKey(productid)) {
      return;
    }
    if (_items[productid]!.quantity! > 1) {
      _items.update(
        productid,
            (exisitingcartitem) =>
            cartitem(
                id: exisitingcartitem.id,
                product_name: exisitingcartitem.product_name,
                quantity: exisitingcartitem.quantity! - 1,
                price: exisitingcartitem.price
            ),
      );
    } else {
      _items.remove(productid);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}