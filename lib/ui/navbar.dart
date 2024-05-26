import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'my_colors.dart';

/// Customized navigation bar widget.
class CustomNavigationBar extends StatelessWidget {
  /// Index of the current tab.
  final int currentIndex;

  /// Called when one of the items is tapped.
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final navBarWidth = min(width, height * 0.6);
    final padding = (width - navBarWidth) / 2;

    return SizedBox(
      height: height * 0.1,
      width: navBarWidth,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          color: MyColors.primary,
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              currentIndex: currentIndex,
              onTap: onTap,
              selectedItemColor: Colors.white,
              unselectedItemColor: MyColors.transparentWhite,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/cross.svg',
                    height: height * 0.04,
                    width: height * 0.04,
                    colorFilter: const ColorFilter.mode(
                      MyColors.transparentWhite,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/cross.svg',
                    height: height * 0.04,
                    width: height * 0.04,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: l10n.dislikedTab,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/home.svg',
                    height: height * 0.04,
                    width: height * 0.04,
                    colorFilter: const ColorFilter.mode(
                      MyColors.transparentWhite,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/home.svg',
                    height: height * 0.04,
                    width: height * 0.04,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: l10n.homeTab,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/heart.svg',
                    height: height * 0.04,
                    width: height * 0.04,
                    colorFilter: const ColorFilter.mode(
                      MyColors.transparentWhite,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/heart.svg',
                    height: height * 0.04,
                    width: height * 0.04,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: l10n.likedTab,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
