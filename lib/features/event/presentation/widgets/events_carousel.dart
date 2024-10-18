import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitwiz/utils/components/custom_carousel_indicator.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class EventsCarousel extends StatefulWidget {
  final String title;
  final double height;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final WidgetBuilder errorBuider;
  final bool isLoading;
  final String? error;

  const EventsCarousel({
    super.key,
    required this.title,
    required this.height,
    required this.itemCount,
    required this.itemBuilder,
    required this.errorBuider,
    required this.isLoading,
    this.error,
  });

  @override
  State<EventsCarousel> createState() => _EventsCarouselState();
}

class _EventsCarouselState extends State<EventsCarousel> {
  double _carouselPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            widget.title,
            style: AppTextStyles.EEE_20_500(
              color: AppColors.greyShades[10],
            ),
          ),
        ),
        16.verticalSpace,
        widget.isLoading ? _buildLoading() : _buildBody(),
      ],
    );
  }

  Widget _buildLoading() {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: ListView(
            padding: EdgeInsets.only(left: 16.sp),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (int i = 0; i < 5; i++)
                Container(
                  margin: EdgeInsets.only(right: 16.sp),
                  width: 300.sp,
                  height: widget.height,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    color: AppColors.containerBg,
                    borderRadius: BorderRadius.circular(16.sp),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: AppColors.shimmerBase,
                    highlightColor: AppColors.shimmerHighlight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200.sp,
                          height: 16.sp,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                        ),
                        8.verticalSpacingRadius,
                        Container(
                          width: 300.sp,
                          height: 16.sp,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                        ),
                        8.verticalSpacingRadius,
                        Container(
                          width: 200.sp,
                          height: 16.sp,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 100.sp,
                          height: 16.sp,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        16.verticalSpace,
        Shimmer.fromColors(
          baseColor: AppColors.shimmerBase,
          highlightColor: AppColors.shimmerHighlight,
          child: const CustomCarouselIndicator(
            position: 0,
            total: 5,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (widget.error != null) {
      return _buildError(widget.error!);
    }

    return _buildList();
  }

  Widget _buildError(String error) {
    return Text(
      error,
      style: AppTextStyles.FFF_16_400(
        color: AppColors.error,
      ),
    );
  }

  Widget _buildList() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.itemCount,
          itemBuilder: (context, index, realIndex) {
            return widget.itemBuilder(context, index);
          },
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 0.8,
            onScrolled: (value) {
              setState(() {
                _carouselPosition = value ?? _carouselPosition;
              });
            },
          ),
        ),
        16.verticalSpace,
        CustomCarouselIndicator(
          position: _carouselPosition,
          total: widget.itemCount,
        ),
      ],
    );
  }
}
