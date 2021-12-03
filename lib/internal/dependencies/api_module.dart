import 'package:gallery/data/api/api_util.dart';
import 'package:gallery/data/service/webant_service.dart';

class ApiModule {
  static final ApiUtil _apiUtil = ApiUtil(WebantService());

  static ApiUtil apiUtil() {
    return _apiUtil;
  }
}