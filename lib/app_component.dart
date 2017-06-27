// This is a copy of app_component_4.dart
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart';

// Not yet used: import 'src/compose_message_component.dart';
import 'src/crisis_center/crisis_center_component.dart';
import 'src/events/event_detail_component.dart';
import 'src/events/event_service.dart';
import 'src/events/events_component.dart';
import 'src/not_found_component.dart';
import 'src/services/firebase_service.dart';
import 'src/views/app_header/app_header.dart';

@Component(
  selector: 'my-app',
  template: '''
    <app-header></app-header>
    <div *ngIf="fbService.user != null && fbService.isAuthorized">
    <nav>
      <a [routerLink]="['Events']">Events</a>
      <!--
      <a [routerLink]="['CrisisCenter', 'Crises', 'CrisisDetail', {'id': '1'}]">Dragon Crisis</a>
      -->
    </nav>
    <router-outlet></router-outlet>
    <!-- Note: the named outlet is not yet used:
    <router-outlet></router-outlet>
    <router-outlet name="popup"></router-outlet>
    -->
    </div>
    <div *ngIf="fbService.user == null">
      <p>Sign in to view events.</p>
    </div>
    <div *ngIf="fbService.user != null && !fbService.isAuthorized">
      <p>You are not authorized to view content!</p>
    </div>
  ''',
  styles: const ['.router-link-active {color: #039be5;}'],
  directives: const [ROUTER_DIRECTIVES, CORE_DIRECTIVES, AppHeader],
  providers: const [EventService, ROUTER_PROVIDERS, FirebaseService],
)
@RouteConfig(const [
  const Redirect(path: '/', redirectTo: const ['Events']),
  const Redirect(path: '/index.html', redirectTo: const ['Events']),
  const Route(path: '/events', name: 'Events', component: EventsComponent),
  const Route(
      path: '/event/:id', name: 'EventDetail', component: EventDetailComponent),
  // Not yet used: const AuxRoute(path: '/contact', name: 'Contact', component: ComposeMessageComponent),
  const Route(path: '/**', name: 'NotFound', component: NotFoundComponent)
])
class AppComponent implements OnInit {
  final FirebaseService fbService;

  int count = 0;
  DatabaseReference ref;

  @override
  ngOnInit() {
    count = this.fbService.EventsCount;
  }

  AppComponent(FirebaseService this.fbService);

}
