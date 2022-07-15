import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two2/ui/widgets/app_drawer.dart';
import '../../core/view_model/provider/order.dart' show order;
import '../widgets/order_item.dart';

class orderscreen extends StatelessWidget {
  static const routename = '/order';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appdrawer(),
      appBar: AppBar(
        title: Text("your order"),
        backgroundColor: Color.fromRGBO(153, 77, 0, 1),
      ),
      body: FutureBuilder(
        future: Provider.of<order>(context, listen: false).fetchandsetorder(),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(child: Text("an error occurred"));
            } else {
              return Consumer<order>(
                  builder: (ctx, orderdata, child) => ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        orderitem(orderdata.orders[index]),
                    itemCount: orderdata.orders.length,
                  ));
            }
          }
        },
      ),
      // drawer: appdrawer(),
    );
  }
}
