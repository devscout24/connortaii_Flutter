
import 'package:flutter/material.dart';

import 'navigation_service.dart';

extension Loader on Future {

  Future<dynamic> waitingForSucess() async {
    showDialog(
      context: NavigationService.context,
      builder: (context) => const Center(),
    );

    try {
      // Wait for the original future to complete
      dynamic result = await this;

      return result;
    } finally {
      // Close the loading dialog
      NavigationService.goBack;
    }
  }
}
