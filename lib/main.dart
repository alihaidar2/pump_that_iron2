 import 'package:flutter/material.dart';
import 'package:pump_that_iron/services/object_box.dart';
import 'package:pump_that_iron/pages/database_example_page.dart';
import 'package:pump_that_iron/pages/exercise_list_page.dart';

import 'package:pump_that_iron/services/api_service.dart';
import 'package:pump_that_iron/widgets/ExerciseRow.dart';

import 'models/exercise.dart';

late ObjectBox objectBox;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pump That Iron'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              // dont need the message, but it is used if you want to return something from that page
              onPressed: () async {
                var message = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const ExerciseListPage(title: 'Exercise List Page');
                }));
                print(message);
              },
              child: const Text("Next"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const DatabaseExamplePage(title: 'Database Example Page');
                  }));
                },
                child: const Text("To Database Page"))
          ],
        ),
      ),
    );
  }
}
