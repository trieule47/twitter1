import 'package:chopper/chopper.dart';
import 'package:flutter_app/models/response/api_response.dart';
import 'package:flutter_app/repositories/api_client.dart';

part 'follow_repositories.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class FollowRepository extends ApiClient {
  static FollowRepository manager;

  static FollowRepository create() {
    final client = ApiClient.create();
    return _$FollowRepository(client);
  }

  static FollowRepository getInstance() {
    if (manager == null) {
      manager = FollowRepository.create();
      return manager;
    }
    return manager;
  }

  @Get(path: ':id/following/')
  Future<Response<ApiResponse>> getListFollow(@Path('id') int id);

  @Get(path: 'by/username/:username/')
  Future<Response<ApiResponse>> getUser(@Path('username') String username);
}