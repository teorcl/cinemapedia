import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';
import '../../delegates/search_movie_delegate.dart';
import '../../providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.movie_filter, color: colors.primary),

              const SizedBox(width: 5),

              Text('Cinemapedia', style: titleStyle),

              const Spacer(),

              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  
                  final movieRepository = ref.read(movieRepositoryProvider);

                  showSearch<Movie?>(
                    context: context, 
                    delegate: SearchMovieDelegate(
                      searchMovies: movieRepository.searchMovies,
                      // searchMovies: (query) async {
                      //   return await movieRepository.searchMovies(query);
                      // },
                    ),
                  ).then((movie){
                    if (movie == null) return;
                    debugPrint('Movie: ${movie.title}');
                      
                    if (context.mounted) {
                      context.push('/movie/${movie.id}');
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
