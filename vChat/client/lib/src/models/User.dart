// user class

class User {
  String _id;
  String _email;
  String _invite;
  String _name;

  User(this._id, this._email, this._invite);

  // empty constructor
  User.empty() {
    _id = '';
    _email = '';
    _invite = '';
    _name = '';
  }

  // getter
  String get id => _id;
  String get email => _email;
  String get invite => _invite;
  String get name => _name;

  // setter
  set id(String id) {
    _id = id;
  }

  set email(String email) {
    _email = email;
  }

    set invite(String id) {
    _invite = id;
  }

  set name(String email) {
    _name = name;
  }

  // JSON parsing
  User.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _email = json['email'],
        _invite = json['invite'];

  Map<String, dynamic> toJson() => {
    'id' : _id,
    'email' : _email,
    'invite' : _invite
  };
}
