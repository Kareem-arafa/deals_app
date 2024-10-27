import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/cart/addresses/add_new_address_screen.dart';
import 'package:dealz/ui/cart/addresses/address_item.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AddressesScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _AddressesScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _AddressesScreenContent({required this.viewModel});

  @override
  State<_AddressesScreenContent> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<_AddressesScreenContent> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    widget.viewModel.getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddNewAddress(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: new Text(
                    Translations.of(context).text("MyAddressesScreenAddTitle"),
                    style: TextStyle(
                      color: Color(0xff242424),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: widget.viewModel.getAddressesReport.status == ActionStatus.running
          ? Center(
              child: CupertinoActivityIndicator(
                animating: true, // Control animation
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      Translations.of(context).text("MyAddressesScreenTitle"),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.viewModel.addresses.length,
                      itemBuilder: (_, int index) {
                        return AddressItem(
                          isSelected: index == 0,
                          address: widget.viewModel.addresses[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => SizedBox(
                        height: 15,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
