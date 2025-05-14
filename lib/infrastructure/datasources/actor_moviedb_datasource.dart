import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../../domain/datasources/actors_datasource.dart';
import '../../domain/entities/actor.dart';
import '../mappers/actor_mapper.dart';
import '../models/moviedb/credits_response.dart';

class ActorMoviedbDatasource implements ActorsDatasource {
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
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final json = response.data;
    final creditsResponse = CreditsResponse.fromJson(json);
    final List<Actor> actors = creditsResponse.cast
        .map(
          (itemCast) => ActorMapper.castToEntity(itemCast),
        )
        .toList();

    return actors;
  }
}
