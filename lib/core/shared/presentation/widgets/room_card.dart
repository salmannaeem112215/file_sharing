import 'package:flutter/material.dart';
import 'package:file_sharing/features/home/presentation/widgets/background_room_lights.dart';
import 'package:ui_common/ui_common.dart';

import '../../../core.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    required this.percent,
    required this.room,
    required this.expand,
    required this.onSwipeUp,
    required this.onSwipeDown,
    required this.onTap,
    super.key,
  });

  final double percent;
  final SmartRoom room;
  final VoidCallback onSwipeUp;
  final VoidCallback onSwipeDown;
  final VoidCallback onTap;
  final bool expand;

  static const double bottomPadding = 0;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1)).then((value) {
      print("CARD CONTEXT ${context.size?.width}");
    });
    return AspectRatio(
      aspectRatio: 4 / 7,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        tween: Tween(begin: 0, end: expand ? 1 : 0),
        builder: (_, value, __) => Stack(
          fit: StackFit.expand,
          children: [
            // -----------------------------------------------
            // Background information card
            // -----------------------------------------------
            Padding(
              padding: const EdgeInsets.only(bottom: bottomPadding),
              child: BackgroundRoomCard(room: room, translation: value),
            ),

            // -----------------------------------------------
            // Room image card with parallax effect
            // -----------------------------------------------
            Padding(
              padding: const EdgeInsets.only(bottom: bottomPadding + 20),
              child: GestureDetector(
                onTap: onTap,
                onVerticalDragUpdate: (details) {
                  if (details.primaryDelta! < -10) onSwipeUp();
                  if (details.primaryDelta! > 10) onSwipeDown();
                },
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    ParallaxImageCard(
                      imageUrl: room.imageUrl,
                      parallaxValue: percent,
                    ),
                    VerticalRoomTitle(room: room),
                    const CameraIconButton(),
                    const AnimatedUpwardArrows()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CameraIconButton extends StatelessWidget {
  const CameraIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            SHIcons.camera,
            color: SHColors.textColor,
          ),
        ),
      ),
    );
  }
}

class VerticalRoomTitle extends StatelessWidget {
  const VerticalRoomTitle({
    required this.room,
    super.key,
  });

  final SmartRoom room;

  @override
  Widget build(BuildContext context) {
    // final dx = 50 * animationValue;
    // final opacity = 1 - animationValue;
    return Align(
      alignment: Alignment.centerLeft,
      child: RotatedBox(
        quarterTurns: -1,
        child: FittedBox(
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 20, top: 12),
            child: Text(
              room.name.replaceAll(' ', ''),
              maxLines: 1,
              style: context.displayLarge.copyWith(color: SHColors.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
