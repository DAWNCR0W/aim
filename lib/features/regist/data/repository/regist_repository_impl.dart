import 'package:dio/dio.dart';
import '../../domain/entities/regist_user.dart';
import '../../domain/repository/regist_repository.dart';
import '../data_sources/remote/regist_api.dart';
import '../models/regist_response.dart';
import 'package:aim/core/database/app_database.dart';
import '../models/local_user.dart' as localUserModel;
import 'package:aim/core/resources/data_state.dart';

class RegistRepositoryImpl implements RegistRepository {
  final RegistApi api;

  RegistRepositoryImpl({RegistApi? api})
    : api =
          api ??
          RegistApi(
            Dio()
              ..interceptors.add(
                InterceptorsWrapper(
                  onRequest: (options, handler) {
                    if (options.path.endsWith("/register")) {
                      Future.delayed(const Duration(seconds: 1), () {
                        handler.resolve(
                          Response(
                            requestOptions: options,
                            statusCode: 200,
                            data: {'success': true},
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
  Future<DataState<void>> register(RegistUser user) async {
    try {
      final Map<String, dynamic> userMap = {
        "id": user.id,
        "password": user.password,
        "phone": user.phone,
        "email": user.email,
      };
      final response = await api.register(userMap);
      final RegistResponse result = response.data;
      if (response.response.statusCode == 200 && result.success) {
        final database =
            await $FloorAppDatabase.databaseBuilder('app_database.db').build();
        await database.localUserDao.insertUser(
          localUserModel.LocalUser(
            id: user.id,
            password: user.password,
            phone: user.phone,
            email: user.email,
          ),
        );
        return const DataSuccess(null);
      } else {
        return DataFailure(
          DioException(requestOptions: response.response.requestOptions),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return DataFailure(e);
      }
      return DataFailure(
        DioException(requestOptions: RequestOptions(path: 'unknown')),
      );
    }
  }
}
