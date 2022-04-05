import 'package:gymnotes/all_imports.dart';

class MuscleGroupScreen extends ConsumerStatefulWidget {
  const MuscleGroupScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MuscleGroupScreenState();
}

class _MuscleGroupScreenState extends ConsumerState<MuscleGroupScreen> {
  List<String> muscleGroupList = [
    'Chest',
    'Back',
    'Legs',
    'Shoulders',
    'Biceps',
    'Triceps',
    'Abs',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MuscleGroups'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: muscleGroupList
            .map((muscleGroup) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      4.0,
                      16.0,
                      4.0,
                    ),
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          if (muscleGroup == 'Chest') {
                            print(muscleGroup);
                          }
                          //TODO: Continue with RIVERPOD here!
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      0.0,
                                      12.0,
                                      12.0,
                                      0.0,
                                    ),
                                    child: Text(
                                      muscleGroup,
                                      style: const TextStyle(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Icon(
                                    Icons.add,
                                    size: 40.0,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
