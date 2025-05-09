import '../../domain/entities/movie.dart';
import '../models/moviedb/movie_moviedb.dart';

/// Su objetivo es convertir los datos de la API en objetos de dominio (entidades).
/// Esto permite que la lógica de negocio no dependa de la estructura de datos de la API.
/// En este caso, la clase `MovieMapper` convierte un mapa de datos de una película
/// en un objeto de dominio `Movie`.
///

class MovieMapper {
  /// Covierte el DTO de la capa de infraestructura a la entidad de dominio.
  /// El DTO es el objeto de transferencia de datos que se recibe de la API.
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath:
        (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath:
        (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'no-poster',
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
  );
}
