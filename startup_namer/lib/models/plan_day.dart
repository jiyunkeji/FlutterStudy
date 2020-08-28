import 'package:startup_namer/models/plan_time.dart';

class PlanDay {
  List<PlanTime> times = [];
  DateTime dateTime;
  int day;
  String week;
  PlanDay(this.dateTime, this.day, this.week, this.times);
}
