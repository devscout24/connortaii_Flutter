import 'dart:io';
import 'package:connortaii_app/features/onboarding/presentation/onboarding_screen.dart';
import 'package:connortaii_app/navigation_screen.dart';
import 'package:connortaii_app/loading_screen.dart';
import 'package:flutter/cupertino.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  static const String loadingScreen = '/Loading';
  static const String onBoardingScreen = '/OnBoardingScreen';
  static const String buyerNavigationScreen = '/BuyerNavigationScreen';
  static const String chooseRoleScreen = '/ChooseRoleScreen';
  static const String signupScreen = '/SignupScreen';
  static const String signupVerifyScreen = '/SignupVerifyScreen';
  static const String loginScreen = '/LoginScreen';
  static const String forgotPasswordScreen = '/ForgotPasswordScreen';
  static const String forgotPasswordVerifyScreen =
      '/ForgotPasswordVerifyScreen';
  static const String forgotUpdatePasswordScreen =
      '/ForgotUpdatePasswordScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loadingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: const Loading(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const Loading());

      case Routes.buyerNavigationScreen:
        final args = settings.arguments as Map<String, dynamic>?;

        final pageNum = args?['pageNum'] as int? ?? 0;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: NavigationScreen(pageNum: pageNum),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => NavigationScreen(pageNum: pageNum),
              );

      case Routes.onBoardingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const OnboardingScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const OnboardingScreen(),
              );

      // case Routes.signupScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const SignupScreen(),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(builder: (context) => const SignupScreen());

      // case Routes.signupVerifyScreen:
      //   Map args = settings.arguments as Map;

      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: SignupVerifyScreen(email: args['email']),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(
      //           builder: (context) => SignupVerifyScreen(email: args['email']),
      //         );

      // case Routes.loginScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const LoginScreen(),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(builder: (context) => const LoginScreen());

      // case Routes.forgotPasswordScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const ForgotPasswordScreen(),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(
      //           builder: (context) => const ForgotPasswordScreen(),
      //         );

      // case Routes.forgotPasswordVerifyScreen:
      //   Map args = settings.arguments as Map;

      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: ForgotPasswordVerifyScreen(email: args['email']),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(
      //           builder: (context) =>
      //               ForgotPasswordVerifyScreen(email: args['email']),
      //         );

      // case Routes.forgotUpdatePasswordScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const ForgotUpdatePasswordScreen(),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(
      //           builder: (context) => const ForgotUpdatePasswordScreen(),
      //         );

      // //////////////.<<<<<<<<<<   Buyer   >>>>>>>>>>>>.////////////////
      // case Routes.buyerHomeScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const BuyerHomeScreen(),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(builder: (context) => const BuyerHomeScreen());

      // case Routes.buyerProductDetailsScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const BuyerProductDetailsScreen(),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(
      //           builder: (context) => const BuyerProductDetailsScreen(),
      //         );

      // case Routes.cartScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const CartScreen(),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(builder: (context) => const CartScreen());

      default:
        return null;
    }
  }
}

//  weenAnimationBuilder(
//   child: Widget,
//   tween: Tween<double>(begin: 0, end: 1),
//   duration: Duration(milliseconds: 1000),
//   curve: Curves.bounceIn,
//   builder: (BuildContext context, double _val, Widget child) {
//     return Opacity(
//       opacity: _val,
//       child: Padding(
//         padding: EdgeInsets.only(top: _val * 50),
//         child: child
//       ),
//     );
//   },
// );

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
    : super(
        settings: settings,
        reverseTransitionDuration: const Duration(milliseconds: 1),
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return widget;
            },
        transitionDuration: const Duration(milliseconds: 1),
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: Curves.ease),
                child: child,
              );
            },
      );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: widget,
    );
  }
}
