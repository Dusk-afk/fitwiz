import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarouselIndicator extends StatelessWidget {
  final double position;
  final int total;

  const CustomCarouselIndicator({
    super.key,
    required this.position,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    // ***** COLOR CONFIG ******
    Color activeColor = AppColors.primaryColor;
    Color inactiveColor = AppColors.primaryShades[6];

    // ***** SIZE CONFIG ******
    double dotSize = 8.sp;
    double spacing = 4.sp;

    double position = this.position % total;
    double totalWidth = total * dotSize + (total - 1) * spacing;
    double dotOffset = position * (dotSize + spacing);

    Widget dot = Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: activeColor,
        shape: BoxShape.circle,
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        double canvasOffset = constraints.maxWidth / 2 - totalWidth / 2;
        double offset = canvasOffset + dotOffset;

        return SizedBox(
          width: double.infinity,
          child: ClipPath(
            clipper: _IndicatorClipper(total, dotSize, spacing, canvasOffset),
            child: Container(
              color: inactiveColor,
              child: Row(
                children: [
                  SizedBox(width: offset - totalWidth - spacing),
                  dot,
                  SizedBox(width: totalWidth - dotSize + spacing),
                  dot,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _IndicatorClipper extends CustomClipper<Path> {
  final int total;
  final double dotSize;
  final double spacing;
  final double canvasOffset;
  const _IndicatorClipper(
    this.total,
    this.dotSize,
    this.spacing,
    this.canvasOffset,
  );

  @override
  Path getClip(Size size) {
    final path = Path();
    for (int i = 0; i < total; i++) {
      double dotOffset = i * (dotSize + spacing);
      double offset = canvasOffset + dotOffset;
      path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(offset, 0, dotSize, dotSize),
        Radius.circular(dotSize / 2),
      ));
    }

    return path;
  }

  @override
  bool shouldReclip(_IndicatorClipper oldClipper) =>
      total != oldClipper.total ||
      dotSize != oldClipper.dotSize ||
      spacing != oldClipper.spacing;
}
