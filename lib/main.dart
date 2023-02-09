import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simform_practical_task/provider/users_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simform Practical Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Practical Task'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UsersProvider usersProvider = UsersProvider();

  @override
  void initState() {
    usersProvider.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => usersProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Consumer<UsersProvider>(
          builder: ((context, value, child) {
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.deepOrange.withOpacity(0.3),
                  child: Text("$index",maxLines: 1,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                ),
                title: Text(value.listOfUserFromLocal[index].name),
                subtitle: Text(value.listOfUserFromLocal[index].email),
              ),
              itemCount: value.listOfUserFromLocal.length,
            );
          }),
        ),
      ),
    );
  }
}
