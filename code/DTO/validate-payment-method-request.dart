import 'package:json_annotation/json_annotation.dart';

part 'validate-payment-method-request.g.dart';

@JsonSerializable()
class ValidatePaymentMethodRequest {
  String partyId;
  String paymentMethod;
  String paymentSystem;
  String quoteId;

  ValidatePaymentMethodRequest();
  factory ValidatePaymentMethodRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidatePaymentMethodRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ValidatePaymentMethodRequestToJson(this);
}
