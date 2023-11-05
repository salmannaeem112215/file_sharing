import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:file_sharing/core/core.dart';
import 'package:ui_common/ui_common.dart';

import './lighted_background.dart';
import './page_indicators.dart';
import './sm_home_bottom_navigation.dart';
import './smart_room_page_view.dart';

class SmartRoomView extends StatelessWidget {
  const SmartRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final controller =
        PageController(viewportFraction: getViewportFraction(screenWidth));

    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: SmartRoomsPageView(controller: controller),
          ),
          const Positioned.fill(
            top: null,
            child: Column(
              children: [
                PageIndicators(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getViewportFraction(double width) {
    return 0.8 / (width / 350);
  }
}
