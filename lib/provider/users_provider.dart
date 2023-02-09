import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:simform_practical_task/database/table/users_database.dart';
import 'package:simform_practical_task/model/user_model.dart';

class UsersProvider extends ChangeNotifier {
  final dio = Dio();
  final _myDatabase = UsersDatabase();
  List<User> listOfUserFromLocal = [];

  Future<void> getUserData() async {
    try {
      /// If internet is available: then Display list from local
      getLocalUser();
      final response = await dio.get('https://randomuser.me/api/?results=100');
      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data);
        List<User> tempUsers = [];
        for (var data in userModel.results!) {
          final userData = User(name: "${data.name!.title!} ${data.name!.first!} ${data.name!.last!}", email: data.email!);

          /// Fetch list of Users from remote
          tempUsers.add(userData);
        }
        listOfUserFromLocal = tempUsers;
        notifyListeners();

        /// Replace list in local with the new list from remote
        await _myDatabase.deleteUsers();
        await _myDatabase.insertUsers(listOfUserFromLocal);
      }
    } on DioError catch (_) {
      /// If no internet is available: Display list from local
      getLocalUser();
    }
  }

  Future<void> getLocalUser() async {
    listOfUserFromLocal = await _myDatabase.getAllUser();
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _myDatabase.close();
    super.dispose();
  }
}
