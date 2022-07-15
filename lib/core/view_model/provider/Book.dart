import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Book with ChangeNotifier{
  final String id;
  final String imageUrl;
  final String name;
  final String category;
  final double price;
  final String description;
  final int  quantity;
  bool isfavorite;
  
  Book({
    required this.id,
    required this.quantity,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.name, 
    required this.price,
    this.isfavorite=false,
  });

  void _setfavvalue(bool newvalue){
    isfavorite=newvalue;
    notifyListeners();
  }
//تابع يقوم بتحويل العنصر من مفضل لغير مفضل والعكس
  Future<void> togglefavoritestate(String token,String userid)async{
    final oldstate= isfavorite;
    isfavorite=!isfavorite;
    notifyListeners();

    final url='https://almorjan-cd066-default-rtdb.firebaseio.com/userfavorites/$userid/$id.json?auth=$token';
    try{
      final res=await http.put(Uri.parse(url), body: json.encode(isfavorite));
      if(res.statusCode>=400)
      {
        _setfavvalue(oldstate);
      }
    }catch(e){
      _setfavvalue(oldstate);
    }
  }
}