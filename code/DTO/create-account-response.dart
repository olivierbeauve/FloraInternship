import 'package:json_annotation/json_annotation.dart';

part 'create-account-response.g.dart';

@JsonSerializable()
class CreateAccountResponse {
  bool emailExist;
  bool isValidatedEmail;
  bool hasContract;
  String validation;
  String correlationId;

  CreateAccountResponse();
  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAccountResponseToJson(this);
}
