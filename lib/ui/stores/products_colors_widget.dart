import 'package:dealz/data/models/color_model.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ColorVariantPage extends StatelessWidget {
  const ColorVariantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _ColorVariantPageContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _ColorVariantPageContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _ColorVariantPageContent({super.key, required this.viewModel});

  @override
  _ColorVariantPageState createState() => _ColorVariantPageState();
}

class _ColorVariantPageState extends State<_ColorVariantPageContent> {
  int? selectedIndex;

  @override
  void initState() {
    widget.viewModel.getColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.viewModel.getColorsReport.status == ActionStatus.running
        ? Center(
            child: CupertinoActivityIndicator(
              animating: true, // Control animation
              color: Theme.of(context).primaryColor,
            ),
          )
        : Column(
            children: [
              Container(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.viewModel.colors.length,
                  itemBuilder: (context, index) {
                    final ColorModel color = widget.viewModel.colors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: color.getColorFromHex,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: selectedIndex == index ? Colors.white : Colors.transparent,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 8,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          );
  }
}
