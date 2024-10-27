import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/home/home_screen.dart';
import 'package:dealz/ui/stores/store_details_secreen.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            //  Navigator.pop(context);
          },
          icon: Image.asset(
            Assets.images.backArrow.path,
            height: 18,
          ),
        ),
        centerTitle: false,
        title: Text(
          'Electronics',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFieldWidget(
                type: TextFieldType.text,
                hint: "Search",
                suffixIcon: Image.asset(
                  Assets.images.search.path,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
                      child: DynamicHeightGridView(
                        itemCount: 40,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        physics: NeverScrollableScrollPhysics(),
                        builder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => StoreDetailsScreen(
                                    store: Stores(),
                                    homeType: HomeType.commercial,
                                  ),
                                ),
                              );
                            },
                            child: StoreItem(),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, int index) {
                        return Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: new Text(
                            String.fromCharCode(index + 65),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        );
                      },
                      itemCount: 26,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StoreItem extends StatelessWidget {
  const StoreItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 99,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Color(0x7fdadada),
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: -1)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0) + EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            new Container(
              height: 74,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(Assets.images.car.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            new Text(
              "Store Name",
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
