import 'package:flutter/material.dart';
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

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getTopRated;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});    

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  bool _isLoading = false; //<-- evita multiple peticiones a la API
  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (_isLoading) return;

    _isLoading = true;
    debugPrint('Cargando siguiente pagina');

    // state <----- List<Movie>
    currentPage++;

    //Aqui se hace el llamado a la funcion
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // state = <----- En este punto es una lista vacia, por la inicializacion en el constructor
    state = [...state, ...movies]; // Estoy actualizando el estado

    await Future.delayed(const Duration(milliseconds: 300));
    _isLoading = false;
  }
}
