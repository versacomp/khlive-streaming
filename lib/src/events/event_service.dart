import 'dart:async';

import 'package:angular2/angular2.dart';

import 'event.dart';
import 'mock_events.dart';

@Injectable()
class EventService {
  Future<List<Event>> getEvents() async => mockEvents;

  Future<List<Event>> getEventsSlowly() {
    return new Future<List<Event>>.delayed(
        const Duration(seconds: 2), getEvents);
  }

  Future<Event> getEvent(int id) async =>
      (await getEvents()).firstWhere((event) => event.id == id);
}
