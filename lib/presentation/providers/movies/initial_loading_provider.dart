import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

final initialLoadingProvider = Provider<bool>(
  (ref) {
    /// Este provider se encarga de condicionar el loader en la pantalla de home
    
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
    final popularMovies = ref.watch(popularMoviesProvider).isEmpty;
    final upcomingMovies = ref.watch(upcomingMoviesProvider).isEmpty;
    final topRatedMovies = ref.watch(topRatedMoviesProvider).isEmpty;

    if (nowPlayingMovies) return true;
    if (popularMovies) return true;
    if (upcomingMovies) return true;
    if (topRatedMovies) return true;

    return false;
  },
);