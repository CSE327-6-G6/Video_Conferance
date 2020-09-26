class User {
  String _id;
  String _email;
  String _invite;

  User(this._id, this._email, this._invite);

  User.empty() {
    _id = '';
    _email = '';
    _invite = '';
  }


  String get id => _id;
  String get email => _email;
  String get invite => _invite;

  set id(String id) {
    _id = id;
  }

  set email(String id) {
    _id = id;
  }

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
