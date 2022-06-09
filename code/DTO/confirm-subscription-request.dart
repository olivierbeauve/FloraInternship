import 'package:flora/payment/switch-dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm-subscription-request.g.dart';

@JsonSerializable()
class ConfirmSubscriptionRequest {
  String partyId;
  String paymentSystem;
  PaymentSystemProps paymentSystemProps;
  String productType;
  String quoteId;
  String startDate;

  ConfirmSubscriptionRequest();
  factory ConfirmSubscriptionRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmSubscriptionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmSubscriptionRequestToJson(this);
}
