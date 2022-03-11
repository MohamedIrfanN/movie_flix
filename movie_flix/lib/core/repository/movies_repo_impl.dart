import 'package:get/get.dart';
import 'package:movie_flix/core/repository/model/now_playing_model.dart';
import 'package:movie_flix/core/repository/model/top_rated_model.dart';
import 'package:movie_flix/core/repository/movies_repo.dart';
import 'package:movie_flix/service/http_service.dart';
import 'package:movie_flix/service/http_service_impl.dart';

class MoviesRepoImpl implements MoviesRepo{

  late HttpService _httpService;

  MoviesRepoImpl(){
    _httpService = Get.put(HttpServiceImpl());
    _httpService.init();
  }

  @override
  Future<List<Result>?> getNowPlaying() async{
    // TODO: implement getNowPlaying
    try {
      final response = await _httpService.getRequest("/3/movie/now_playing");
      final parsedResponse = NowPlayingModel.fromJson(response.data);
      return parsedResponse.results;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<Results>?> getTopRated() async{
    // TODO: implement getTopRated
    try {
      final response = await _httpService.getRequest("/3/movie/top_rated");
      final parsedResponse = TopRatedModel.fromJson(response.data);
      return parsedResponse.results;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }


}