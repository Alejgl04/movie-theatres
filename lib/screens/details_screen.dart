import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(movie),
                _Overview(movie),
                _Overview(movie),
                _Overview(movie),
                CastingCards( movie.id )

              ]
            ),
          ),

        ],
      ), 
    
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar(this.movie);


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.orange,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: Colors.black12,
          width: double.infinity,
          padding: const EdgeInsets.only( bottom: 10, left: 10, right: 10 ),
          alignment: Alignment.bottomCenter,
          child: Text(movie.title, style: const TextStyle( fontSize: 16 ), textAlign: TextAlign.center ),
        ),

        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'), 
          image: NetworkImage(movie.showBackDropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only( top: 20 ),
      padding: const EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.showPosterImg),
              height: 150,
              width: 110,
            ),
          ),
          const SizedBox( width: 20 ),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2 ),
                Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2 ),
                
                Row(
                  children:  [
                    const Icon( Icons.star_outline, size: 15, color: Colors.yellow),
                    const SizedBox( width: 5 ),
                    Text('${movie.voteAverage}', style: textTheme.caption )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview(this.movie);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: null,
      padding: const EdgeInsets.symmetric( horizontal: 25, vertical: 15 ),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
        )
    );
  }
}