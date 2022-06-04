import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CountProvider>.value(value: CountProvider()),
          FutureProvider<List<User>?>(
            create: (_) async => await UserProvider().loadUserData(),
            initialData: [],
          ),
        ],
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Provider'),
              centerTitle: true,
              bottom: const TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.add),
                ),
                Tab(
                  icon: Icon(Icons.person),
                ),
                Tab(
                  icon: Icon(Icons.chat),
                ),
              ]),
            ),
            body: TabBarView(
              children: [
                MyCountPage(),
                MyUserPage(),
                Text('3'),
                // MyEventPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCountPage extends StatelessWidget {
  const MyCountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountProvider _state = Provider.of<CountProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Change NotifierProvider Example'),
            SizedBox(
              height: 50,
            ),
            Text(
              '${_state.countValue}',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _state._decrementCount(),
                  icon: Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                ),
                Consumer<CountProvider>(
                  builder: (context, value, child) {
                    return IconButton(
                      onPressed: () => value._incrementCount(),
                      icon: Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CountProvider extends ChangeNotifier {
  int _count = 0;

  int get countValue => _count;

  void _incrementCount() {
    _count++;
    notifyListeners();
  }

  void _decrementCount() {
    _count--;
    notifyListeners();
  }
}

class MyUserPage extends StatelessWidget {
  const MyUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
        ),
        Consumer<List<User>>(
          builder: ((
            context,
            List<User>? users,
            child,
          ) {
            print('runBug: ${users.runtimeType}');
            return Expanded(
              child: users == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          color: Colors.grey[(index * 200) % 400],
                          child: Center(
                            child: Text(
                                "${users[index].firstName} ${users[index].lastName} => ${users[index].website}"),
                          ),
                        );
                      },
                    ),
            );
          }),
        )
      ],
    );
  }
}

class UserProvider {
  final String _dataPath = "lib/sanya/users.json";
  late List<User> users;

  Future<String> loadAssets() async {
    return await Future.delayed(const Duration(seconds: 1), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }

  Future<List<User>?> loadUserData() async {
    String dataString = await loadAssets();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UsersList.fromJson(jsonUserData["users"]).users;
    return users;
  }
}

class User {
  final String firstName;
  final String lastName;
  final String website;

  const User(this.firstName, this.lastName, this.website);

  User.fromJson(Map<String, dynamic> json)
      : firstName = json["first_name"],
        lastName = json["last_name"],
        website = json["website"];
}

class UsersList {
  final List<User> users;

  UsersList(this.users);

  UsersList.fromJson(List<dynamic> usersJson)
      : users = usersJson.map((user) => User.fromJson(user)).toList();
}
