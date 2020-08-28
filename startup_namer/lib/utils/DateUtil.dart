///日期格式化
enum DateFormat {
  DEFAULT, //yyyy-MM-dd HH:mm:ss.SSS
  NORMAL, //yyyy-MM-dd HH:mm:ss
  YEAR_MONTH_DAY_HOUR_MINUTE, //yyyy-MM-dd HH:mm
  YEAR_MONTH_DAY, //yyyy-MM-dd
  YEAR_MONTH, //yyyy-MM
  MONTH_DAY, //MM-dd
  MONTH_DAY_HOUR_MINUTE, //MM-dd HH:mm
  HOUR_MINUTE_SECOND, //HH:mm:ss
  HOUR_MINUTE, //HH:mm

  ZH_DEFAULT, //yyyy年MM月dd日 HH时mm分ss秒SSS毫秒
  ZH_NORMAL, //yyyy年MM月dd日 HH时mm分ss秒  /  timeSeparate: ":" --> yyyy年MM月dd日 HH:mm:ss
  ZH_YEAR_MONTH_DAY_HOUR_MINUTE, //yyyy年MM月dd日 HH时mm分  /  timeSeparate: ":" --> yyyy年MM月dd日 HH:mm
  ZH_YEAR_MONTH_DAY, //yyyy年MM月dd日
  ZH_YEAR_MONTH, //yyyy年MM月
  ZH_MONTH_DAY, //MM月dd日
  ZH_MONTH_DAY_HOUR_MINUTE, //MM月dd日 HH时mm分  /  timeSeparate: ":" --> MM月dd日 HH:mm
  ZH_HOUR_MINUTE_SECOND, //HH时mm分ss秒
  ZH_HOUR_MINUTE, //HH时mm分
}

/// 工具类
class DateUtil {
  /// 判断一个日期是否是周末，即周六日
  static bool isWeekend(DateTime dateTime) {
    return dateTime.weekday == DateTime.saturday ||
        dateTime.weekday == DateTime.sunday;
  }

  /// 获取某年的天数
  static int getYearDaysCount(int year) {
    if (isLeapYearByYear(year)) {
      return 366;
    }
    return 365;
  }

  /// 获取某月的天数
  ///
  /// @param year  年
  /// @param month 月
  /// @return 某月的天数
  static int getMonthDaysCount(int year, int month) {
    int count = 0;
    //判断大月份
    if (month == 1 ||
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 10 ||
        month == 12) {
      count = 31;
    }

    //判断小月
    if (month == 4 || month == 6 || month == 9 || month == 11) {
      count = 30;
    }

    //判断平年与闰年
    if (month == 2) {
      if (isLeapYearByYear(year)) {
        count = 29;
      } else {
        count = 28;
      }
    }
    return count;
  }

  /// 是否是今天
  static bool isCurrentDay(int year, int month, int day) {
    DateTime now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }

  // /// 本月的第几周
  // static int getIndexWeekInMonth(DateTime dateTime) {
  //   DateTime firstdayInMonth = new DateTime(dateTime.year, dateTime.month, 1);
  //   Duration duration = dateTime.difference(firstdayInMonth);
  //   return duration.inDays ~/ 7 + 1;
  // }

  // /// 本周的第几天
  // static int getIndexDayInWeek(DateTime dateTime) {
  //   DateTime firstdayInMonth = new DateTime(
  //     dateTime.year,
  //     dateTime.month,
  //   );
  //   Duration duration = dateTime.difference(firstdayInMonth);
  //   return duration.inDays ~/ 7 + 1;
  // }

  /// 本月第一天，是那一周的第几天,从1开始
  /// @return 获取日期所在月视图对应的起始偏移量 the start diff with MonthView
  static int getIndexOfFirstDayInMonth(DateTime dateTime, {int offset = 0}) {
    DateTime firstDayOfMonth = new DateTime(dateTime.year, dateTime.month, 1);

    int week = firstDayOfMonth.weekday + offset;

    return week;
  }

  /// get DateTime By DateStr.
  static DateTime getDateTime(String dateStr) {
    DateTime dateTime = DateTime.tryParse(dateStr);
    return dateTime;
  }

