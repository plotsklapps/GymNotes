import 'package:gymnotes/all_imports.dart';

class WeightRepsScreen extends StatefulWidget {
  const WeightRepsScreen(
      {Key? key, required this.muscleGroup, required this.exercise})
      : super(key: key);

  final String muscleGroup;
  final String exercise;

  @override
  State<WeightRepsScreen> createState() => _WeightRepsScreenState();
}

class _WeightRepsScreenState extends State<WeightRepsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight & Reps'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text(widget.muscleGroup + ' ' + widget.exercise),
      ),
    );
  }
}
