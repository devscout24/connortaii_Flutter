import 'package:auto_animated/auto_animated.dart';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/app_constants.dart';
import 'package:connortaii_app/constants/custome_theme.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/di.dart';
import 'package:connortaii_app/helpers/helper_methods.dart';
import 'package:connortaii_app/helpers/language.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/register_provider.dart';
import 'package:connortaii_app/loading_screen.dart';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/provider/scanned_image_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GetStorage.init();
  diSetup();
  initiInternetChecker();
  DioSingleton.instance.create();
  // try {
  //   await FlutterDisplayMode.setHighRefreshRate();
  // } catch (e) {
  //   log('Error setting high refresh rate: $e');
  // }

  // try {
  //   await getStripePublishableKeyRXObj.getStripePublishableKeyRX();
  //   final response = getStripePublishableKeyRXObj.dataFetcher.value;

  //   if (response.data?.key != null && response.data!.key!.isNotEmpty) {
  //     Stripe.publishableKey = response.data!.key!;
  //     await Stripe.instance.applySettings();
  //     log("Stripe Key Loaded Successfully from Server");
  //     // ToastUtil.showShortToast("Stripe Key Loaded Successfully from Server");
  //   } else {
  //     log("Warning: Stripe Key is null or empty from API");
  //   }
  // } catch (e) {
  //   log('Failed to fetch dynamic key: $e');
  // }

  // await Stripe.instance.applySettings();

  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // NotificationService().initNotification();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScannedImageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    return MultiProvider(
      providers: providers,
      child: AnimateIfVisibleWrapper(
        showItemInterval: const Duration(milliseconds: 150),
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            showMaterialDialog(context);
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return const UtillScreenMobile();
            },
          ),
        ),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    String language = appData.read(kKeyLanguage) ?? kKeyEnglish;
    String countryCode =
        appData.read(kKeyCountryCode) ?? (countriesCode[kKeyEnglish] ?? 'US');

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            showMaterialDialog(context);
          },
          child: GetMaterialApp(
            title: 'Building Assurance',
            showPerformanceOverlay: false,
            theme: ThemeData(
              primarySwatch: CustomTheme.kToDark,
              useMaterial3: false,
              scaffoldBackgroundColor: AppColors.cFFFFFF,
            ),
            debugShowCheckedModeBanner: false,
            translations: LocalString(),
            locale: Locale(language, countryCode),
            builder: (context, widget) {
              return MediaQuery(data: MediaQuery.of(context), child: widget!);
            },
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            // home: const Loading(),
            home: const Loading(),
          ),
        );
      },
    );
  }
}
