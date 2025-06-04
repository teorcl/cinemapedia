import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, Movie> favoriteMovies = ref.watch(favoriteMoviesProvider);
    final List<Movie> moviesList = favoriteMovies.values.toList();

    return Scaffold(
      body: ListView.builder(
        itemCount: moviesList.length,
        itemBuilder: (context, index) {
          final Movie movie = moviesList[index];

          return ListTile(
            title: Text('Favorite Movie ${movie.title}'),
            onTap: () {
              // Handle favorite movie tap
            },
          );
        },
      ),
    );
  }
}
