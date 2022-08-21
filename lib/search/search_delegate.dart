

import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String? get searchFieldLabel => 'Search Movies';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '', 
        icon: const Icon( Icons.clear )
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null );
      }, 
      icon: const Icon( Icons.arrow_back )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  Widget emptyContainer() {
    return Container(
      color: null,
      child: const Center( 
        child: Icon( Icons.movie_creation_outlined, color: Colors.black38, size: 130, ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if( query.isEmpty ) {
      return emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>( context, listen: false );

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: ( _, AsyncSnapshot<List<Movie>> snapshot) {
        
        if( !snapshot.hasData ) return emptyContainer();
        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ( _, int index ) => _MovieItem( movies[index ]),
        );
      },
    );
  }
}


class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem( this.movie );
  
  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage( movie.showPosterImg ),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text( movie.title ),
      subtitle: Text( movie.originalTitle ),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie );
      },
    );
  }  
}