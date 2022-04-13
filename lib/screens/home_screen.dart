import 'package:gymnotes/all_imports.dart';
import 'package:gymnotes/services/setnotes_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String get userEmail => currentUser!.email!;

  @override
  void dispose() {
    SetNotesService().closeDatabaseSetNotes();
    super.dispose();
  }

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
      body: FutureBuilder(
        future: SetNotesService().getOrCreateDatabaseUser(
          email: userEmail,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                stream: SetNotesService().allSetNotes,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              strokeWidth: 12.0,
                            ),
                            SizedBox(height: 24.0),
                            Text('Fetching your GymNotes...'),
                          ],
                        ),
                      );
                    default:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}