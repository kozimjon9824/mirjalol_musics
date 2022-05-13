import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MusicControlButton extends StatelessWidget {
  const MusicControlButton({
    Key? key,
    required this.onTap,
    required this.iconData,
    required this.size,
    required this.bgColor,
    required this.iconSize,
  }) : super(key: key);

  final Function() onTap;
  final String iconData;
  final double size;
  final Color bgColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset('assets/images/$iconData.svg',
            color: Colors.white, height: iconSize, width: iconSize),
      ),
    );
  }
}
