import 'package:gymnotes/all_imports.dart';

class WeightRepsScreen extends StatefulWidget {
  const WeightRepsScreen({
    Key? key,
    required this.muscleGroup,
    required this.exercise,
    required this.position,
    required this.weapon,
  }) : super(key: key);

  final String muscleGroup;
  final String exercise;
  final String position;
  final String weapon;

  @override
  State<WeightRepsScreen> createState() => _WeightRepsScreenState();
}

class _WeightRepsScreenState extends State<WeightRepsScreen> {
  late final TextEditingController _weightCtrl;
  late final TextEditingController _repsCtrl;

  @override
  void initState() {
    _weightCtrl = TextEditingController();
    _repsCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _weightCtrl.dispose();
    _repsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> workoutSetList = [
      Card(
        child: ListTile(
          leading: const Icon(
            Icons.fitness_center,
            size: 32.0,
          ),
          title: Text(widget.muscleGroup),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${widget.exercise}\n${widget.position}\n${widget.weapon}}',
              ),
              Text('Weight: ${_weightCtrl.text}\nReps: ${_repsCtrl.text}'),
            ],
          ),
          dense: false,
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight & Reps'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.timer),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Current set:'),
                  const SizedBox(width: 8.0),
                  Text(
                    widget.muscleGroup +
                        ' ' +
                        widget.exercise +
                        ' ' +
                        widget.position +
                        ' ' +
                        widget.weapon,
                  ),
                ],
              ),
              const Divider(
                thickness: 3.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          int weight = int.parse(_weightCtrl.text);
                          setState(() {
                            weight--;
                            _weightCtrl.text = weight.toString();
                          });
                        },
                        onLongPress: () {
                          int weight = int.parse(_weightCtrl.text);
                          setState(() {
                            weight = weight - 10;
                            _weightCtrl.text = weight.toString();
                          });
                        },
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    const SizedBox(width: 24.0),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _weightCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Weight (kg)',
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24.0),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          int weight = int.parse(_weightCtrl.text);
                          setState(() {
                            weight++;
                            _weightCtrl.text = weight.toString();
                          });
                        },
                        onLongPress: () {
                          int weight = int.parse(_weightCtrl.text);
                          setState(() {
                            weight = weight + 10;
                            _weightCtrl.text = weight.toString();
                          });
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 3.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          int reps = int.parse(_repsCtrl.text);
                          setState(() {
                            reps--;
                            _repsCtrl.text = reps.toString();
                          });
                        },
                        onLongPress: () {
                          int reps = int.parse(_repsCtrl.text);
                          setState(() {
                            reps = reps - 10;
                            _repsCtrl.text = reps.toString();
                          });
                        },
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    const SizedBox(width: 24.0),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _repsCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Reps',
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24.0),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          int reps = int.parse(_repsCtrl.text);
                          setState(() {
                            reps++;
                            _repsCtrl.text = reps.toString();
                          });
                        },
                        onLongPress: () {
                          int reps = int.parse(_repsCtrl.text);
                          setState(() {
                            reps = reps + 10;
                            _repsCtrl.text = reps.toString();
                          });
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 3.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const SizedBox(
                      width: 150.0,
                      child: Text(
                        'ADD SET',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: workoutSetList.length,
                itemBuilder: (context, index) {
                  return workoutSetList[index];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
