import 'package:json_annotation/json_annotation.dart';

part 'regist_response.g.dart';

@JsonSerializable()
class RegistResponse {
  final bool success;

  RegistResponse({required this.success});

  factory RegistResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegistResponseToJson(this);
}
