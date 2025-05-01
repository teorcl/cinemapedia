import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../../domain/datasources/movies_datasources.dart';
import '../../domain/entities/movie.dart';
import '../mappers/movie_mapper.dart';
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

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      //queryParameters: {'page': page},
    );

    /// convierte la response a un DTO de la capa de infraestructura
    /// y luego lo convierte a una entidad de dominio
    /// y lo devuelve como una lista de entidades de dominio

    final json = response.data;
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies =
        movieDBResponse.results
            .where(
              (movieMovieDB) => movieMovieDB.posterPath != 'no-poster',
            ) // Esto porque deseo como regla de negocio no mostrar las peliculas que no tienen poster
            .map((movieMovieDB) => MovieMapper.movieDBToEntity(movieMovieDB))
            .toList();

    return movies;
  }
}
