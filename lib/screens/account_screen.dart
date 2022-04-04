import 'package:gymnotes/all_imports.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Column(
        children: const [
          ListTile(
            title: Text('Name'),
            subtitle: Text('John Doe'),
          ),
          ListTile(
            title: Text('Email'),
            subtitle: Text('name@email.com'),
          ),
          ListTile(
            title: Text('Age'),
            subtitle: Text('38'),
          ),
          ListTile(
            title: Text('Height'),
            subtitle: Text('1.81m'),
          ),
          ListTile(
            title: Text('Weight'),
            subtitle: Text('87kg'),
          ),
        ],
      ),
    );
  }
}
