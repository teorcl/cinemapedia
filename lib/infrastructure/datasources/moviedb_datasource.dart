import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../../domain/datasources/movies_datasources.dart';
import '../../domain/entities/movie.dart';
import '../mappers/movie_mapper.dart';
import '../models/moviedb/movie_details.dart';
import '../models/moviedb/moviedb_response.dart';

/// Esta clase es la implementación de la interfaz MoviesDatasource, de la capa de dominio.

class MoviedbDatasource implements MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDBApiKey,
        'language': 'es-ES',
      },
    ),
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies =
        movieDBResponse.results
            .where((moviedb) => moviedb.posterPath != 'no-poster')
            .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
            .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    /// convierte la response a un DTO de la capa de infraestructura
    /// y luego lo convierte a una entidad de dominio
    /// y lo devuelve como una lista de entidades de dominio

    final json = response.data;
    return _jsonToMovies(json);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    final json = response.data;
    return _jsonToMovies(json);
  }

  @override
  Future<List<Movie>> getUpcomming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    final json = response.data;
    return _jsonToMovies(json);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    final json = response.data;
    return _jsonToMovies(json);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    if (response.statusCode != 200) {
      throw Exception('La película no con el id $id, no fue encontrada');
    }

    final json = response.data;
    final MovieDetails movieDB = MovieDetails.fromJson(json);

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDB);
    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final response = await dio.get(
      '/search/movie',
      queryParameters: {
        'query': query,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('La película $query, no fue encontrada');
    }
    final json = response.data;
    return _jsonToMovies(json);
  }
}
