import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ImageType { network, local }

class CustomCachedImage extends StatelessWidget {
  final ImageType imageType;
  final String url;
  final BoxFit boxFit;
  final BoxShape boxShape;

  const CustomCachedImage(
      {super.key,
      this.imageType = ImageType.network,
      required this.url,
      this.boxFit = BoxFit.scaleDown,
      this.boxShape = BoxShape.rectangle});

  @override
  Widget build(BuildContext context) {
    if (imageType == ImageType.network) {
      return CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
              shape: boxShape,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              )),
        ),
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: boxFit,
          image: AssetImage(url),
        ),
      ),
    );
  }
}
