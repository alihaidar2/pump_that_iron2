import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pump_that_iron/main.dart';
import 'package:pump_that_iron/models/exercise.dart';
import 'package:pump_that_iron/globals.dart' as globals;

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late Stream<List<Exercise>> streamExercises;

  @override
  void initState() {
    super.initState();
    streamExercises = objectBox.getExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<Exercise>>(
        stream: streamExercises,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final exercises = snapshot.data!;
            return ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];

                return ListTile(
                  title: Text(exercise.name!),
                  subtitle: Text(exercise.target!),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => objectBox.deleteExercise(exercise.id!),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // generate list of exercises
          final exercise = Exercise(name: "Name", target: "target", bodyPart: "bodyPart", equipment: "equipment", gifUrl: "gifUrl");
          objectBox.insertExercise(exercise);
        },
      ),
    );
  }
}
