import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/asset_response.dart';

part 'asset_api.g.dart';

@RestApi(baseUrl: "https://mockapi.com")
abstract class AssetApi {
  factory AssetApi(Dio dio, {String baseUrl}) = _AssetApi;

  @GET("/assets")
  Future<HttpResponse<AssetResponse>> fetchAssets();
}
