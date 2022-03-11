import 'package:movie_flix/core/repository/model/now_playing_model.dart';
import 'package:movie_flix/core/repository/model/top_rated_model.dart';

abstract class MoviesRepo{
  Future<List<Result>?> getNowPlaying();
  Future<List<Results>?> getTopRated();
}