import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_image_preloader.dart';

class WImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final BorderRadius? borderRadius;
  final Widget? placeholder;

  const WImage({
    this.imageUrl = "",
    this.width,
    this.height,
    this.fit = BoxFit.fill,
    this.color,
    this.borderRadius,
    Key? key,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        color: color,
        fit: fit,
        placeholder: (context, url) => placeholder ?? const ImagePreloadShimmer(),
        errorWidget: (context, url, error) => SvgPicture.asset('assets/icons/placeholder.svg'),
      ),
    );
  }
}
