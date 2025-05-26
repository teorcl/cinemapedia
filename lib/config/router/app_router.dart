import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:view',
      name: HomeScreen.name,
      builder: (context, state) {
        final String viewIndex = state.pathParameters['view'] ?? '0';
        /// Convertimos el viewIndex a un entero
        final int index = int.tryParse(viewIndex) ?? 0;
       
        return HomeScreen(
          viewIndex: index,
        );
      },
      routes: [
        /// Estas son las rutas hijas de la ruta principal (/)
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.routeName,
          builder: (context, state) {
            final String movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),

    GoRoute(
      path: '/',
      redirect: (_,__) => '/home/0',
    ),
  ],
);
