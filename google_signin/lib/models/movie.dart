class Movie{
  final int? id;
  final String cred_val;
  final String name;
  final String director;
  final String poster;

  Movie(
      { this.id,
        required this.name,
        required this.cred_val,
        required this.director,
        required this.poster});

  Movie.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        cred_val = res["cred_val"],
        director = res["director"],
        poster = res["poster"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name, 'cred_val': cred_val, 'director': director, 'poster': poster};
  }
}