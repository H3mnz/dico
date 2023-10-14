import 'package:dico/app/utils/clipper.dart';
import 'package:flutter/material.dart';

import '../animations/fade_slide_animations.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

import 'search_text_field.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: appBarHeight(context) + kToolbarHeight / 6,
      child: FadeSlideAnimation(
        offset: -0.1,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              right: -32,
              left: -32,
              bottom: 16,
              child: Material(
                borderRadius: BorderRadius.circular(100),
                elevation: 20,
              ),
            ),
            Positioned.fill(
              child: ClipPath(
                clipper: OvalClipper(),
                child: AppBar(
                  toolbarHeight: 60,
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  title: const Text('دیکشنری دیکو'),
                  centerTitle: true,
                ),
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 4,
              child: SearchTextField(),
            ),
          ],
        ),
      ),
    );
  }
}
