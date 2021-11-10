import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/product_grid.dart';

enum FilterOption {
  All,
  Favorites,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('All'), value: FilterOption.All),
              PopupMenuItem(
                  child: Text('Only Favorites'), value: FilterOption.Favorites),
            ],
            onSelected: (FilterOption selectedValue) {
              setState(
                () {
                  if (selectedValue == FilterOption.All) {
                    _showOnlyFavorites = false;
                  } else {
                    _showOnlyFavorites = true;
                  }
                },
              );
            },
          ),
          Consumer<Cart>(
            builder: (_, cartData, c) => Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
              value: cartData.itemCount.toString(),
              color: Colors.deepOrange,
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}
