import 'package:fitwiz/features/event/data/presentation/widgets/events_horiz_list.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerBg,
      body: Container(
        color: AppColors.containerBgSecondary,
        child: Column(
          children: [
            16.verticalSpacingRadius,
            const EventsHorizList(),
          ],
        ),
      ),
    );
  }
}
