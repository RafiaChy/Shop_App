import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem({
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ListTile(
            leading: CircleAvatar(
              radius: 50,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: FittedBox(
                  child: Text(
                    '\$$price',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            title: Text(
              '$title',
              style: TextStyle(fontSize: 15),
            ),
            subtitle: Text(
              'Total: \$${price * quantity}',
              style: TextStyle(fontSize: 15),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '$quantity x',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
