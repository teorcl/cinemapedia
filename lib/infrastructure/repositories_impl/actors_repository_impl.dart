import '../../domain/datasources/actors_datasource.dart';
import '../../domain/entities/actor.dart';
import '../../domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl implements ActorsRepository {

  final ActorsDatasource datasource; // capa de dominio

  ActorsRepositoryImpl(this.datasource); 

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final List<Actor> actors = await datasource.getActorsByMovie(movieId);
    return actors;
  }
}