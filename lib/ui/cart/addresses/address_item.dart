import 'dart:ffi';

import 'package:dealz/data/models/address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddressItem extends StatelessWidget {
  final bool isSelected;
  final AddressModel address;

  const AddressItem({
    super.key,
    required this.isSelected,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xfff4f4f4),
            border: Border.all(
              color: isSelected ? Theme.of(context).primaryColor : Color(0xff979797).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        address.addressName ?? "",
                        style: TextStyle(
                          color: Color(0xff0e0f14),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if(isSelected)
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        address.addressLine1 ?? "",
                        style: TextStyle(
                          color: Color(0xff0e0f14).withOpacity(0.5),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Icon(Icons.mode_edit_outlined,size: 20, color: Theme.of(context).primaryColor,),
                    Icon(Icons.delete_forever_outlined,size: 20,color: Colors.red,)
                  ],
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
