import 'package:gymnotes/all_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

String get userEmail => FirebaseService.currentUser!.email!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GymNotes'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'GymNotes',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Account'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'account_screen',
                );
              },
            ),
            ListTile(
              title: const Text('Sign out'),
              onTap: () async {
                await FirebaseService().signOut(
                  context,
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Welcome to Gymnotes!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'musclegroup_screen',
                );
              },
              child: const Text('Start New Workout'),
            ),
          ],
        ),
      ),
    );
  }
}
