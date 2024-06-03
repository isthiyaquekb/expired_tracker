import 'package:expiry_track/core/constant/app_colors.dart';
import 'package:expiry_track/core/constant/app_routes.dart';
import 'package:expiry_track/core/local_db/local_database.dart';
import 'package:expiry_track/core/services/local_notification_services.dart';
import 'package:expiry_track/feature/home/viewmodel/home_viewmodel.dart';
import 'package:expiry_track/feature/inventory/view_model/inventory_view_model.dart';
import 'package:expiry_track/feature/onboard/view_model/onboarding_view_model.dart';
import 'package:expiry_track/feature/scanner/view_model/scanner_view_model.dart';
import 'package:expiry_track/feature/splash/view_model/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await LocalDatabase().initDB();
  await LocalNotificationServices.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LocalDatabase()),
    ChangeNotifierProvider(create: (_) => SplashProvider()),
    ChangeNotifierProvider(create: (_) => OnboardingViewModel()),
    ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ChangeNotifierProvider(create: (_) => ScannerViewModel()),
    ChangeNotifierProvider(create: (_) => InventoryViewModel()),
  ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expire App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute:AppRoutes.generatedRoutes,
    );
  }
}

