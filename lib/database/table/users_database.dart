import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'users_database.g.dart';

class Users extends Table {
  TextColumn get name => text().withLength()();

  TextColumn get email => text().withLength()();
}

@UseMoor(tables: [Users])
class UsersDatabase extends _$UsersDatabase {
  UsersDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: "db.sqlite", logStatements: true));

  Future<void> insertUsers(List<User> listOfUsers) async {
    await batch((batch) {
      batch.insertAll(users, listOfUsers);
    });
  }

  Future<List<User>> getAllUser() => select(users).get();

  Future<dynamic> deleteUsers() => delete(users).go();

  @override
  int get schemaVersion => 1;
}
