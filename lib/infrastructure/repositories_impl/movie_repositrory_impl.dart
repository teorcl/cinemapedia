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

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final movies = await datasource.getPopular(page: page);
    return movies;
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async{
    final movies = await datasource.getUpcomming(page: page);
    return movies;
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final movies = await datasource.getTopRated(page: page);
    return movies;
  }
  
  @override
  Future<Movie> getMovieById(String id) {
    final movie = datasource.getMovieById(id);
    return movie;
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) async{
    final movies = await datasource.searchMovies(query);
    return movies;
  }
}
