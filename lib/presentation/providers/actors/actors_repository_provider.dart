import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/actor_moviedb_datasource.dart';
import '../../../infrastructure/repositories_impl/actors_repository_impl.dart';

final Provider<ActorsRepositoryImpl> actorsRepositoryProvider =
    Provider<ActorsRepositoryImpl>((ref) {
  return ActorsRepositoryImpl(ActorMoviedbDatasource());
});