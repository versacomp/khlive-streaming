import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'event.dart' as ev;
import 'event_service.dart';
import '../services/firebase_service.dart';

@Component(
  selector: 'khl-events',
  templateUrl: 'events_component.html',
  styleUrls: const ['events_component.css'],
  directives: const [CORE_DIRECTIVES]
)
class EventsComponent implements OnInit {
  final Router _router;
  final RouteParams _routeParams;
  final EventService _eventService;
  final FirebaseService fbService;
  List<ev.Event> events;
  ev.Event selectedEvent;

  EventsComponent(this._eventService, this._router, this._routeParams, FirebaseService this.fbService);

  Future<Null> getEvents() async {
    events = await _eventService.getEvents();
  }

  Future<Null> ngOnInit() async {
    await getEvents();
    var id = _getId();
    if (id == null) return;
    selectedEvent =
        events.firstWhere((event) => event.id == id, orElse: () => null);
  }

  int _getId() {
    var _id = _routeParams.get('id');
    return int.parse(_id ?? '', onError: (_) => null);
  }

  void onSelect(ev.Event event) {
    selectedEvent = event;
    gotoDetail();
  }

  Future gotoDetail() => _router.navigate([
        'EventDetail',
        {'id': selectedEvent.id.toString()}
      ]);
}
