import 'package:connortaii_app/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'networks/dio/dio.dart';
import 'welcome_screen.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  loadInitialData() async {
    await setInitValue();
    if (appData.read(kKeyIsLoggedIn) == true) {
      String? token = appData.read(kKeyAccessToken);
      if (token != null && token.isNotEmpty) {
        DioSingleton.instance.update(token);
      }
      //await getProfileRXOBJ.getProfile();
    }
    // await initializeNotifications();
    //  LocalNotificationService.initialize();
    // LocalNotificationService.getToken();
    // DateTime time = DateTime.now().add(const Duration(minutes: 2));
    // await schedulePrayerNotifications(time);

    // await schedulePrayerNotifications();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    } else {
      return const OnboardingScreen();
      // return appData.read(kKeyIsLoggedIn) || appData.read(kKeyIsExploring)
      //     ? const NavigationScreen()
      //     : const NavigationScreen();
      // return  appData.read(kKeyIsFirstTime)? const LanguageChoseScreen() : appData.read(kKeyIsLoggedIn)? const NavigationScreen() : const LoginScreen();
    }
  }
}
