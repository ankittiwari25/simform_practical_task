class UserModel {
  List<Results>? results;

  UserModel({results, info});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  String? gender;
  Name? name;
  String? email;
  String? phone;
  String? cell;
  String? nat;

  Results({
    gender,
    name,
    location,
    email,
    login,
    dob,
    registered,
    phone,
    cell,
    id,
    picture,
    nat,
  });

  Results.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    email = json['email'];
    phone = json['phone'];
    cell = json['cell'];

    nat = json['nat'];
  }
}

class Name {
  String? title;
  String? first;
  String? last;

  Name({title, first, last});

  Name.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    first = json['first'];
    last = json['last'];
  }
}
