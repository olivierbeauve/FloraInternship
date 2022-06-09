import 'package:json_annotation/json_annotation.dart';

part 'create-account-request.g.dart';

@JsonSerializable()
class Address {
  String streetName;
  String streetNumber;
  String box;
  String postalCode;
  String city;
  String countryCode;
  String country;

  Address();
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class CancellationAccount {
  String companyName;
  String contractNumber;
  String dueDate;

  CancellationAccount();
  factory CancellationAccount.fromJson(Map<String, dynamic> json) =>
      _$CancellationAccountFromJson(json);
  Map<String, dynamic> toJson() => _$CancellationAccountToJson(this);
}

@JsonSerializable()
class Contact {
  String language;
  String name;
  String firstname;
  String phoneNumber;
  String email;
  String password;
  String birthDate;
  Address address;
  bool marketingOptin;
  bool marketingPartnerBenefitsOptin;

  Contact();
  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}

@JsonSerializable()
class CreateAccountRequest {
  String referrer;
  Contact contact;
  PropertyAccount property;
  PolicyAccount policy;

  CreateAccountRequest();
  factory CreateAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAccountRequestToJson(this);
}

enum LANGUAGE { Fr, Nl, En, De }

@JsonSerializable()
class PolicyAccount {
  String startDate;
  List<String> options;
  String product;
  int nbRoommates;
  
  PolicyAccount();
  factory PolicyAccount.fromJson(Map<String, dynamic> json) =>
      _$PolicyAccountFromJson(json);
  Map<String, dynamic> toJson() => _$PolicyAccountToJson(this);
}

@JsonSerializable()
class PropertyAccount {
  String type;
  double rent;
  bool groundFloor;
  String s3FloodId;
  int nbBedrooms;

  PropertyAccount();
  factory PropertyAccount.fromJson(Map<String, dynamic> json) =>
      _$PropertyAccountFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyAccountToJson(this);
}

enum USER_STATE {
  EMAIL_NOT_VALIDATED,
  EMAIL_VALIDATED,
  PAYMENT_DONE,
  BLACKLIST_PENDING,
  BLACKLISTED
}
