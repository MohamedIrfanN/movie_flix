import 'package:get/get.dart';
import 'package:movie_flix/core/repository/model/now_playing_model.dart';
import 'package:movie_flix/core/repository/movies_repo.dart';
import 'package:movie_flix/core/repository/movies_repo_impl.dart';

class NowPlayingController extends GetxController{

  late MoviesRepo _moviesRepo;
  NowPlayingController(){
    _moviesRepo = Get.find<MoviesRepoImpl>();
    loadNowPlaying();
  }
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
 // RxString inputText = "".obs;


  RxList<Result>? result;
  RxList<Result>? resultCopy;

  loadNowPlaying() async{

    showLoading();

    final movieResult = await _moviesRepo.getNowPlaying();

    hideLoading();

    if(movieResult != null){
      result = movieResult.obs;
      resultCopy = movieResult.obs;
    }
    else{
      print("No Data Received");
    }

  }

  filterNowPlaying(String query) {

    showLoading();

    result = resultCopy;

    hideLoading();

    final filteredResult = result!.where((item) => item.title!.toLowerCase().contains(query.toLowerCase())).toList();

    result = filteredResult.obs;

  }

  deleteNowPlaying(int index){

    result = resultCopy;

    showLoading();

    result!.removeAt(index);

    hideLoading();
  }

  showLoading(){
    isLoading.toggle();
  }

  hideLoading(){
    isLoading.toggle();
  }


}