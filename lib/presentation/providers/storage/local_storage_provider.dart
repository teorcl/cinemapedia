import '../../../infrastructure/datasources/isar_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/repositories_impl/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider<LocalStorageRepositoryImpl>((
  ref,
) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
