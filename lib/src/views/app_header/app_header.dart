import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';

import '../../services/firebase_service.dart';

@Component(selector: 'app-header',
    templateUrl: 'app_header.html',
    styleUrls: const ['app_header.css'],
    directives: const [CORE_DIRECTIVES]
)
class AppHeader {
  final FirebaseService fbService;

  AppHeader(FirebaseService this.fbService);
}