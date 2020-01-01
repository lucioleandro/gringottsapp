import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/LoggingInterceptor.dart';

const API_URL = 'http://172.29.40.69:8080';

var client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);
