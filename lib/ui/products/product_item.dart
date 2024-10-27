import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/translate/translations.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final HomeProduct product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Color(0x7fdadada),
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                width: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(product.image ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                Translations.of(context).currentLanguage == "ar" ? product.arabicName ?? "" : product.englishName ?? "",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  product.price == null
                      ? SizedBox(
                          height: 16,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  product.price?.toString() ?? "0.0",
                                  style: TextStyle(
                                    color:
                                        ((product.discount ?? 0) > 0) ? Colors.black : Theme.of(context).primaryColor,
                                    fontSize: 11,
                                    decoration: ((product.discount ?? 0) > 0) ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "KWD",
                                  style: TextStyle(
                                    color:
                                        ((product.discount ?? 0) > 0) ? Colors.black : Theme.of(context).primaryColor,
                                    fontSize: 11,
                                    decoration: ((product.discount ?? 0) > 0) ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                              ],
                            ),
                            if ((product.discount ?? 0) > 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    product.priceAfterDiscount?.toString() ?? "0.0",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "KWD",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x7fdadada),
                          offset: Offset(0, 5),
                          blurRadius: 10,
                          spreadRadius: -1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
