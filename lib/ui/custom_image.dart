import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;

import '../data/network/network_service.dart';
import 'my_colors.dart';

/// A custom image widget that fetches the image from the server and
/// displays a stylized progress indicator while loading.
class CustomImage extends StatelessWidget {
  /// The image ID to fetch from the server.
  final String imageID;

  /// The height of the image.
  final double height;

  /// The width of the image.
  final double width;

  const CustomImage(
    this.imageID, {
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: CachedNetworkImage(
          imageUrl: NetworkService.makeUrlFrom(
            imageID,
            width: width.ceil(),
            height: height.ceil(),
          ),
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[100],
            child: Center(
              child: SizedBox(
                width: height * 0.15,
                height: height * 0.15,
                child: const CircularProgressIndicator(
                  strokeWidth: 6.0,
                  color: MyColors.grey,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[100],
            child: Center(
              child: SizedBox(
                width: height * 0.15,
                height: height * 0.15,
                child: Icon(
                  size: height * 0.15,
                  Icons.error,
                  color: MyColors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
