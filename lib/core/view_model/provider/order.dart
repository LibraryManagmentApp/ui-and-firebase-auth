import 'dart:convert';
import '../provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class orderItem {
  final String id;
  final double amount;
  final List<cartitem> products;
  final DateTime dateTime;

  orderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime
  });
}
class order with ChangeNotifier{
  List<orderItem> _orders=[];
  late String authtoken;
  late String userid;


  getdata(String? authtok, String? uid, List<orderItem>?orders) {
    authtoken = authtok!;
    userid = uid!;
    _orders=orders!;
    notifyListeners();
  }
  List<orderItem>get orders{
    return[..._orders];
  }

  Future <void> fetchandsetorder()async {
    final url = 'https://almorjan-cd066-default-rtdb.firebaseio.com/orders/$userid.json?auth=$authtoken';
    try {
      final res = await http.get(Uri.parse(url));
      final extractdata = json.decode(res.body) as Map<String, dynamic>;
      if (extractdata == null) {
        return;
      }
      final List<orderItem>loadedorder = [];
      extractdata.forEach((orderid, orderdata) {
        loadedorder.add(
          orderItem(
            id: orderid,
            amount: orderdata['amount'],
            dateTime: DateTime.parse(orderdata['datetime']),
            products: (orderdata['products'] as List<dynamic>)
                .map((item) =>
                cartitem(
                  id: item['id'],
                  product_name: item['title'],
                  quantity: item['quantity'],
                  price: item['price'],
                )).toList(),
          ),
        );
      });
      _orders = loadedorder.reversed.toList();
      notifyListeners();
    }
    catch (e) {
      throw e;
    }
  }
  Future <void> addOrder(List<cartitem>cartproduct,double total) async {
    final url = 'https://almorjan-cd066-default-rtdb.firebaseio.com/orders/$userid.json?auth=$authtoken';
    try {
      final timestamp=DateTime.now();
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'amount':total,
            'datetime':timestamp.toIso8601String(),
            'products':cartproduct
                .map((cp) => {
              'id':cp.id,
              'title':cp.product_name,
              'quantity':cp.quantity,
              'price':cp.price,
            }).toList(),
          }));
      _orders.insert(0, orderItem(
        id:json.decode(res.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartproduct,
      )
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}