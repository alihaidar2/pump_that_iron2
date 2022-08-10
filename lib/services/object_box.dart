import 'package:objectbox/objectbox.dart';
import 'package:pump_that_iron/models/exercise.dart';

import '../objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<Exercise> _exerciseBox;

  ObjectBox._init(this._store) {
    _exerciseBox = Box<Exercise>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    final Admin admin;

    if (Admin.isAvailable()) {
      admin = Admin(store);
    }

    if (Sync.isAvailable()) {
      final syncClient = Sync.client(
        store,
        'ws://0.0.0.0:9999',
        SyncCredentials.none(),
      );
      syncClient.start();
    }

    return ObjectBox._init(store);
  }

  // CRUD methods
  Exercise? getExercise(int id) => _exerciseBox.get(id);

  Stream<List<Exercise>> getExercises() => _exerciseBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  int insertExercise(Exercise exercise) => _exerciseBox.put(exercise);

  bool deleteExercise(int id) => _exerciseBox.remove(id);
}
