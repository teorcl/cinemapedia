import '../../domain/datasources/local_storage_datasource.dart';
import '../../domain/entities/movie.dart';

class IsarDatasource extends LocalStorageDatasource {
  @override
  Future<bool> isMovieFavorite(int movieId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    throw UnimplementedError();
  }
}
