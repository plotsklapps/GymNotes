import 'package:gymnotes/all_imports.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  //TODO: Get these from Firebase!
  late String name = 'John Doe';
  late int age = 25;
  late double height = 1.81;
  late double weight = 80.0;
  //TODO: Make these private!
  late final TextEditingController nameCtrl;
  late final TextEditingController ageCtrl;
  late final TextEditingController heightCtrl;
  late final TextEditingController weightCtrl;

  @override
  void initState() {
    nameCtrl = TextEditingController();
    ageCtrl = TextEditingController();
    heightCtrl = TextEditingController();
    weightCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    ageCtrl.dispose();
    heightCtrl.dispose();
    weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text(
              'Name',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              name,
              style: const TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Name'),
                    content: TextField(
                      controller: nameCtrl,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(hintText: 'John Doe'),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          name = nameCtrl.text;
                          nameCtrl.clear();
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: const Text(
              'Age',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              age.toString(),
              style: const TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Age'),
                    content: TextField(
                      controller: ageCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(hintText: '25'),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          age = int.parse(ageCtrl.text);
                          ageCtrl.clear();
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: const Text(
              'Height',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              height.toString(),
              style: const TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Height'),
                    content: TextField(
                      controller: heightCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(hintText: '1.80'),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          height = double.parse(heightCtrl.text);
                          heightCtrl.clear();
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: const Text(
              'Weight',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              weight.toString(),
              style: const TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Weight'),
                    content: TextField(
                      controller: weightCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(hintText: '75.0'),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          weight = double.parse(weightCtrl.text);
                          weightCtrl.clear();
                          setState(() {});
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
    );
  }
}
