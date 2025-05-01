import '../../domain/datasources/movies_datasources.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movies_repository.dart';

/// Esta clase es la implementación de la interfaz MoviesRepository, de la capa de dominio.

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesDatasource datasource; // capa de dominio

  MoviesRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final movies = await datasource.getNowPlaying(page: page);
    return movies;
  }
}
