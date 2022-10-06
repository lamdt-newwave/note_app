import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_colors.dart';
import '../../pages/home/home_cubit.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Color fillColor;
  final String hintText;
  final TextStyle hintStyle;
  final Widget suffixIcon;

  const SearchWidget({
    Key? key,
    required this.controller,
    this.onChanged,
    required this.fillColor,
    required this.hintText,
    required this.hintStyle,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextFormField(
        controller: controller,
        maxLines: 1,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: true,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: hintStyle,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
