import 'package:fitwiz/core/setup_locator.dart';
import 'package:fitwiz/utils/components/custom_back_button.dart';
import 'package:fitwiz/utils/components/custom_bottom_sheet.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/components/custom_search_field.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(376, 664),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      child: GetMaterialApp(
        title: "Fitwiz",
        home: Scaffold(
          body: Builder(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () {
                    CustomNotifications.notifySuccess(
                      context: context,
                      message: "An event has been created successfuly",
                    );
                  },
                  label: "Hello",
                ),
                const CustomButton(
                  onPressed: null,
                  label: "Hello",
                ),
                CustomButton.secondary(
                  onPressed: () {
                    CustomBottomSheet.showSimpleSheet(
                      icon: CustomIcon(
                        CustomIcons.tick,
                        size: 16.sp,
                      ),
                      title: "Event created",
                      message: "An event has been created successfuly",
                    );
                  },
                  label: "Hello",
                ),
                const CustomButton.secondary(
                  onPressed: null,
                  label: "Hello",
                ),
                CustomBackButton(onPressed: () {
                  CustomBottomSheet.showSimpleLoadingSheet(message: "Loading");
                }),
                CustomIcon(
                  CustomIcons.tick,
                  size: 16.sp,
                  containerSize: 24.sp,
                ),
                const CustomTextField(),
                const CustomSearchField(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
