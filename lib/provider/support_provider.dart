import 'package:flutter/cupertino.dart';

class SupportProvider with ChangeNotifier{
  bool isCustomerSelected = false;
  bool isStoreOwnerSelected = false;


  void selectCustomer() {
      isCustomerSelected = true;
      isStoreOwnerSelected = false;
      notifyListeners();
  }
  void selectStoreOwner() {
    isCustomerSelected = false;
    isStoreOwnerSelected = true;
    notifyListeners();

  }

}