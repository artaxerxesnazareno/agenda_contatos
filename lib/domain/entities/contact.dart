import 'package:agenda_contatos/data/datasources/local/constants/database_constants.dart';

class Contact {
  int id;
  String? name;
  String? email;
  String? phone;
  String? image;

  Contact(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.image});

  Contact.fromMap(Map map)
      : id = map[DatabaseConstants.idColumn],
        name = map[DatabaseConstants.nameColumn],
        email = map[DatabaseConstants.emailColumn],
        phone = map[DatabaseConstants.phoneColumn],
        image = map[DatabaseConstants.imgColumn];

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      DatabaseConstants.nameColumn: name,
      DatabaseConstants.emailColumn: email,
      DatabaseConstants.phoneColumn: phone,
      DatabaseConstants.imgColumn: image,
    };
    if (id != 0) {
      map[DatabaseConstants.idColumn] = id;
    }
    return map;
  }
}
