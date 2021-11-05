import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({required this.id, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final myProduct = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context,
        listen:
            false); // false because not the entire widget is interested in changes occur in a product.
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: myProduct.id);
          },
          child: Image.network(
            myProduct.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            //Consumer is used because only subpart of the widget tree need rebuild
            builder: (context, product, child) => IconButton(
                icon: Icon(
                  (myProduct.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: Colors.deepOrange,
                ),
                onPressed: () {
                  myProduct.toggleFavoriteStatus();
                }),
          ),
          title: Text(
            myProduct.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cart.addItem(myProduct.id, myProduct.price, myProduct.title);
            },
          ),
        ),
      ),
    );
  }
}
