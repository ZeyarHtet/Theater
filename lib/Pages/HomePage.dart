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
  List movieList = [];
  @override
  void initState() {
    getMovie();
    super.initState();
  }

  getMovie() async {
    var response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=050c28541f900007285c3020069bfd62&language=en-US&page=1',
      ),
    );
    if (response.statusCode == 200) {
      var movieResponse = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        for (var i = 0; i < movieResponse['results'].length; i++) {
          movieList.add({
            "title": movieResponse['results'][i]['original_title'],
            "image":
                "https://image.tmdb.org/t/p/w500${movieResponse['results'][i]['poster_path']}",
            "id": movieResponse['results'][i]['id'],
          });
          setState(() {});
        }
        print(">>>>>>>>>>>>>>>>>>> movielist : $movieList");
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
            movieList.isEmpty
                ? Container()
                : MovieList(movieList: movieList, title: "Now Playing"),
          ],
        ),
      ),
    );
  }
}
