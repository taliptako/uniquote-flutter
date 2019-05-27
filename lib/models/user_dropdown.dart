class UserDropdown {
  final int id;
  final String name;

  const UserDropdown({this.id, this.name});

  factory UserDropdown.fromJson(Map<String, dynamic> json) {
    return UserDropdown(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
