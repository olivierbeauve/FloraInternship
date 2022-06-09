import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/dto/account-summary-dto.dart';
import 'package:flora/@common/dto/confirm-subscription-request.dart';
import 'package:flora/@common/dto/create-account-request.dart';
import 'package:flora/@common/dto/create-account-response.dart';
import 'package:flora/@common/dto/create-mandate-go-card-less-request.dart';
import 'package:flora/@common/dto/send-email-confirmation-request.dart';
import 'package:flora/@common/dto/update-account-request.dart';
import 'package:flora/@common/dto/validate-payment-method-request.dart';
import 'package:flora/@common/service/authentication-service.dart';
import 'package:flora/@common/service/http-service.dart';
import 'package:flora/@common/service/rest-service.dart';
import 'package:flora/@common/service/shared-preferences-service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountService {
  RestService _restService = RestService();
  SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  Future<bool> confirmSubscription(ConfirmSubscriptionRequest request) async {
    try {
      var response = await _restService.restPost(
          '/public/billing/v1/subscription', jsonEncode(request.toJson()),
          public: true);
      if (HttpService.is2XX(response.statusCode)) {
        return true;
      }
      return false;
    } catch (exception) {
      return false;
    }
  }

  Future<List<bool>> createAccount(CreateAccountRequest request) async {
    List<bool> responseList = [];
    try {
      var response = await _restService.restPost(
          '/public/party/v1/properties', jsonEncode(request.toJson()),
          public: true);
      _sharedPreferencesService.putObject(
          "x-correlationId", response.headers["x-correlation-id"]);

      if (HttpService.is2XX(response.statusCode)) {
        Map<String, dynamic> json = jsonDecode(response.body);
        var body = CreateAccountResponse.fromJson(json);
        responseList.add(true);
        responseList.add(body.emailExist);
        responseList.add(body.validation == "accepted");
      } else {
        return null;
      }
      return responseList;
    } catch (e) {
      return null;
    }
  }

  Future<bool> createMandate(MandateGoCardLess request) async {
    try {
      var response = await _restService.restPost(
          '/public/billing/v1/subscription/gocardless/mandate',
          jsonEncode(request.toJson()),
          public: true);
      if (HttpService.is2XX(response.statusCode)) {
        Map<String, dynamic> json = jsonDecode(response.body);
        String url = json["redirectUrl"];
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          return false;
        }
        return true;
      }
      return false;
    } catch (exception) {
      return false;
    }
  }


  Future<Map<String, dynamic>> getMyQuote(
      String startDate, String correlationId,
      {bool isPublic = false}) async {
    try {
      if (startDate == null)
        startDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
      String url = '/party/v1/properties/getMyQuote?startDate=$startDate';
      if (isPublic != null && isPublic) url = "/public" + url;
      var response = await _restService.restGet(url,
          public: isPublic, correlationId: correlationId);
      Map<String, dynamic> json = jsonDecode(response);
      return json;
    } catch (exception) {
      return null;
    }
  }

  Future<bool> sendConfirmationEmail(
      SendEmailConfirmationRequest request, String correlationId) async {
    try {
      var response = await _restService.restPost(
          '/public/party/v1/properties/resendEmail',
          jsonEncode(request.toJson()),
          public: true,
          correlationId: correlationId);
      if (HttpService.is2XX(response.statusCode))
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> validatePayment(ValidatePaymentMethodRequest request) async {
    try {
      var response = await _restService.restPost(
          '/public/billing/v1/subscription/validate/paymentMethod',
          jsonEncode(request.toJson()),
          public: true);
      if (HttpService.is2XX(response.statusCode)) {
        return true;
      }
      return false;
    } catch (exception) {
      return false;
    }
  }
}
