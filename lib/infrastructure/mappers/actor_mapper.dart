

import '../../domain/entities/actor.dart';
import '../models/moviedb/credits_response.dart';

class ActorMapper {

  /// El cast es la clase que obtiene la información de los actores de la API.
  static Actor castToEntity( Cast cast ) =>
      Actor(
        id: cast.id, 
        name: cast.name, 
        profilePath: cast.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${ cast.profilePath }'
        : 'https://static.thenounproject.com/png/3918329-200.png', 
        character: cast.character,
      );
}