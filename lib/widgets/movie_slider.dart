import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';


class MovieSlider extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  const MovieSlider({
    Key? key, 
    required this.movies, this.title,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 260,
      color: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if( title != null )
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20 ),
              child: Text(title!, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold )),
            ),
          
          const SizedBox( height: 10 ),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: ( _, int index) => _MoviesPoster(movies[index])
            ),
          )

        ],
      ),
    );
  }
}

class _MoviesPoster extends StatelessWidget {

  final Movie movie;

  const _MoviesPoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed( context, 'details', arguments: 'movie-instance' ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.showPosterImg),
                width: 130,
                height: 170,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox( height: 5 ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}