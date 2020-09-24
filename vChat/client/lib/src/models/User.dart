class User {
  String _id;
  String _email;

  User(this._id, this._email);

  User.empty() {
    _id = '';
    _email = '';
  }


  String get id => _id;
  String get email => _email;

  set id(String id) {
    _id = id;
  }

  set email(String id) {
    _id = id;
  }

  User.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _email = json['email'];

  Map<String, dynamic> toJson() => {
    'id' : _id,
    'email' : _email,
  };
}
