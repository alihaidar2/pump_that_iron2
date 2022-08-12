import 'package:objectbox/objectbox.dart';

import 'exercise.dart';

@Entity()
@Sync()
class Workout {
  int? id;
  final List<Set>? sets;
  // add a date that will just be the current date and time

  Workout({
    this.id = 0,
    required this.sets,
  });
}
