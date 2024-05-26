import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../provider/disliked.dart';
import '../custom_image.dart';
import '../my_colors.dart';

/// A page that displays the disliked images.
class DislikedPage extends StatelessWidget {
  const DislikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageWidth = min(width * 0.9, height * 0.25 * 16 / 9);
    final imageHeight = imageWidth * 9 / 16;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: ListView(
        children: <Widget>[
          SizedBox(height: height * 0.05),
          SvgPicture.asset(
            'assets/icon.svg',
            width: height * 0.12,
          ),
          SizedBox(
            width: width * 0.8,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.03),
              child: Center(
                child: Text(
                  l10n.dislikedCatsTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: height * 0.045,
                      ),
                ),
              ),
            ),
          ),
          Center(
            child: Consumer<DislikedProvider>(
              builder: (context, dislikedProvider, _) {
                final imageIDs = dislikedProvider.ids;

                if (imageIDs.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: height * 0.03),
                    child: Center(
                      child: Text(
                        l10n.noDislikedCats,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: height * 0.03,
                          color: MyColors.grey,
                        ),
                      ),
                    ),
                  );
                }

                return Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: <Widget>[
                    for (final imageID in imageIDs)
                      CustomImage(
                        imageID,
                        height: imageHeight,
                        width: imageWidth,
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
