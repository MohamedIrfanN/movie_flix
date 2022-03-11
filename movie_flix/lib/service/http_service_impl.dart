import 'package:dio/dio.dart';
import 'package:movie_flix/service/http_service.dart';

const BASE_URL = "https://api.themoviedb.org/";
const API_KEY = "a07e22bc18f5cb106bfe4cc1f83ad8ed";

class HttpServiceImpl implements HttpService{


  late Dio _dio;

  @override
  Future<Response> getRequest(String url) async{
    // TODO: implement getRequest

    Response response;
    try {
      response = await _dio.get(url+"?api_key=$API_KEY");
      print(response);
    } on DioError catch (e) {
        print(e.message);
        throw Exception(e.message);
    }
    return response;
  }



  @override
  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
    ));
  }
  
}