import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zeyar_movies/Widget/movie_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List now_playing_movieList = [];
  List up_coming_movieList = [];
  List top_rated_movieList = [];

  @override
  void initState() {
    getNowPlayingMovie();
    getTopRatedMovie();
    getUpComingMovie();
    super.initState();
  }

  getNowPlayingMovie() async {
    var response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=050c28541f900007285c3020069bfd62&language=en-US&page=1'),
    );
    if (response.statusCode == 200) {
      var movieResponse = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        for (var i = 0; i < movieResponse['results'].length; i++) {
          now_playing_movieList.add({
            "title": movieResponse['results'][i]['original_title'],
            "image":
                "https://image.tmdb.org/t/p/w500${movieResponse['results'][i]['poster_path']}",
            "id": movieResponse['results'][i]['id'],
          });
          setState(() {});
        }
        print(
            ">>>>>>>>>>>>>>>>>>> now_playing_movieList : $now_playing_movieList");
      });
    } else {
      print("something wrong....");
      print(response.statusCode);
    }
    setState(() {});
  }

  getTopRatedMovie() async {
    var response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=050c28541f900007285c3020069bfd62&language=en-US&page=1'),
    );
    if (response.statusCode == 200) {
      var movieResponse = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        for (var i = 0; i < movieResponse['results'].length; i++) {
          top_rated_movieList.add({
            "title": movieResponse['results'][i]['original_title'],
            "image":
                "https://image.tmdb.org/t/p/w500${movieResponse['results'][i]['poster_path']}",
            "id": movieResponse['results'][i]['id'],
          });
          setState(() {});
        }
        print(">>>>>>>>>>>>>>>>>>> top_rated_movieList : $top_rated_movieList");
      });
    } else {
      print("something wrong....");
      print(response.statusCode);
    }
    setState(() {});
  }

  getUpComingMovie() async {
    var response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=050c28541f900007285c3020069bfd62&language=en-US&page=1'),
    );
    if (response.statusCode == 200) {
      var movieResponse = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        for (var i = 0; i < movieResponse['results'].length; i++) {
          up_coming_movieList.add({
            "title": movieResponse['results'][i]['original_title'],
            "image":
                "https://image.tmdb.org/t/p/w500${movieResponse['results'][i]['poster_path']}",
            "id": movieResponse['results'][i]['id'],
          });
          setState(() {});
        }
        print(">>>>>>>>>>>>>>>>>>> upcoming_movieList : $up_coming_movieList");
      });
    } else {
      print("something wrong....");
      print(response.statusCode);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Movies",
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            now_playing_movieList.isEmpty
                ? Container()
                : MovieList(
                    movieList: now_playing_movieList,
                    title: "Now Playing",
                  ),
            top_rated_movieList.isEmpty
                ? Container()
                : MovieList(
                    movieList: top_rated_movieList,
                    title: "Top Rated",
                  ),
            up_coming_movieList.isEmpty
                ? Container()
                : MovieList(
                    movieList: top_rated_movieList,
                    title: "Upcoming",
                  ),
          ],
        ),
      ),
    );
  }
}
