import '../providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/movie.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch( movieRepositoryProvider ); /// Esto es porque necesito la dependencia del Repository
  return MovieMapNotifier(getMovie: movieRepository.getMovieById );
});


/*
El state es un mapa de peliculas, donde la llave es el id de la pelicula y el valor es una instanica de la pelicula.
  {
    '505642': Movie(),
    '505643': Movie(),
    '505645': Movie(),
    '501231': Movie(),
  }
*/

typedef GetMovieCallback = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String,Movie>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }): super({});


  Future<void> loadMovie( String movieId ) async {
    if ( state[movieId] != null ) return;
    final movie = await getMovie( movieId );
    state = { ...state, movieId: movie };
  }

}