import 'package:file_sharing/features/home/presentation/widgets/smart_room_view.dart';
import 'package:flutter/material.dart';
import 'package:file_sharing/core/core.dart';
import 'package:ui_common/ui_common.dart';

import '../widgets/lighted_background.dart';
import '../widgets/page_indicators.dart';
import '../widgets/sm_home_bottom_navigation.dart';
import '../widgets/smart_room_page_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LightedBackgound(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ShAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text("SELECT A ROOM", style: context.bodyLarge),
              kHeight32,
              Container(
                  color: Colors.amber.withOpacity(0),
                  child: const SmartRoomView()),
              const SmHomeBottomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }
}
