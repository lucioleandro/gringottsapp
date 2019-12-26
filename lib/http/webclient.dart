import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.requestUrl}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Request');
    print('headers: ${data.headers}');
    print('status code: ${data.statusCode}');
    print('body: ${data.body}');
    print(data);
    return data;
  }
}

void findAll() async {
  var client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  var future = await client.get('http://172.29.40.69:8080/transactions');
  print(future.body);
}
