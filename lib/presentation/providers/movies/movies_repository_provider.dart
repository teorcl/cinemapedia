import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/moviedb_datasource.dart';
import '../../../infrastructure/repositories_impl/movie_repositrory_impl.dart';

/// Este provider es el encargado de proveer a MoviesRepositoryImpl, por lo tanto es inmutable. Es simplemente una inyección de dependencias.
/// Es de solo lectura y no se puede modificar.
/// Donde MoviesRepositoryImpl es la implementación de la interfaz MoviesRepository.
final Provider<MoviesRepositoryImpl> movieRepositoryProvider =
    Provider<MoviesRepositoryImpl>((ref) {
      return MoviesRepositoryImpl(MoviedbDatasource());
    });
