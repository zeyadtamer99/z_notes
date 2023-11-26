import 'package:get_it/get_it.dart';

import 'repositories/notes_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<NotesRepository>(() => NotesRepositoryImpl());
}
