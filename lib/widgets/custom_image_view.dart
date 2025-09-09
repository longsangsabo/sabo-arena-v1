import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Lightweight image widget handling SVG (by extension) and raster assets.
class CustomImageView extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const CustomImageView({
    Key? key,
    required this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  bool get _isSvg => imagePath.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    final Widget child = _isSvg
        ? SvgPicture.asset(
            imagePath,
            height: height,
            width: width,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
            fit: fit,
          )
        : Image.asset(
            imagePath,
            height: height,
            width: width,
            color: color,
            fit: fit,
          );

    return child;
  }
}
