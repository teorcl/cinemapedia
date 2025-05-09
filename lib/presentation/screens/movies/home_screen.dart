import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    /// Este llamado se hace para que al iniciar la pantalla se carguen los datos, es decir se cambie el estado
    /// de la lista vacia a una lista con los datos
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowPrivder);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                //const CustomAppbar(),

                ///Widget customizado para mostrar el Slideshow de las peliculas
                MoviesSlideshow(movies: moviesSlideshow),

                /// Widget customizado para mostrar la lista horizontal de peliculas
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subtitle: 'Lunes 12',
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                  //loadNextPage: ref.read(nowPlayingMoviesProvider.notifier).loadNextPage, usar las que mas se entienda
                  //loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(), usar las que mas se entienda
                ),

                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'Próximamente',
                  subtitle: 'En este mes',
                  loadNextPage:
                      () =>
                          ref
                              .read(nowPlayingMoviesProvider.notifier)
                              .loadNextPage(),
                ),

                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'Populares',
                  // subTitle: '',
                  loadNextPage:
                      () =>
                          ref
                              .read(nowPlayingMoviesProvider.notifier)
                              .loadNextPage(),
                ),

                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'Mejor calificadas',
                  subtitle: 'Desde siempre',
                  loadNextPage:
                      () =>
                          ref
                              .read(nowPlayingMoviesProvider.notifier)
                              .loadNextPage(),
                ),

                const SizedBox(height: 10),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
