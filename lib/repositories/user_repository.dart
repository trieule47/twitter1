import 'package:chopper/chopper.dart';
import 'package:flutter_app/models/response/api_response.dart';
import 'package:flutter_app/models/user/login_filter.dart';
import 'package:flutter_app/repositories/api_client.dart';

part 'user_repository.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class UserRepository extends ApiClient {
  static UserRepository manager;

  static UserRepository create() {
    final client = ApiClient.create();
    return _$UserRepository(client);
  }

  static UserRepository getInstance() {
    if (manager == null) {
      manager = UserRepository.create();
      return manager;
    }
    return manager;
  }

  @Post(path: 'user/log-me-in')
  Future<Response<ApiResponse>> login(@Body() LoginFilter body);
}
