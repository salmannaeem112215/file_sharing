import 'package:file_sharing/core/core.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared/presentation/widgets/room_card.dart';
import '../../../smart_room/screens/room_details_screen.dart';

class SmartRoomsPageView extends StatelessWidget {
  const SmartRoomsPageView({
    super.key,
    required this.controller,
    required this.pageNotifier,
    required this.cardPerScreen,
    required this.roomSelectorNotifier,
  });

  final ValueNotifier<double> pageNotifier;
  final ValueNotifier<int> roomSelectorNotifier;
  final double cardPerScreen;

  final PageController controller;
  static get length => SmartRoom.fakeValues.length;
  static final listKey = GlobalKey();

  double _getOffsetX(double percent) => percent.isNegative ? 30 : -30;

  Matrix4 _getOutTranslate({
    required double percent,
    required int selectedRoom,
    required int index,
  }) {
    double x = selectedRoom != index && selectedRoom != -1
        ? _getOffsetX(selectedRoom > index ? 1 : -1)
        : 0;
    return Matrix4.translationValues(x, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: ValueListenableBuilder(
          valueListenable: pageNotifier,
          builder: (_, currentPage, __) {
            return ValueListenableBuilder(
                valueListenable: roomSelectorNotifier,
                builder: (_, selected, __) {
                  return PageView.builder(
                    controller: controller,
                    clipBehavior: Clip.none,
                    padEnds: false,
                    itemCount: SmartRoom.fakeValues.length,
                    itemBuilder: (_, index) {
                      final room = SmartRoom.fakeValues[index];
                      double percent = currentPage - index;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: RoomCard.cardPadding / 2),
                        transform: _getOutTranslate(
                          percent: percent,
                          selectedRoom: selected,
                          index: index,
                        ),
                        child: RoomCard(
                          percent:
                              getPercent(curentPage: currentPage, index: index),
                          expand: selected == index,
                          room: room,
                          onSwipeUp: () => roomSelectorNotifier.value = index,
                          onSwipeDown: () => roomSelectorNotifier.value = -1,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RoomDetailScreen(room: room),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                });
          }),
    );
  }

  double getPercent({required double curentPage, required int index}) {
    final percent = (index - curentPage) / cardPerScreen;
    return percent;
  }
}
