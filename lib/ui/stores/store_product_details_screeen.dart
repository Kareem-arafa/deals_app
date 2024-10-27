import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealz/data/models/store_product_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/image_viewer.dart';
import 'package:dealz/ui/stores/update_store_product_screen.dart';
import 'package:flutter/material.dart';

class MyStoreProductDetailsScreen extends StatefulWidget {
  final StoreProductModel product;
  final int storeId;

  MyStoreProductDetailsScreen({super.key, required this.product, required this.storeId});

  @override
  State<MyStoreProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<MyStoreProductDetailsScreen> {
  int _current = 0;
  double rate = 0;

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          widget.product.title ?? "",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            Assets.images.backArrow.path,
            height: 18,
            matchTextDirection: true,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
            child: Image.asset(
              Assets.images.shareIcon.path,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateStoreProductScreen(
                    storeId: widget.storeId,
                    productModel: widget.product,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                Assets.images.editIcon.path,
                height: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewer(imageUrl: widget.product.images?[_current].image ?? ""),
                    ),
                  );
                },
                child: CarouselSlider(
                  items: _buildImages(widget.product.images ?? []),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                widget.product.title ?? "",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              widget.product.price == null
                  ? SizedBox()
                  : Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.product.price?.toString() ?? "0.0",
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    color: Color(0xff000000),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    decoration:
                                        ((widget.product.discount ?? 0) > 0) ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                TextSpan(
                                  text: " KWD",
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    color: Color(0xff000000),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    decoration:
                                        ((widget.product.discount ?? 0) > 0) ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          if ((widget.product.discount ?? 0) > 0)
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.product.priceAfterDiscount?.toString() ?? "0.0",
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " KWD",
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 25,
              ),
              Text(
                Translations.of(context).text("storeDetailsScreenDescriptionLabel"),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.product.description ?? "",
                style: TextStyle(
                  color: Color(0xff858585),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildImages(List<ImageModel> images) {
    List<Widget> services = images
        .map(
          (e) => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(e.image ?? ""),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
        .toList();
    return services;
  }
}
