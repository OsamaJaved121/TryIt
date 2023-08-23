import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/items_widget.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
//import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        
        value: products[i],
        child: ItemsWidget(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
      //padding: const EdgeInsets.all(10.0),

        // ProductItem(
        // builder: (c) => products[i],
        //     // products[i].id,
        //     // products[i].title,
        //     // products[i].imageUrl,
        //     ),