import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/feature/movie_detail/view/movie_detail_view.dart';
import 'package:movie_flix/feature/top_rated/controller/top_rated_controller.dart';
class TopRatedView extends StatefulWidget {

  @override
  State<TopRatedView> createState() => _TopRatedViewState();
}

class _TopRatedViewState extends State<TopRatedView> {
  final poster = "https://image.tmdb.org/t/p/w342/" ;

  String inputText = "";
  bool focusField = false;
  TextEditingController inputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(TopRatedController());
    final controller = Get.find<TopRatedController>();
    return Scaffold(
      backgroundColor: Color(0xFFf1b344),
      appBar: AppBar(
        title: Container(
          height: 40,
          child: FocusScope(
            child: Focus(
                onFocusChange: (focus) {
                  setState(() {
                    focusField = focus;
                  });
                },
                child: _searchBar()
            ),
          ),
        ),
        actions: [
          focusField == true ?   TextButton(
              child: Text('Cancel',style: TextStyle(color: Colors.blueGrey,fontSize: 15),),
              onPressed: () {
                setState(() {
                  controller.loadTopRated();
                  inputText = "";
                  inputTextController.clear();
                  FocusScope.of(context).unfocus();
                });
              }
          ) :
          SizedBox() // Obx expects a widget in return
        ],
      ),
      body: Obx((){
        return controller.isLoading.isTrue ? Center(child: CircularProgressIndicator(color: Colors.blueGrey,),) :
        RefreshIndicator(
          onRefresh: (){
            return Future.delayed(
                Duration(seconds: 1),
                    (){
                  controller.loadTopRated();
                }
            );
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: ListView.separated(
                itemBuilder: (context , index){
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction){
                      controller.deleteTopRated(index);
                    },
                    child: InkWell(
                      onTap: (){
                        Get.to(()=>MovieDetailView(),arguments: [
                          controller.result![index],

                        ]);
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                                height: 170,
                                child: Image.network(poster+controller.result![index].posterPath!,)
                            ),
                            Expanded(
                              child: Container(
                                height: 170,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.result![index].title!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(controller.result![index].overview!,maxLines: 5,overflow: TextOverflow.ellipsis,)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context , index) => Divider(),
                itemCount: controller.result!.length),
          ),
        );
      }),
    );
  }



  _searchBar(){
    final controller = Get.find<TopRatedController>();
    return TextFormField(
      controller: inputTextController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search,color: Colors.grey,),
        suffixIcon: inputText.isNotEmpty ? GestureDetector(
          onTap: (){
            controller.loadTopRated();
            setState(() {
              inputTextController.clear();
              inputText = "";
            });
          },
          child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:Colors.grey,
              ),
              child: Icon(Icons.close,color: Colors.white,size: 15,)),
        ) : null,
        filled: true,
        fillColor : Colors.white,
        hintText: "Search",
        hintStyle: TextStyle(fontSize: 13),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(50)
        ),
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(50)
        ),
      ),
      onChanged: (value){
        inputText = value;
        controller.filterTopRated(value);

        if(inputText.length == 0 || inputText.length == 1 )
          setState(() {});
      },
    );
  }



}
