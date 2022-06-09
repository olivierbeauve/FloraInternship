import 'package:json_annotation/json_annotation.dart';

part 'create-mandate-go-card-less-request.g.dart';

@JsonSerializable()
class MandateGoCardLess {
  String partyId;
  String redirectUrl;

  MandateGoCardLess();
  factory MandateGoCardLess.fromJson(Map<String, dynamic> json) =>
      _$MandateGoCardLessFromJson(json);
  Map<String, dynamic> toJson() => _$MandateGoCardLessToJson(this);
}
