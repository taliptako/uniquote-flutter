class Profession {
  final int id;
  final String name;
  final int count;

  Profession(this.id, this.name, this.count);

  factory Profession.fromJson(Map<String, dynamic> json) {
    return Profession(
        json['id'],
        json['name']['en'],
        json['count']
    );
  }
}
