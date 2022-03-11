import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class MovieDetailView extends StatefulWidget {
  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  ScrollController scrollController = ScrollController();

  double yOffset = 0.0;

  final poster = "https://image.tmdb.org/t/p/w342/" ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Row(
            children: [
              SizedBox(width: 10,),
              Icon(Icons.arrow_back_ios,color: Colors.blueGrey,size: 20,),
              Text("Back",style: TextStyle(color: Colors.blueGrey,fontSize: 16),)
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child:Image.network(poster+Get.arguments[0].posterPath,fit: BoxFit.cover,)
          ),
          Positioned(
            bottom: -50,
            left: 0,
            right: 0,
            child: GestureDetector(
              onPanUpdate: (details) {

                if (details.delta.dy < 0) {
                  setState(() {
                    yOffset = -200.0;
                  });


                }
              },
              child: AnimatedContainer(
                onEnd: (){
                  setState(() {
                    yOffset=-50.0;
                  });
                },
                transform: Matrix4.translationValues(0.0, yOffset, 0.0)..scale(1.0),
                margin:  EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 40),
                color: Colors.black.withOpacity(0.7),
                duration: Duration(milliseconds: 150),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(Get.arguments[0].title,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),),
                      SizedBox(height: 20,),
                      Text("${DateFormat('MMMM  dd, yyyy').format(Get.arguments[0].releaseDate)}",style: TextStyle(color: Colors.grey[400],fontSize: 15,fontWeight: FontWeight.w500)),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Icon(MdiIcons.crown,color: Colors.white,),
                          SizedBox(width: 10,),
                          Text("${Get.arguments[0].voteAverage.toString()}%",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text(Get.arguments[0].overview,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500))

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
