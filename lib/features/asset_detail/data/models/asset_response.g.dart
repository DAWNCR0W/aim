// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetResponse _$AssetResponseFromJson(Map<String, dynamic> json) =>
    AssetResponse(
      result: Result.fromJson(json['result'] as Map<String, dynamic>),
      data: AssetData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssetResponseToJson(AssetResponse instance) =>
    <String, dynamic>{
      'result': instance.result.toJson(),
      'data': instance.data.toJson(),
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      message: json['message'] as String,
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
    };

AssetData _$AssetDataFromJson(Map<String, dynamic> json) => AssetData(
      assetList: (json['asset_list'] as List<dynamic>)
          .map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetDataToJson(AssetData instance) => <String, dynamic>{
      'asset_list': instance.assetList,
    };

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      securitySymbol: json['security_symbol'] as String,
      type: json['type'] as String,
      securityDescription: json['security_description'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      ratio: (json['ratio'] as num).toDouble(),
      securityName: json['security_name'] as String,
    );

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'security_symbol': instance.securitySymbol,
      'type': instance.type,
      'security_description': instance.securityDescription,
      'quantity': instance.quantity,
      'ratio': instance.ratio,
      'security_name': instance.securityName,
    };
