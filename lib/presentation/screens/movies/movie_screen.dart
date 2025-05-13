import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String routeName = 'movie-screen';
  final String movieId;

  const MovieScreen({
    super.key, 
    required this.movieId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }
  @override
  Widget build(BuildContext context) {
    /// final Map<String, Movie> movies = ref.watch(movieInfoProvider);
    /// final movie = movies[widget.movieId];
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2,),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('MovieId: ${widget.movieId}'),
      ),
      body: const Center(child: Text('Hello from MovieScreen')),
    );
  }
}