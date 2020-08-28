import 'package:startup_namer/models/plan_event.dart';

class PlanTime {
  PlanEvent event;
  DateTime dateTime;
  String time;
  PlanTime(this.dateTime, this.time, [this.event]);
}