  /// get DateTime By Milliseconds.
  static DateTime getDateTimeByMilliseconds(int milliseconds,
      {bool isUtc = false}) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
    return dateTime;
  }

  /// get DateMilliseconds By DateStr.
  static int getDateMillisecondsByTimeStr(String dateStr) {
    DateTime dateTime = DateTime.tryParse(dateStr);
    return dateTime == null ? null : dateTime.millisecondsSinceEpoch;
  }

  /// get Now Date Milliseconds.
  static int getNowDateMilliseconds() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// get Now Date Microseconds.
  static int getNowDateMicroseconds() {
    return DateTime.now().microsecondsSinceEpoch;
  }

  /// get Now Date Str.(yyyy-MM-dd HH:mm:ss)
  static String getNowDateStr() {
    return getDateStrByDateTime(DateTime.now());
  }

  /// get DateStr By DateStr.
  /// dateStr         date String.
  /// format          DateFormat type.
  /// dateSeparate    date separate.
  /// timeSeparate    time separate.
  static String getDateStrByTimeStr(
    String dateStr, {
    DateFormat format = DateFormat.NORMAL,
    String dateSeparate,
    String timeSeparate,
  }) {
    return getDateStrByDateTime(getDateTime(dateStr),
        format: format, dateSeparate: dateSeparate, timeSeparate: timeSeparate);
  }

  /// get DateStr By Milliseconds.
  /// milliseconds    milliseconds.
  /// format          DateFormat type.
  /// dateSeparate    date separate.
  /// timeSeparate    time separate.
  static String getDateStrByMillisecond(int milliseconds,
      {DateFormat format = DateFormat.NORMAL,
      String dateSeparate,
      String timeSeparate,
      bool isUtc = false}) {
    DateTime dateTime = getDateTimeByMilliseconds(milliseconds, isUtc: isUtc);
    return getDateStrByDateTime(dateTime,
        format: format, dateSeparate: dateSeparate, timeSeparate: timeSeparate);
  }

  /// get DateStr By DateTime.
  /// dateTime        dateTime.
  /// format          DateFormat type.
  /// dateSeparate    date separate.
  /// timeSeparate    time separate.
  static String getDateStrByDateTime(DateTime dateTime,
      {DateFormat format = DateFormat.NORMAL,
      String dateSeparate,
      String timeSeparate}) {
    if (dateTime == null) return null;
    String dateStr = dateTime.toString();
    if (isZHFormat(format)) {
      dateStr = formatZHDateTime(dateStr, format, timeSeparate);
    } else {
      dateStr = formatDateTime(dateStr, format, dateSeparate, timeSeparate);
    }
    return dateStr;
  }

  /// format ZH DateTime.
  /// time            time string.
  /// format          DateFormat type.
  ///timeSeparate    time separate.
  static String formatZHDateTime(
      String time, DateFormat format, String timeSeparate) {
    time = convertToZHDateTimeString(time, timeSeparate);
    switch (format) {
      case DateFormat.ZH_NORMAL: //yyyy年MM月dd日 HH时mm分ss秒
        time = time.substring(
            0,
            "yyyy年MM月dd日 HH时mm分ss秒".length -
                (timeSeparate == null || timeSeparate.isEmpty ? 0 : 1));
        break;
      case DateFormat.ZH_YEAR_MONTH_DAY_HOUR_MINUTE: //yyyy年MM月dd日 HH时mm分
        time = time.substring(
            0,
            "yyyy年MM月dd日 HH时mm分".length -
                (timeSeparate == null || timeSeparate.isEmpty ? 0 : 1));
        break;
      case DateFormat.ZH_YEAR_MONTH_DAY: //yyyy年MM月dd日
        time = time.substring(0, "yyyy年MM月dd日".length);
        break;
      case DateFormat.ZH_YEAR_MONTH: //yyyy年MM月
        time = time.substring(0, "yyyy年MM月".length);
        break;
      case DateFormat.ZH_MONTH_DAY: //MM月dd日
        time = time.substring("yyyy年".length, "yyyy年MM月dd日".length);
        break;
      case DateFormat.ZH_MONTH_DAY_HOUR_MINUTE: //MM月dd日 HH时mm分
        time = time.substring(
            "yyyy年".length,
            "yyyy年MM月dd日 HH时mm分".length -
                (timeSeparate == null || timeSeparate.isEmpty ? 0 : 1));
        break;
      case DateFormat.ZH_HOUR_MINUTE_SECOND: //HH时mm分ss秒
        time = time.substring(
            "yyyy年MM月dd日 ".length,
            "yyyy年MM月dd日 HH时mm分ss秒".length -
                (timeSeparate == null || timeSeparate.isEmpty ? 0 : 1));
        break;
      case DateFormat.ZH_HOUR_MINUTE: //HH时mm分
        time = time.substring(
            "yyyy年MM月dd日 ".length,
            "yyyy年MM月dd日 HH时mm分".length -
                (timeSeparate == null || timeSeparate.isEmpty ? 0 : 1));
        break;
      default:
        break;
    }
    return time;
  }

  /// format DateTime.
  /// time            time string.
  /// format          DateFormat type.
  /// dateSeparate    date separate.
  /// timeSeparate    time separate.
  static String formatDateTime(String time, DateFormat format,
      String dateSeparate, String timeSeparate) {
    switch (format) {
      case DateFormat.NORMAL: //yyyy-MM-dd HH:mm:ss
        time = time.substring(0, "yyyy-MM-dd HH:mm:ss".length);
        break;
      case DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE: //yyyy-MM-dd HH:mm
        time = time.substring(0, "yyyy-MM-dd HH:mm".length);
        break;
      case DateFormat.YEAR_MONTH_DAY: //yyyy-MM-dd
        time = time.substring(0, "yyyy-MM-dd".length);
        break;
      case DateFormat.YEAR_MONTH: //yyyy-MM
        time = time.substring(0, "yyyy-MM".length);
        break;
      case DateFormat.MONTH_DAY: //MM-dd
        time = time.substring("yyyy-".length, "yyyy-MM-dd".length);
        break;
      case DateFormat.MONTH_DAY_HOUR_MINUTE: //MM-dd HH:mm
        time = time.substring("yyyy-".length, "yyyy-MM-dd HH:mm".length);
        break;
      case DateFormat.HOUR_MINUTE_SECOND: //HH:mm:ss
        time =
            time.substring("yyyy-MM-dd ".length, "yyyy-MM-dd HH:mm:ss".length);
        break;
      case DateFormat.HOUR_MINUTE: //HH:mm
        time = time.substring("yyyy-MM-dd ".length, "yyyy-MM-dd HH:mm".length);
        break;
      default:
        break;
    }
    time = dateTimeSeparate(time, dateSeparate, timeSeparate);
    return time;
  }

  /// is format to ZH DateTime String
  static bool isZHFormat(DateFormat format) {
    return format == DateFormat.ZH_DEFAULT ||
        format == DateFormat.ZH_NORMAL ||
        format == DateFormat.ZH_YEAR_MONTH_DAY_HOUR_MINUTE ||
        format == DateFormat.ZH_YEAR_MONTH_DAY ||
        format == DateFormat.ZH_YEAR_MONTH ||
        format == DateFormat.ZH_MONTH_DAY ||
        format == DateFormat.ZH_MONTH_DAY_HOUR_MINUTE ||
        format == DateFormat.ZH_HOUR_MINUTE_SECOND ||
        format == DateFormat.ZH_HOUR_MINUTE;
  }

  /// convert To ZH DateTime String
  static String convertToZHDateTimeString(String time, String timeSeparate) {
    time = time.replaceFirst("-", "年");
    time = time.replaceFirst("-", "月");
    time = time.replaceFirst(" ", "日 ");
    if (timeSeparate == null || timeSeparate.isEmpty) {
      time = time.replaceFirst(":", "时");
      time = time.replaceFirst(":", "分");
      time = time.replaceFirst(".", "秒");
      time = time + "毫秒";
    } else {
      time = time.replaceAll(":", timeSeparate);
    }
    return time;
  }

  /// date Time Separate.
  static String dateTimeSeparate(
      String time, String dateSeparate, String timeSeparate) {
    if (dateSeparate != null) {
      time = time.replaceAll("-", dateSeparate);
    }
    if (timeSeparate != null) {
      time = time.replaceAll(":", timeSeparate);
    }
    return time;
  }

  /// get WeekDay By Milliseconds.
  static String getWeekDayByMilliseconds(int milliseconds,
      {bool isUtc = false}) {
    DateTime dateTime = getDateTimeByMilliseconds(milliseconds, isUtc: isUtc);
    return getWeekDay(dateTime);
  }

  /// get ZH WeekDay By Milliseconds.
  static String getZHWeekDayByMilliseconds(int milliseconds,
      {bool isUtc = false}) {
    DateTime dateTime = getDateTimeByMilliseconds(milliseconds, isUtc: isUtc);
    return getZHWeekDay(dateTime);
  }

  /// get WeekDay.
  static String getWeekDay(DateTime dateTime) {
    if (dateTime == null) return null;
    String weekday;
    switch (dateTime.weekday) {
      case 1:
        weekday = "Monday";
        break;
      case 2:
        weekday = "Tuesday";
        break;
      case 3:
        weekday = "Wednesday";
        break;
      case 4:
        weekday = "Thursday";
        break;
      case 5:
        weekday = "Friday";
        break;
      case 6:
        weekday = "Saturday";
        break;
      case 7:
        weekday = "Sunday";
        break;
      default:
        break;
    }
    return weekday;
  }

  /// get ZH WeekDay.
  static String getZHWeekDay(DateTime dateTime) {
    if (dateTime == null) return null;
    String weekday;
    switch (dateTime.weekday) {
      case 1:
        weekday = "星期一";
        break;
      case 2:
        weekday = "星期二";
        break;
      case 3:
        weekday = "星期三";
        break;
      case 4:
        weekday = "星期四";
        break;
      case 5:
        weekday = "星期五";
        break;
      case 6:
        weekday = "星期六";
        break;
      case 7:
        weekday = "星期日";
        break;
      default:
        break;
    }
    return weekday;
  }

  static String getZHShotWeekDay(DateTime dateTime) {
    if (dateTime == null) return null;
    String weekday;
    switch (dateTime.weekday) {
      case 1:
        weekday = "周一";
        break;
      case 2:
        weekday = "周二";
        break;
      case 3:
        weekday = "周三";
        break;
      case 4:
        weekday = "周四";
        break;
      case 5:
        weekday = "周五";
        break;
      case 6:
        weekday = "周六";
        break;
      case 7:
        weekday = "周日";
        break;
      default:
        break;
    }
    return weekday;
  }

  /// Return whether it is leap year.
  static bool isLeapYearByDateTime(DateTime dateTime) {
    return isLeapYearByYear(dateTime.year);
  }

  ///是否是闰年
  static bool isLeapYearByYear(int year) {
    return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
  }

  /// is yesterday by millis.
  /// 是否是昨天.
  static bool isYesterdayByMilliseconds(int millis, int locMillis) {
    return isYesterday(DateTime.fromMillisecondsSinceEpoch(millis),
        DateTime.fromMillisecondsSinceEpoch(locMillis));
  }

  /// is yesterday by dateTime.
  /// 是否是昨天.
  static bool isYesterday(DateTime dateTime, DateTime locDateTime) {
    if (yearIsEqual(dateTime, locDateTime)) {
      int spDay =
          DateUtil.getDayOfYear(locDateTime) - DateUtil.getDayOfYear(dateTime);
      return spDay == 1;
    } else {
      return ((locDateTime.year - dateTime.year == 1) &&
          dateTime.month == 12 &&
          locDateTime.month == 1 &&
          dateTime.day == 31 &&
          locDateTime.day == 1);
    }
  }

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYearByMilliseconds(int millis) {
    return getDayOfYear(DateTime.fromMillisecondsSinceEpoch(millis));
  }

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYear(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int days = dateTime.day;
    for (int i = 1; i < month; i++) {
      days = days + getMonthDaysCount(year, i);
    }
    return days;
  }

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqualByMilliseconds(int millis, int locMillis) {
    return yearIsEqual(DateTime.fromMillisecondsSinceEpoch(millis),
        DateTime.fromMillisecondsSinceEpoch(locMillis));
  }

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqual(DateTime dateTime, DateTime locDateTime) {
    return dateTime.year == locDateTime.year;
  }

  /// year is today.
  /// 是否是今天.
  static bool isToday(int milliseconds, {bool isUtc = false}) {
    if (milliseconds == null || milliseconds == 0) return false;
    DateTime old =
        DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
    DateTime now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    return old.year == now.year && old.month == now.month && old.day == now.day;
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1, 12);
  }

  static DateTime lastDayOfMonth(DateTime month) {
    final date = month.month < 12
        ? DateTime.utc(month.year, month.month + 1, 1, 12)
        : DateTime.utc(month.year + 1, 1, 1, 12);
    return date.subtract(const Duration(days: 1));
  }

  // static List<DateModel> initCalendarForMonthView(
  //     int year, int month, DateTime currentDate, int weekStart,
  //     {DateModel minSelectDate,
  //     DateModel maxSelectDate,
  //     Map<DateModel, Object> extraDataMap,
  //     int offset = 0}) {
  //   print('initCalendarForMonthView start');
  //   weekStart = DateTime.monday;
  //   //获取月视图真实偏移量
  //   int mPreDiff =
  //       getIndexOfFirstDayInMonth(new DateTime(year, month), offset: offset);
  //   //获取该月的天数
  //   int monthDayCount = getMonthDaysCount(year, month);

  //   LogUtil.log(
  //       TAG: "DateUtil",
  //       message:
  //           "initCalendarForMonthView:$year年$month月,有$monthDayCount天,第一天的index为${mPreDiff}");

  //   List<DateModel> result = new List();

  //   int size = 42;

  //   DateTime firstDayOfMonth = new DateTime(year, month, 1);
  //   DateTime lastDayOfMonth = new DateTime(year, month, monthDayCount);

  //   for (int i = 0; i < size; i++) {
  //     DateTime temp;
  //     DateModel dateModel;
  //     if (i < mPreDiff - 1) {
  //       if (i < ((mPreDiff / 7).ceil() - 1) * 7) {
  //         size++;
  //         continue;
  //       }
  //       //这个上一月的几天
  //       temp = firstDayOfMonth.subtract(Duration(days: mPreDiff - i - 1));

  //       dateModel = DateModel.fromDateTime(temp);
  //       dateModel.isCurrentMonth = false;
  //     } else if (i >= monthDayCount + (mPreDiff - 1)) {
  //       //这是下一月的几天
  //       temp = lastDayOfMonth
  //           .add(Duration(days: i - mPreDiff - monthDayCount + 2));
  //       dateModel = DateModel.fromDateTime(temp);
  //       dateModel.isCurrentMonth = false;
  //     } else {
  //       //这个月的
  //       temp = new DateTime(year, month, i - mPreDiff + 2);
  //       dateModel = DateModel.fromDateTime(temp);
  //       dateModel.isCurrentMonth = true;
  //     }

  //     //判断是否在范围内
  //     if (dateModel.getDateTime().isAfter(minSelectDate.getDateTime()) &&
  //         dateModel.getDateTime().isBefore(maxSelectDate.getDateTime())) {
  //       dateModel.isInRange = true;
  //     } else {
  //       dateModel.isInRange = false;
  //     }
  //     //将自定义额外的数据，存储到相应的model中
  //     if (extraDataMap?.isNotEmpty == true) {
  //       if (extraDataMap.containsKey(dateModel)) {
  //         dateModel.extraData = extraDataMap[dateModel];
  //       } else {
  //         dateModel.extraData = null;
  //       }
  //     } else {
  //       dateModel.extraData = null;
  //     }

  //     result.add(dateModel);
  //   }

  //   print('initCalendarForMonthView end');

  //   return result;
  // }

  // /**
  //  * 月的行数
  //  */
  // static int getMonthViewLineCount(int year, int month, int offset) {
  //   DateTime firstDayOfMonth = new DateTime(year, month, 1);
  //   int monthDayCount = getMonthDaysCount(year, month);

  //   int preIndex = (firstDayOfMonth.weekday - 1 + offset) % 7;
  //   int lineCount = ((preIndex + monthDayCount) / 7).ceil();
  //   LogUtil.log(
  //       TAG: "DateUtil",
  //       message: "getMonthViewLineCount:$year年$month月:有$lineCount行");

  //   return lineCount;
  // }

  /// 获取上周的7天
  static List<DateTime> lastWeekDays(DateTime dateTime) {
    DateTime lastWeekTime = dateTime.add(Duration(days: -7));
    return weekDays(lastWeekTime);
  }

  /// 获取下周的7天
  static List<DateTime> nextWeekDays(DateTime dateTime) {
    DateTime lastWeekTime = dateTime.add(Duration(days: 7));
    return weekDays(lastWeekTime);
  }

  /// 获取下周的14天
  static List<DateTime> nextNextWeekDays(DateTime dateTime) {
    DateTime lastWeekTime = dateTime.add(Duration(days: 14));
    return weekDays(lastWeekTime);
  }

  /// 获取本周的7天
  static List<DateTime> weekDays(DateTime currentDate) {
    List<DateTime> items = List();
    int weekDay = currentDate.weekday;
    //计算本周的第一天
    DateTime firstDayOfWeek = currentDate.add(Duration(days: -weekDay));
    for (int i = 1; i <= 7; i++) {
      DateTime dateTime = firstDayOfWeek.add(Duration(days: i));
      items.add(dateTime);
    }
    return items;
  }
}
