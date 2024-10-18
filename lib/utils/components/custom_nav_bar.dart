import 'package:fitwiz/features/custom_scaffold/data/models/custom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:fitwiz/utils/misc/widget_utils.dart';

class CustomNavBar extends StatefulWidget {
  final List<CustomNavBarItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onIndexChanged;

  const CustomNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyShades[0],
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: safeBottomPadding(0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < widget.items.length; i++)
            Expanded(
              child: _Item(
                item: widget.items[i],
                isSelected: i == widget.selectedIndex,
                onPressed: () => widget.onIndexChanged?.call(i),
              ),
            )
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final CustomNavBarItem item;
  final bool isSelected;
  final VoidCallback onPressed;

  const _Item({
    required this.item,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTextStyles.GGG_12_400(
            color:
                isSelected ? AppColors.primaryColor : AppColors.greyShades[11],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox.square(
                dimension: 16.sp,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isSelected ? item.activeIcon : item.icon,
                  ),
                ),
              ),
              4.verticalSpace,
              Text(item.label),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              overlayColor:
                  WidgetStateProperty.all(Colors.white.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(12.sp),
            ),
          ),
        ),
      ],
    );
  }
}
