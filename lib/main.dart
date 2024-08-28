import 'dart:io';

import 'package:fitwiz/core/setup_locator.dart';
import 'package:fitwiz/features/address/presentation/blocs/address/address_bloc.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/auth/presentation/screens/login_screen.dart';
import 'package:fitwiz/features/auth/presentation/screens/register_screen.dart';
import 'package:fitwiz/features/event/presentation/blocs/event_register/event_register_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_events/my_events_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/main/presentation/screens/main_screen.dart';
import 'package:fitwiz/features/splash/presentation/screens/splash_screen.dart';
import 'package:fitwiz/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: ScreenUtilInit(
        designSize: const Size(376, 664),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        rebuildFactor: (old, data) => true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => locator<AuthBloc>()),
            BlocProvider(create: (_) => locator<EventsBloc>()),
            BlocProvider(create: (_) => locator<MyEventsBloc>()),
            BlocProvider(create: (_) => locator<EventRegisterBloc>()),
            BlocProvider(create: (_) => locator<AddressBloc>()),
          ],
          child: GetMaterialApp(
            title: "Fitwiz",
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: "/splash",
            routes: {
              "/main": (context) => const MainScreen(),
              "/splash": (context) => const SplashScreen(),
              "/login": (context) => const LoginScreen(),
              "/register": (context) => const RegisterScreen(),
            },
          ),
        ),
      ),
    );
  }
}
