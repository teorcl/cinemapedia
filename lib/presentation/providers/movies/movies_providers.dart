import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../providers.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<
  MoviesNotifier,
  List<Movie>
>((ref) {
  final fetchMoreMovies =
      ref
          .watch(movieRepositoryProvider)
          .getNowPlaying; //Aqui solo se obtiene la referencia a la funcion getNowPlaying

  // Retorna el notifier osea la clase que extiende de StateNotifier
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    // state <----- List<Movie>
    currentPage++;

    //Aqui se hace el llamado a la funcion
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // state = <----- En este punto es una lista vacia, por la inicializacion en el constructor
    state = [...state, ...movies]; // Estoy actualizando el estado
  }
}
