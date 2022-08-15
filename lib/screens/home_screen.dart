import 'package:flutter/material.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final moviesProviders = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies Times - Theatres'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon( Icons.search_outlined )
          )
        ], 
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Main Card
            CardSwiper(movies: moviesProviders.onDisplayMovies ),
            
            //Slider movies
            const MovieSlider(),
          ],
        ),
      )
    );
  }
}