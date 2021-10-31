class Userx{
  final int? id;
  final String name;
  final int age;
  final String country;
  final String? email;

  Userx(
      { this.id,
        required this.name,
        required this.age,
        required this.country,
        this.email});

  Userx.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        age = res["age"],
        country = res["country"],
        email = res["email"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name, 'age': age, 'country': country, 'email': email};
  }
}
