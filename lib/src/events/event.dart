class Event {
  final int id;
  String name;
  String description;
  String uid;

  Event(this.description, this.id, this.name, this.uid);

  Event.fromMap(Map map) :
        this(map['description'], map['id'], map['name'], map['uid']);

  Map toMap() => {
    "description": description,
    "id": id,
    "name": name,
    "uid": uid
  };
}
