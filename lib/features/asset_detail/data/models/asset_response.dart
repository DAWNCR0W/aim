import 'package:json_annotation/json_annotation.dart';

part 'asset_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AssetResponse {
  final Result result;
  final AssetData data;

  AssetResponse({required this.result, required this.data});

  factory AssetResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetResponseToJson(this);
}

@JsonSerializable()
class Result {
  final String message;
  final int code;

  Result({required this.message, required this.code});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class AssetData {
  @JsonKey(name: "asset_list")
  final List<Asset> assetList;

  AssetData({required this.assetList});

  factory AssetData.fromJson(Map<String, dynamic> json) =>
      _$AssetDataFromJson(json);

  Map<String, dynamic> toJson() => _$AssetDataToJson(this);
}

@JsonSerializable()
class Asset {
  @JsonKey(name: "security_symbol")
  final String securitySymbol;
  final String type;
  @JsonKey(name: "security_description")
  final String? securityDescription;
  final int quantity;
  final double ratio;
  @JsonKey(name: "security_name")
  final String securityName;

  Asset({
    required this.securitySymbol,
    required this.type,
    this.securityDescription,
    required this.quantity,
    required this.ratio,
    required this.securityName,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}
