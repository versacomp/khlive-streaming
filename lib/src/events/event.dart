class Event {
  final int id;
  String name;
  String uid;

  Event(this.id, this.name, this.uid);

  Event.fromMap(Map map) :
        this(map['id'], map['name'], map['uid']);

  Map toMap() => {
    "id": id,
    "name": name,
    "uid": uid
  };
}
