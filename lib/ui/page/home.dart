import 'dart:math' show min;

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:provider/provider.dart';

import '../../provider/cards.dart';
import '../../provider/disliked.dart';
import '../../provider/liked.dart';
import '../my_colors.dart';
import '../custom_image.dart';

/// The home page of the app.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    final controller = AppinioSwiperController();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSize = min(height * 0.475, width * 0.9);

    return Center(
      child: Column(
        children: [
          SizedBox(height: height * 0.05),
          SvgPicture.asset(
            'assets/icon.svg',
            width: height * 0.12,
          ),
          SizedBox(height: height * 0.025),
          SizedBox(
            width: imageSize,
            height: imageSize + height * 0.15,
            child: Consumer<CardsProvider>(
              builder: (context, cardsProvider, _) {
                return AppinioSwiper(
                  controller: controller,
                  cardCount: cardsProvider.count,
                  initialIndex: cardsProvider.currentIndex,
                  invertAngleOnBottomDrag: true,
                  backgroundCardCount: 1,
                  swipeOptions: SwipeOptions.symmetric(
                    horizontal: cardsProvider.currentId != null,
                  ),
                  onSwipeEnd: (previousIndex, targetIndex, activity) {
                    if (activity is! Swipe) {
                      return;
                    }

                    switch (activity.direction) {
                      case AxisDirection.left:
                        var imageID = cardsProvider.getIdAt(previousIndex);
                        if (imageID != null) {
                          Provider.of<DislikedProvider>(context, listen: false)
                              .add(imageID);
                        }
                        break;
                      case AxisDirection.right:
                        var imageID = cardsProvider.getIdAt(previousIndex);
                        if (imageID != null) {
                          Provider.of<LikedProvider>(context, listen: false)
                              .add(imageID);
                        }
                        break;
                      default:
                        throw Exception('Invalid swipe direction');
                    }

                    cardsProvider.updateAt(previousIndex);
                    cardsProvider.currentIndex = targetIndex;
                  },
                  loop: true,
                  cardBuilder: (BuildContext context, int index) {
                    final imageID = cardsProvider.getIdAt(index);
                    return Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 10.0,
                      child: imageID == null
                          ? Center(
                              child: SizedBox(
                                width: height * 0.08,
                                height: height * 0.08,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 6.0,
                                  color: MyColors.grey,
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                CustomImage(
                                  imageID,
                                  height: imageSize,
                                  width: imageSize,
                                ),
                                SizedBox(
                                  height: height * 0.13,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: height * 0.08,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: MyColors.grey,
                                            width: height * 0.0045,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            controller.swipeLeft();
                                          },
                                          icon: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: height * 0.0075),
                                            child: SvgPicture.asset(
                                              'assets/cross.svg',
                                              height: height * 0.05,
                                              width: height * 0.05,
                                            ),
                                          ),
                                          color: MyColors.grey,
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.08,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: MyColors.primary,
                                            width: height * 0.0045,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            controller.swipeRight();
                                          },
                                          icon: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: height * 0.0075),
                                            child: SvgPicture.asset(
                                              'assets/heart.svg',
                                              height: height * 0.05,
                                              width: height * 0.05,
                                            ),
                                          ),
                                          color: MyColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: height * 0.02),
          SizedBox(
            height: height * 0.55 - imageSize,
            width: width * 0.8,
            child: Center(
              child: Text(
                l10n.swipeHint,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: height * 0.02,
                      fontWeight: FontWeight.w400,
                      color: MyColors.grey,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
