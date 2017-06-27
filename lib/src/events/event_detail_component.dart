import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'event.dart';
import 'event_service.dart';

@Component(
  selector: 'event-detail',
  templateUrl: 'event_detail_component.html',
  styleUrls: const ['event_detail_component.css'],
  directives: const [COMMON_DIRECTIVES],
)
class EventDetailComponent implements OnInit {
  Event event;
  final EventService _eventService;
  final Router _router;
  final RouteParams _routeParams;

  EventDetailComponent(this._eventService, this._router, this._routeParams);

  Future<Null> ngOnInit() async {
    var _id = _routeParams.get('id');
    var id = int.parse(_id ?? '', onError: (_) => null);
    if (id != null) event = await (_eventService.getEvent(id));
  }

  Future goBack() => _router.navigate([
        'Events',
        event == null ? {} : {'id': event.id.toString()}
      ]);
}
