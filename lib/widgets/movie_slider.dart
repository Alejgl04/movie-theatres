import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';


class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key, 
    required this.movies,
    required this.onNextPage,
    this.title, 
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollControler = ScrollController();
  @override
  void initState() {
    super.initState();

    scrollControler.addListener(() {

      if ( scrollControler.position.pixels >= scrollControler.position.maxScrollExtent - 500 ) {
        widget.onNextPage();
      }

    });

  }

  @override
  void dispose() {
    super.dispose();

  }
  
  @override
  Widget build(BuildContext context) {
    if( widget.movies.isEmpty ) {
      return Container(
        color: null,
        width: double.infinity,
        height: 260,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return Container(
      width: double.infinity,
      height: 260,
      color: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if( widget.title != null )
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20 ),
              child: Text(widget.title!, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold )),
            ),
          
          const SizedBox( height: 10 ),

          Expanded(
            child: ListView.builder(
              controller: scrollControler,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _, int index) => _MoviesPoster(widget.movies[index], '${widget.title}-$index-${widget.movies[index].id}')
            ),
          )

        ],
      ),
    );
  }
}

class _MoviesPoster extends StatelessWidget {

  final Movie movie;
  final String heroId;
  const _MoviesPoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;
    
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed( context, 'details', arguments: movie ),
            child: Hero(
              tag: movie.heroId!,
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