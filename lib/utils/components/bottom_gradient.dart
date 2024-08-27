import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomGradient extends StatelessWidget {
  const BottomGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.sp,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF3F2FC).withOpacity(0),
            const Color(0xFFF3F2FC).withOpacity(0.6),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class BottomGradientWrapper extends StatelessWidget {
  final Widget child;
  const BottomGradientWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const Positioned.fill(
          top: null,
          child: BottomGradient(),
        ),
      ],
    );
  }
}
