import 'package:objectbox/objectbox.dart';

import 'exercise.dart';

@Entity()
@Sync()
class Set {
  int? id;
  final Exercise exercise;
  final int reps;

  Set({
    this.id = 0,
    required this.exercise,
    required this.reps
  });
}
