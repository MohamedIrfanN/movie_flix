import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/feature/home_page/view/home_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(

          primary: const Color(0xFFf2bb60),

        ),
      ),
      getPages: [
        GetPage(name: "/home_page", page: ()=>HomePageView(),)
      ],
      initialRoute: "/home_page",
      //initialBinding: NowPlayingBinding(),

    );
  }
}

