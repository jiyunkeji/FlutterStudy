import 'package:startup_namer/models/plan_day.dart';

class PlanWeek {
  DateTime dateTime;
  int month;
  List<PlanDay> days = [];
  PlanWeek(this.dateTime, this.month, this.days);
}
