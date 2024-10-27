import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/ui/products/product_detials_screen.dart';
import 'package:dealz/ui/products/product_item.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final List<HomeProduct> product;

  const ProductList({super.key, required this.product});

  @override
  State<ProductList> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 212,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final HomeProduct product = widget.product[index];
          return Padding(
            padding: EdgeInsetsDirectional.only(start: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsScreen(
                      product: product,
                    ),
                  ),
                );
              },
              child: ProductItem(
                product: product,
              ),
            ),
          );
        },
        itemCount: widget.product.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
