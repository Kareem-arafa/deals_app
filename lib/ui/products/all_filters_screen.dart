import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/data/models/attributes_models.dart';
import 'package:dealz/data/models/category_model.dart';
import 'package:dealz/data/models/city_model.dart';
import 'package:dealz/data/models/filter_and_sort_model.dart';
import 'package:dealz/data/models/state_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/auth/login_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AllFiltersScreen extends StatelessWidget {
  final int sectionId;

  const AllFiltersScreen({super.key, required this.sectionId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AllFiltersScreenContent(
        viewModel: viewModel,
        sectionId: sectionId,
      ),
    );
  }
}

class _AllFiltersScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final int sectionId;

  const _AllFiltersScreenContent({required this.viewModel, required this.sectionId});

  @override
  State<_AllFiltersScreenContent> createState() => _AllFiltersScreenState();
}

class _AllFiltersScreenState extends State<_AllFiltersScreenContent> {
  Map<int, AttributeFilterData> attributes = {};
  StateModel? selectedState;
  CityModel? selectedCity;

  CategoryModel? selectedCategory;
  num? lowPrice;
  num? highPrice;

  @override
  void initState() {
    this.widget.viewModel.getStates();
    this.widget.viewModel.getSectionAttributes(widget.sectionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.grey[100],
        elevation: 0,
        title: Text(
          Translations.of(context).text("allFiltersLabel"),
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
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
          InkWell(
            onTap: () {
              this.widget.viewModel.syncSortFilterData(SortAndFilterModel());
              this.widget.viewModel.getAdsBySection(this.widget.sectionId);
              Navigator.pop(context);
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16) + EdgeInsets.only(top: 8),
                child: Text(
                  Translations.of(context).text("resetLabel"),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
      body: widget.viewModel.getSectionAttributesReport.status == ActionStatus.running
          ? Center(
              child: CupertinoActivityIndicator(
                animating: true, // Control animation
                color: Theme.of(context).primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      itemCount: this.widget.viewModel.sectionAttributes.length,
                      itemBuilder: (context, index) {
                        final SectionAttributesModel sectionAttributes = this.widget.viewModel.sectionAttributes[index];
                        if (sectionAttributes.type == "dropdown") {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      sectionAttributes.name ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomDropdownButton(
                                    items: sectionAttributes.options,
                                    hint: sectionAttributes.name ?? "",
                                    value: null,
                                    onChange: (value) {
                                      AttributeFilterData? attribute = attributes[sectionAttributes.id!];
                                      if (attribute == null) {
                                        final AttributeFilterData newAttribute = AttributeFilterData(
                                          attributeValue: [value],
                                          attributeValueId: [value.id!],
                                          attributeId: sectionAttributes.id!,
                                          hasRange: false,
                                        );
                                        attributes[sectionAttributes.id!] = newAttribute;
                                      } else {
                                        if (attribute.attributeValue.contains(value)) {
                                          attribute.attributeValue.remove(value);
                                          attribute.attributeValueId.remove(value.id!);
                                        } else {
                                          attribute.attributeValue.add(value);
                                          attribute.attributeValueId.add(value.id!);
                                        }

                                        attributes.update(
                                          sectionAttributes.id!,
                                          (value) => attribute,
                                          ifAbsent: () => attribute,
                                        );
                                        print(attributes[sectionAttributes.id!]?.attributeValueId);
                                      }
                                      setState(() {});
                                    },
                                    borderColor: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  if (attributes[sectionAttributes.id!]?.attributeValue.isNotEmpty ?? false)
                                    Container(
                                      height: 40,
                                      child: ListView.builder(
                                          itemCount: attributes[sectionAttributes.id!]?.attributeValue.length ?? 0,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(40),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: new Text(
                                                      attributes[sectionAttributes.id!]
                                                          ?.attributeValue[index]
                                                          .name(Translations.of(context).currentLanguage),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                ],
                              ),
                            ),
                          );
                        } else if (sectionAttributes.type == "text") {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      sectionAttributes.name ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  (sectionAttributes.hasRange ?? false)
                                      ? RangeSliderWidget(
                                          hint: sectionAttributes.name ?? "",
                                          onFirstChange: (first) {
                                            final low = num.parse(first);
                                            AttributeFilterData? oldAttribute = attributes[sectionAttributes.id!];
                                            if (oldAttribute == null) {
                                              final AttributeFilterData newAttribute = AttributeFilterData(
                                                attributeValue: [],
                                                attributeValueId: [],
                                                attributeId: sectionAttributes.id!,
                                                hasRange: true,
                                                attributeValueLow: low.round(),
                                              );
                                              attributes[sectionAttributes.id!] = newAttribute;
                                            } else {
                                              oldAttribute.attributeValueLow = low.round();
                                              attributes[sectionAttributes.id!] = oldAttribute;
                                            }
                                          },
                                          onEndChange: (end) {
                                            final high = num.parse(end);
                                            AttributeFilterData? oldAttribute = attributes[sectionAttributes.id!];
                                            if (oldAttribute == null) {
                                              final AttributeFilterData newAttribute = AttributeFilterData(
                                                attributeValue: [],
                                                attributeValueId: [],
                                                attributeId: sectionAttributes.id!,
                                                hasRange: true,
                                                attributeValueHigh: high.round(),
                                              );
                                              attributes[sectionAttributes.id!] = newAttribute;
                                            } else {
                                              oldAttribute.attributeValueHigh = high.round();
                                              attributes[sectionAttributes.id!] = oldAttribute;
                                            }
                                          },
                                        )
                                      : TextFieldWidget(
                                          type: TextFieldType.text,
                                          hint: sectionAttributes.name ?? "",
                                          suffixIcon: Align(
                                            widthFactor: 0.125,
                                            alignment: AlignmentDirectional.centerEnd,
                                            child: Text(sectionAttributes.unit ?? ""),
                                          ),
                                          onChanged: (text) {
                                            final AttributeFilterData newAttribute = AttributeFilterData(
                                              attributeValue: [text],
                                              attributeValueId: [text],
                                              attributeId: sectionAttributes.id!,
                                              hasRange: false,
                                            );
                                            attributes[sectionAttributes.id!] = newAttribute;

                                            return text;
                                          },
                                          maxLines: 1,
                                          borderColor: Colors.grey,
                                        ),
                                ],
                              ),
                            ),
                          );
                        } else if (sectionAttributes.type == "number") {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      sectionAttributes.name ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  (sectionAttributes.hasRange ?? false)
                                      ? RangeSliderWidget(
                                          hint: sectionAttributes.name ?? "",
                                          onFirstChange: (first) {
                                            final low = num.parse(first);
                                            AttributeFilterData? oldAttribute = attributes[sectionAttributes.id!];
                                            if (oldAttribute == null) {
                                              final AttributeFilterData newAttribute = AttributeFilterData(
                                                attributeValue: [],
                                                attributeValueId: [],
                                                attributeId: sectionAttributes.id!,
                                                hasRange: true,
                                                attributeValueLow: low.round(),
                                              );
                                              attributes[sectionAttributes.id!] = newAttribute;
                                            } else {
                                              oldAttribute.attributeValueLow = low.round();
                                              attributes[sectionAttributes.id!] = oldAttribute;
                                            }
                                          },
                                          onEndChange: (end) {
                                            final high = num.parse(end);
                                            AttributeFilterData? oldAttribute = attributes[sectionAttributes.id!];
                                            if (oldAttribute == null) {
                                              final AttributeFilterData newAttribute = AttributeFilterData(
                                                attributeValue: [],
                                                attributeValueId: [],
                                                attributeId: sectionAttributes.id!,
                                                hasRange: true,
                                                attributeValueHigh: high.round(),
                                              );
                                              attributes[sectionAttributes.id!] = newAttribute;
                                            } else {
                                              oldAttribute.attributeValueHigh = high.round();
                                              attributes[sectionAttributes.id!] = oldAttribute;
                                            }
                                          },
                                        )
                                      : TextFieldWidget(
                                          type: TextFieldType.text,
                                          hint: sectionAttributes.name ?? "",
                                          suffixIcon: Align(
                                            widthFactor: 0.125,
                                            alignment: AlignmentDirectional.centerEnd,
                                            child: Text(sectionAttributes.unit ?? ""),
                                          ),
                                          onChanged: (text) {
                                            final AttributeFilterData newAttribute = AttributeFilterData(
                                              attributeValue: [text],
                                              attributeValueId: [text],
                                              attributeId: sectionAttributes.id!,
                                              hasRange: false,
                                            );
                                            attributes[sectionAttributes.id!] = newAttribute;
                                            setState(() {});
                                            return text;
                                          },
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          borderColor: Colors.grey,
                                        ),
                                ],
                              ),
                            ),
                          );
                        } else if (sectionAttributes.type == "checkbox") {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      sectionAttributes.name ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CheckBoxWidget(
                                    options: sectionAttributes.options ?? [],
                                    onChanged: (value) {
                                      AttributeFilterData? attribute = attributes[sectionAttributes.id!];
                                      if (attribute == null) {
                                        final AttributeFilterData newAttribute = AttributeFilterData(
                                          attributeValue: [value],
                                          attributeValueId: [value.id!],
                                          attributeId: sectionAttributes.id!,
                                          hasRange: false,
                                        );
                                        attributes[sectionAttributes.id!] = newAttribute;
                                      } else {
                                        if (attribute.attributeValue.contains(value)) {
                                          attribute.attributeValue.remove(value);
                                          attribute.attributeValueId.remove(value.id!);
                                        } else {
                                          attribute.attributeValue.add(value);
                                          attribute.attributeValueId.add(value.id!);
                                        }

                                        attributes.update(
                                          sectionAttributes.id!,
                                          (value) => attribute,
                                          ifAbsent: () => attribute,
                                        );
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (sectionAttributes.type == "radio") {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      sectionAttributes.name ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RadioWidget(options: sectionAttributes.options ?? []),
                                ],
                              ),
                            ),
                          );
                        } else if (sectionAttributes.type == "list") {
                          return ListWidget(
                            title: sectionAttributes.name ?? "",
                            options: sectionAttributes.options ?? [],
                            onChange: (options) {
                              final AttributeFilterData newAttribute = AttributeFilterData(
                                attributeValue: options,
                                attributeValueId: options.map((e) => e.id!).toList(),
                                attributeId: sectionAttributes.id!,
                                hasRange: false,
                              );
                              attributes.update(sectionAttributes.id!, (value) => newAttribute,
                                  ifAbsent: () => newAttribute);
                              setState(() {});
                            },
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 25,
                        );
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                Translations.of(context).text("CreateAdsPriceTitle"),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            RangeSliderWidget(
                              hint: Translations.of(context).text("CreateAdsPriceTitle"),
                              onEndChange: (end) {
                                num price = num.parse(end);
                                highPrice = price;
                                setState(() {});
                              },
                              onFirstChange: (first) {
                                num price = num.parse(first);
                                lowPrice = price;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                Translations.of(context).text("createStoreCategoryTitle"),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomDropdownButton(
                              items: widget.viewModel.sectionCategories,
                              hint: Translations.of(context).text("createStoreCategoryTitle"),
                              value: selectedCategory,
                              onChange: (value) {
                                selectedCategory = value;
                                setState(() {});
                              },
                              borderColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: new Text(
                                Translations.of(context).text("CreateAdsChooseStateTitle"),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomDropdownButton(
                              items: this.widget.viewModel.states,
                              hint: Translations.of(context).text("CreateAdsChooseStateTitle"),
                              value: selectedState,
                              onChange: (value) {
                                this.widget.viewModel.getCities(value.id);
                                selectedState = value;
                                selectedCity = null;
                                setState(() {});
                              },
                              borderColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: new Text(
                                Translations.of(context).text("CreateAdsChooseCityTitle"),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomDropdownButton(
                              items: this.widget.viewModel.cities,
                              hint: Translations.of(context).text("CreateAdsChooseCityTitle"),
                              value: selectedCity,
                              onChange: (value) {
                                selectedCity = value;
                                setState(() {});
                              },
                              borderColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ButtonWidget(
                      type: ButtonType.primary,
                      title: Translations.of(context).text("applyLabel"),
                      onTap: () {
                        final SortAndFilterModel? filterData = widget.viewModel.sortAndFilterModel?.copyWith();
                        SortAndFilterModel newFilterData;
                        if (filterData == null) {
                          newFilterData = SortAndFilterModel(
                            categoryId: selectedCategory?.id,
                            cityId: selectedCity?.id,
                            lowPrice: lowPrice?.toInt(),
                            highPrice: highPrice?.toInt(),
                            attributeFilter: attributes.values.toList(),
                          );
                        } else {
                          newFilterData = filterData.copyWith(
                            categoryId: selectedCategory?.id,
                            cityId: selectedCity?.id,
                            lowPrice: lowPrice?.toInt(),
                            highPrice: highPrice?.toInt(),
                            attributeFilter: attributes.values.toList(),
                          );
                        }
                        this.widget.viewModel.syncSortFilterData(newFilterData);
                        this.widget.viewModel.getAdsBySection(this.widget.sectionId);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class RangeSliderWidget extends StatefulWidget {
  final String hint;
  final Function(String) onFirstChange;
  final Function(String) onEndChange;

  const RangeSliderWidget({super.key, required this.onFirstChange, required this.onEndChange, required this.hint});

  @override
  State<RangeSliderWidget> createState() => _RangeSliderState();
}

class _RangeSliderState extends State<RangeSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldWidget(
            type: TextFieldType.text,
            hint: widget.hint,
            suffixIcon: Align(
              widthFactor: 0.125,
              alignment: AlignmentDirectional.centerEnd,
              child: Text(""),
            ),
            onChanged: (text) {
              widget.onFirstChange(text ?? "0");
              return text;
            },
            maxLines: 1,
            keyboardType: TextInputType.number,
            borderColor: Colors.grey,
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: TextFieldWidget(
            type: TextFieldType.text,
            hint: widget.hint,
            suffixIcon: Align(
              widthFactor: 0.125,
              alignment: AlignmentDirectional.centerEnd,
              child: Text(""),
            ),
            onChanged: (text) {
              widget.onEndChange(text ?? "0");
              return text;
            },
            maxLines: 1,
            keyboardType: TextInputType.number,
            borderColor: Colors.grey,
          ),
        )
      ],
    );
  }
}

class CheckBoxWidget extends StatefulWidget {
  final List<Options> options;
  final Function(Options) onChanged;

  const CheckBoxWidget({super.key, required this.options, required this.onChanged});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  final List<Options> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List<Widget>.generate(widget.options.length, (int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: FilterChip(
              label: Text(widget.options[index].optionName ?? ""),
              selected: selectedOptions.contains(widget.options[index]),
              onSelected: (bool selected) {
                if (selectedOptions.contains(widget.options[index])) {
                  selectedOptions.remove(widget.options[index]);
                } else {
                  selectedOptions.add(widget.options[index]);
                }

                widget.onChanged(widget.options[index]);
                setState(() {});
              },
              selectedColor: Theme.of(context).primaryColor,
            ),
          );
        }),
      ),
    );
  }
}

class RadioWidget extends StatefulWidget {
  final List<Options> options;

  const RadioWidget({super.key, required this.options});

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List<Widget>.generate(widget.options.length, (int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(widget.options[index].optionName ?? ""),
              selected: selectedIndex == index,
              onSelected: (bool selected) {
                setState(() {
                  selectedIndex = selected ? index : selectedIndex;
                });
              },
              selectedColor: Theme.of(context).primaryColor,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  final String title;
  final List<Options> options;
  final Function(List<Options>) onChange;

  const ListWidget({super.key, required this.title, required this.options, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ListWidgetContent(
              options: options,
              title: title,
              onChange: onChange,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                textDirection: Directionality.of(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListWidgetContent extends StatefulWidget {
  final List<Options> options;
  final String title;
  final Function(List<Options>) onChange;

  const ListWidgetContent({super.key, required this.options, required this.title, required this.onChange});

  @override
  State<ListWidgetContent> createState() => _ListWidgetContentState();
}

class _ListWidgetContentState extends State<ListWidgetContent> {
  List<Options> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.grey[100],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: CheckboxListTile(
                      title: Text(widget.options[index].optionName ?? ""),
                      value: selectedOptions.contains(widget.options[index]),
                      onChanged: (bool? value) {
                        if (selectedOptions.contains(widget.options[index])) {
                          selectedOptions.remove(widget.options[index]);
                        } else {
                          selectedOptions.add(widget.options[index]);
                        }

                        setState(() {});
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 4,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ButtonWidget(
              type: ButtonType.primary,
              title: "Apply",
              onTap: () {
                Navigator.pop(context);
                widget.onChange(selectedOptions);
              },
            ),
          )
        ],
      ),
    );
  }
}
