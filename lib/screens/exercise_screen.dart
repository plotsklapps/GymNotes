import 'package:gymnotes/all_imports.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({
    Key? key,
    required this.muscleGroup,
  }) : super(key: key);

  final String muscleGroup;

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late final TextEditingController exerciseCtrl;

  List<String> getExercisesList() {
    switch (widget.muscleGroup) {
      case 'Chest':
        return chestExercises;
      case 'Back':
        return backExercises;
      case 'Legs':
        return legExercises;
      case 'Shoulders':
        return shoulderExercises;
      case 'Biceps':
        return bicepsExercises;
      case 'Triceps':
        return tricepsExercises;
      case 'Abs':
        return absExercises;
      default:
        return [];
    }
  }

  @override
  void initState() {
    exerciseCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    exerciseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add Exercise'),
                    content: TextField(
                      controller: exerciseCtrl,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Exercise',
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          exerciseCtrl.clear();
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Add'),
                        onPressed: () {
                          getExercisesList().add(exerciseCtrl.text);
                          setState(() {});
                          exerciseCtrl.clear();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: getExercisesList()
              .map(
                (exercise) => Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeightRepsScreen(
                            muscleGroup: widget.muscleGroup,
                            exercise: exercise,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          exercise,
                          style: const TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
