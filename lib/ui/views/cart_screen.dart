import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/view_model/provider/cart.dart';
import '../../core/view_model/provider/order.dart';
import '../widgets/cart_item.dart' show CartItem;

class cartScreen extends StatelessWidget {

  static const routeName = '/cartScreen';
  
  @override
  Widget build(BuildContext context) {
    final card = Provider.of<cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
          backgroundColor: Color.fromRGBO(153, 77, 0, 1),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(), //المساحة الممكنة
                    Chip(
                      label: Text(
                        '\$${card.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6!
                                .color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    Orderbutton(cartt: card),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: card.items.length,
                itemBuilder: ( ctx, int index) => CartItem(
                  card.items.values.toList()[index].id,
                  card.items.keys.toList()[index],
                  card.items.values.toList()[index].price,
                  card.items.values.toList()[index].quantity,
                  card.items.values.toList()[index].product_name,

                ),
              ),
            ),
          ],
        )
    );
  }
}

class Orderbutton extends StatefulWidget {
  final cart cartt;

  const Orderbutton({ required this.cartt}) ;

  @override
  _OrderbuttonState createState() => _OrderbuttonState();
}

class _OrderbuttonState extends State<Orderbutton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cartt.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
        setState(() {
          _isLoading = true;
        });

        await Provider.of<order>(context, listen: false)
            .addOrder(widget.cartt.items.values.toList(), widget.cartt.totalAmount);
        setState(() {
          _isLoading = false;
        });
        widget.cartt.clear();
      },
      textColor: Theme.of(context).primaryColor,
    );
  }
}