import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../config/helpers/human_formats.dart';
import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({required this.searchMovies});

  void clearStreams() {
    debouncedMovies.close();
  }

  void _onQueryChanged(String query) {
    debugPrint('Query string cambio');
    //isLoadingStream.add(true);

    //Si el timer es activo, lo cancelo/limpio
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    // Espera 500ms para emitir el nuevo valor (es decir cuando el usuario deja de escribir durando 500ms)
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      debugPrint(
        'Busncando peliculas, esto hara que se llame al searchMovies y se redibuje el stream',
      );
      if (query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }

      final movies = await searchMovies(query);
      // initialMovies = movies;
      debouncedMovies.add(movies);
      // isLoadingStream.add(false);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        clearStreams();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return StreamBuilder(
      //future: searchMovies(query),
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        /// Quiero ver cuantas veces se llama a esta función, deberia ser una sola vez
        //debugPrint('reconstrucciones del stream builder basadi en el debouncedMovies.stream');
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, inndex) {
            final movie = movies[inndex];

            return _MovieItem(
              movie: movie, 
              onMovieSelected: (context, movie){
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder:
                      (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),

                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),

                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!.copyWith(
                          color: Colors.yellow.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
