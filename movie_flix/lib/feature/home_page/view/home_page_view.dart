import 'package:flutter/material.dart';
import 'package:movie_flix/feature/now_playing/view/now_playing_view.dart';
import 'package:movie_flix/feature/top_rated/view/top_rated_view.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFf2bb60),
        bottomNavigationBar: TabBar(
          labelColor: Colors.black,
          indicatorColor: Color(0xFFf1b344),
          labelStyle: TextStyle(fontSize: 13),
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: "Now Playing",icon: Icon(Icons.movie_filter_outlined,size: 40,),),
            Tab(text: "Top Rated",icon: Icon(Icons.star_border_purple500,size: 40,)),

          ],
        ),
        body: TabBarView(
          children: [
            NowPlayingView(),
            TopRatedView(),
          ],
        ),
      ),
    );
  }
}
