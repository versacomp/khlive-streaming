import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2/security.dart';

import 'event.dart';
import 'event_service.dart';
import '../services/firebase_service.dart';

@Component(
  selector: 'event-detail',
  templateUrl: 'event_detail_component.html',
  styleUrls: const ['event_detail_component.css'],
  directives: const [COMMON_DIRECTIVES],
  providers: const [DomSanitizationService]
)
class EventDetailComponent implements OnInit {
  Event event;
  final EventService _eventService;
  final Router _router;
  final RouteParams _routeParams;
  final FirebaseService fbService;
  final DomSanitizationService _domSanitizer;

  SafeResourceUrl videoUrl;

  EventDetailComponent(this._eventService, this._router, this._routeParams,
      FirebaseService this.fbService, DomSanitizationService this._domSanitizer);

  void ngOnInit() {
    var _id = _routeParams.get('id');
    var id = int.parse(_id ?? '', onError: (_) => null);
    if (id != null) event = (fbService.getEvent(id));
    getUrl();
  }

  void getUrl() {
    if (event != null) {
      videoUrl = this._domSanitizer.bypassSecurityTrustResourceUrl("https://www.youtube.com/embed/" + event.uid + "?autoplay=1&loop=1&modestbranding=1&rel=0");
    }
  }

  Future goBack() => _router.navigate([
        'Events',
        event == null ? {} : {'id': event.id.toString()}
      ]);
}
