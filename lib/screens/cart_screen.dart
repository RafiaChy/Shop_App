import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final yourCart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${yourCart.cartTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        yourCart.items.values.toList(),
                        yourCart.cartTotal,
                      );
                      yourCart.clear();
                    },
                    child: Text('ORDER NOW'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => CartItem(
                  id: yourCart.items.values.toList()[index].id,
                  productId: yourCart.items.keys.toList()[index],
                  title: yourCart.items.values.toList()[index].title,
                  quantity: yourCart.items.values.toList()[index].quantity,
                  price: yourCart.items.values.toList()[index].price),
              itemCount: yourCart.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
