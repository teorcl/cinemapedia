import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../providers.dart';

/// Notese final moviesSlideshowPrivder = Provider<List<Movie>>((ref), la palabra Provider
/// en la asignacion de la variable es un Provider, no un StateNotifierProvider, eso es lo que lo hace
/// un provider de solo lectura, no un provider de estado.

final moviesSlideshowPrivder = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];
  return nowPlayingMovies.sublist(
    0,
    nowPlayingMovies.length > 6
        ? 6
        : nowPlayingMovies
            .length, //Esto es para que no de error si hay menos de 6 peliculas
  );
});

/// Este provider siempre me va a dar la lista de las primeras 6 peliculas que tengo en el nowPlayingMovies
