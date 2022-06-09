import 'package:flora/@common/dto/create-account-request.dart';
import 'package:flora/@common/dto/pricing-response.dart';
import 'package:flutter/material.dart';

class SubscriptionProvider extends ChangeNotifier {
  CreateAccountRequest request = CreateAccountRequest();
  int currentPageQuote = 0;
  int currentPageCreateAccount = 0;
  int currentPageSubscription = 0;
  int currentPageConfirmation = 0;
  PricingResponse pricingResponse;
  bool groundFloor;
  bool alreadyAssured;
  bool creditCard;
  String paymentMethodId;
  List<String> localities;

  SubscriptionProvider() {
    request.policy = PolicyAccount();
    request.contact = Contact();
    request.property = PropertyAccount();
    init();
  }

  void init() async {
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  void setIndexAccount(int index, {bool notify = true}) {
    currentPageCreateAccount = index;
    if (notify) {
      notifyListeners();
    }
  }

  void setIndexConfirmation(int index, {bool notify = true}) {
    currentPageConfirmation = index;
    if (notify) {
      notifyListeners();
    }
  }

  void setIndexQuote(int index, {bool notify = true}) {
    currentPageQuote = index;
    if (notify) {
      notifyListeners();
    }
  }

  void setIndexSubscription(int index, {bool notify = true}) {
    currentPageSubscription = index;
    if (notify) {
      notifyListeners();
    }
  }

  void setPricingResponse(PricingResponse response) {
    pricingResponse = response;
  }
}
