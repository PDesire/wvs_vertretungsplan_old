import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:wvs_plan/backend/model/DSBNextModel/DSBNextModel.dart';
import 'package:wvs_plan/backend/model/DSBTodayModel/DSBTodayModel.dart';
import 'package:wvs_plan/credentials/Credentials.dart';

class DsbService {

  static Future<DsbTodayModel> getToday() {
    Dio dio = Dio();
    dio.transformer = FlutterTransformer();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "https://api.thepublictransport.de")).interceptor);
    return dio.post(
        "https://api.thepublictransport.de/dsb/today/get",
        data: {"username":Credentials.USERNAME, "password":Credentials.PASSWORD},
        options: buildCacheOptions(
          Duration(minutes: 5),
          maxStale: Duration(minutes: 30),
            options: Options(
              contentType: "application/json",
              responseType: ResponseType.json
            )
        )
    ).then((res) {
      return DsbTodayModel.fromJson(res.data);
    });
  }

  static Future<DsbNextModel> getNext() {
    Dio dio = Dio();
    dio.transformer = FlutterTransformer();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "https://api.thepublictransport.de")).interceptor);
    return dio.post(
        "https://api.thepublictransport.de/dsb/next/get",
        data: {"username":Credentials.USERNAME, "password":Credentials.PASSWORD},
        options: buildCacheOptions(
          Duration(minutes: 5),
          maxStale: Duration(minutes: 30),
            options: Options(
              contentType: "application/json",
              responseType: ResponseType.json
            )
        )
    ).then((res) {
      return DsbNextModel.fromJson(res.data);
    });
  }
}