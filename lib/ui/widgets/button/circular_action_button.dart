import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircularActionButton extends StatelessWidget {
  final Color backgroundColor;
  final String icon;
  final GestureTapCallback onPressed;
  final Color iconColor;

  const CircularActionButton({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: 60,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
        child: Center(
            child: SvgPicture.asset(
          icon,
          height: 24,
          width: 24,
          color: iconColor,
        )),
      ),
    );
  }
}
