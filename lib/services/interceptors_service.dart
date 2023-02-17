import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:http_interceptor/models/request_data.dart';

class LoggingInterceptors implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) {
    // TODO: implement interceptRequest
    throw UnimplementedError();
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) {
    // TODO: implement interceptResponse
    throw UnimplementedError();
  }
}
