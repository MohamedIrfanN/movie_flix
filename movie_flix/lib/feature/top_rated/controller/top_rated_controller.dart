import 'package:get/get.dart';
import 'package:movie_flix/core/repository/model/top_rated_model.dart';
import 'package:movie_flix/core/repository/movies_repo.dart';
import 'package:movie_flix/core/repository/movies_repo_impl.dart';

class TopRatedController extends GetxController{

  late MoviesRepo _moviesRepo;
  TopRatedController(){
    _moviesRepo = Get.find<MoviesRepoImpl>();
    loadTopRated();
  }
  RxBool isLoading = false.obs;


  RxList<Results>? result;
  RxList<Results>? resultCopy;


  loadTopRated() async{

    showLoading();

    final movieResult = await _moviesRepo.getTopRated();

    hideLoading();

    if(movieResult != null){
      result = movieResult.obs;
      resultCopy = movieResult.obs;
    }
    else{
      print("No Data Received");
    }

  }


  filterTopRated(String query) {

    showLoading();

    result = resultCopy;

    hideLoading();

    final filteredResult = result!.where((item) => item.title!.toLowerCase().contains(query.toLowerCase())).toList();

    result = filteredResult.obs;

  }


  deleteTopRated(int index){

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