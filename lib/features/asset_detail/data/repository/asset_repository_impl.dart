import 'package:dio/dio.dart';
import '../../domain/entities/asset.dart';
import '../../domain/repository/asset_repository.dart';
import '../data_sources/remote/asset_api.dart';
import '../models/asset_response.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetApi api;

  AssetRepositoryImpl({AssetApi? api})
    : api =
          api ??
          AssetApi(
            Dio()
              ..interceptors.add(
                InterceptorsWrapper(
                  onRequest: (options, handler) {
                    if (options.path.endsWith("/assets")) {
                      Future.delayed(const Duration(seconds: 1), () {
                        handler.resolve(
                          Response(
                            requestOptions: options,
                            statusCode: 200,
                            data: {
                              "result": {"message": "success", "code": 0},
                              "data": {
                                "asset_list": [
                                  {
                                    "security_symbol": "TEST1",
                                    "type": "stock",
                                    "security_description": "테스트를 위한 종목1",
                                    "quantity": 1,
                                    "ratio": 10.05,
                                    "security_name": "test security 1",
                                  },
                                  {
                                    "security_symbol": "TEST2",
                                    "type": "stock",
                                    "description": "테스트를 위한 종목1",
                                    "quantity": 1,
                                    "ratio": 8.03,
                                    "security_name": "test security 2",
                                  },
                                  {
                                    "security_name": "test security 3",
                                    "type": "stock",
                                    "security_symbol": "TEST3",
                                    "quantity": 1,
                                    "ratio": 6.5,
                                    "security_description": "테스트를 위한 종목3",
                                  },
                                  {
                                    "quantity": 1,
                                    "type": "stock",
                                    "security_name": "test security 4",
                                    "ratio": 8.5,
                                    "security_description": "테스트를 위한 종목4",
                                    "security_symbol": "TEST4",
                                  },
                                  {
                                    "security_description": "테스트를 위한 종목5",
                                    "security_name": "test security 5",
                                    "type": "bond",
                                    "ratio": 9.5,
                                    "security_symbol": "TEST5",
                                    "quantity": 3,
                                  },
                                  {
                                    "security_symbol": "TEST6",
                                    "type": "bond",
                                    "quantity": 1,
                                    "ratio": 8.5,
                                    "security_name": "test security 6",
                                    "security_description": "테스트를 위한 종목6",
                                  },
                                  {
                                    "security_symbol": "TEST7",
                                    "type": "bond",
                                    "quantity": 1,
                                    "ratio": 13.42,
                                    "security_name": "test security 7",
                                    "security_description": "테스트를 위한 종목7",
                                  },
                                  {
                                    "security_symbol": "usd_cash",
                                    "type": "etc",
                                    "quantity": 1,
                                    "security_name": "cash",
                                    "ratio": 35.5,
                                    "security_description": "현금",
                                  },
                                ],
                              },
                            },
                          ),
                        );
                      });
                    } else {
                      handler.next(options);
                    }
                  },
                ),
              ),
            baseUrl: "https://mockapi.com",
          );

  @override
  Future<List<AssetEntity>> getAssets() async {
    final response = await api.fetchAssets();
    if (response.response.statusCode == 200) {
      final assetResponse = response.data;
      final assets =
          assetResponse.data.assetList.map((model) {
            return AssetEntity(
              securitySymbol: model.securitySymbol,
              type: model.type,
              securityDescription: model.securityDescription,
              quantity: model.quantity,
              ratio: model.ratio,
              securityName: model.securityName,
            );
          }).toList();
      return assets;
    } else {
      throw Exception("자산 정보를 불러오는데 실패했습니다.");
    }
  }
}
