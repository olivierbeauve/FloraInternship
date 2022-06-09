import 'package:json_annotation/json_annotation.dart';

part 'send-email-confirmation-request.g.dart';

@JsonSerializable()
class SendEmailConfirmationRequest {
  String email;

  SendEmailConfirmationRequest();
  factory SendEmailConfirmationRequest.fromJson(Map<String, dynamic> json) =>
      _$SendEmailConfirmationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SendEmailConfirmationRequestToJson(this);
}
