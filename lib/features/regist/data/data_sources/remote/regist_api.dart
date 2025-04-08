import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/regist_response.dart';

part 'regist_api.g.dart';

@RestApi(baseUrl: "https://mockapi.com")
abstract class RegistApi {
  factory RegistApi(Dio dio, {String baseUrl}) = _RegistApi;

  @POST("/register")
  Future<HttpResponse<RegistResponse>> register(
    @Body() Map<String, dynamic> user,
  );
}
