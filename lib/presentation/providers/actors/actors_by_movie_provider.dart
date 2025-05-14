import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/actor.dart';
import '../providers.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsNotifier, List<Actor>>((ref) {
  final fetchActors = ref.watch(actorsRepositoryProvider).getActorsByMovie;
  return ActorsNotifier(fetchActors: fetchActors);
});

typedef ActorCallback = Future<List<Actor>> Function(String movieId);

class ActorsNotifier extends StateNotifier<List<Actor>> {
  ActorCallback fetchActors;

  ActorsNotifier({required this.fetchActors}) : super([]);

  Future<void> loadActors(String movieId) async {

    // state <----- List<Actor>

    final List<Actor> actors = await fetchActors(movieId);

    // state = <----- En este punto es una lista vacia, por la inicializacion en el constructor
    state = [...state, ...actors]; // Estoy actualizando el estado
  }
}