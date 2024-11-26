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
      : id = map['id'],
        name = map['name'],
        email = map['email'],
        phone = map['phone'],
        image = map['image'];

  Map toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image
    };
    if (id != null) {
      map['id'] = image;
    }
    return map;
  }
}
