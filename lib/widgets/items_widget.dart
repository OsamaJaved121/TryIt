import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
import '../screens/item_page.dart';

import '../providers/product.dart';
import '../providers/auth.dart';

class ItemsWidget extends StatelessWidget {
  static const routeName = '/items-widget';
  ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return
        //shrinkWrap: true,
        Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF4C53A5),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Text(
                  "-50%",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Consumer<Product>(
                builder: (ctx, product, _) => IconButton(
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: Colors.red,
                  onPressed: () {
                    product.toggleFavoriteStatus(authData.token,authData.userId);
                  },
                ),
              ),
            ],
          ),
          InkWell(
            onTap: (() {
              Navigator.of(context).pushNamed(
                ItemPageScreen.routeName,
                arguments: product.id,
              );
            }),
            child: Container(
              child: Image.network(
                product.imageUrl,
                //fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 5, top: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              product.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Color(0xFF4C53A5),
                  ),
                  onPressed: () {
                    cart.addItem(product.id, product.price, product.title,
                        product.imageUrl);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Added item to cart!',
                        ),
                        backgroundColor: Color(0xFF4C53A5),
                        shape: StadiumBorder(),
                        elevation: 2,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            cart.removeSingleItem(product.id);
                          },
                        ),
                      ),
                    );
                  },
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
