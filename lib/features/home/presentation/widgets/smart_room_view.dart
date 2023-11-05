import 'package:file_sharing/core/shared/presentation/widgets/room_card.dart';
import 'package:flutter/material.dart';

import './page_indicators.dart';
import './smart_room_page_view.dart';

class SmartRoomView extends StatefulWidget {
  const SmartRoomView({
    super.key,
  });
  @override
  State<SmartRoomView> createState() => _SmartRoomViewState();
}

class _SmartRoomViewState extends State<SmartRoomView> {
  PageController controller = PageController(viewportFraction: 1);
  final ValueNotifier<double> pageNotifier = ValueNotifier(0);
  final ValueNotifier<int> roomSelectorNotifier = ValueNotifier(-1);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    onInit(width: width);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Positioned.fill(
          top: null,
          child: Column(
            children: [
              PageIndicators(),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 40),
          child: SizedBox(
            height: RoomCard.cardHeight,
            child: SmartRoomsPageView(
              controller: controller,
              pageNotifier: pageNotifier,
              roomSelectorNotifier: roomSelectorNotifier,
              cardPerScreen: cardPerScreen(width),
            ),
          ),
        ),
      ],
    );
  }

  double viewportFraction(double width) {
    return 1 / cardPerScreen(width);
  }

  double cardPerScreen(double width) {
    return width / (RoomCard.cardWidth);
  }

  @override
  void initState() {
    onInit();
    super.initState();
  }

  onInit({double? width}) {
    onDispose();
    controller = PageController(
      viewportFraction: width == null ? 1 : viewportFraction(width),
    );
    controller.addListener(pageListner);
  }

  onDispose() {
    try {
      controller
        ..removeListener(pageListner)
        ..dispose();
    } catch (e) {
      // DO NOTHING
    }
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  pageListner() {
    pageNotifier.value = controller.page ?? 0;
  }
}
