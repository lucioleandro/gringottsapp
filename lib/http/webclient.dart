import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/LoggingInterceptor.dart';

const API_URL = 'http://192.168.100.6:8080';

var client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);
