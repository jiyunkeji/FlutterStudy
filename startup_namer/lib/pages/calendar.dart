
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/models/plan_day.dart';
import 'package:startup_namer/models/plan_time.dart';
import 'package:startup_namer/models/plan_week.dart';
import 'package:startup_namer/utils/DateUtil.dart';


class Calender extends StatelessWidget {
  const Calender() : super();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double itemW = MediaQuery.of(context).size.width / 8;

    return Scaffold( appBar: AppBar(title: Text("日历排班"),), body: CalendarView(screenSize.width, screenSize.height, itemW),) ;
  }
}
class CalendarView extends StatefulWidget {
  final bool reverse = false;
  final double screenWidth;
  final double screenHeight;
  final double itemW;
  CalendarView(this.screenWidth, this.screenHeight, this.itemW);
  @override
  CalendarViewState createState() {
    return new CalendarViewState();
  }
}

class CalendarViewState extends State<CalendarView> {
  ScrollController _controller;
  List<PlanWeek> planWeeks = [];
  List<PlanTime> planTimes = [];

  double nextOffset = 0;
  double contentOffset = 0;

  Offset pointerStart;
  Offset pointerEnd;
  double touchRangeX = 0;
  double touchRangeY = 0;

  double itemH = 26;
  double headHeight = 50;
  double itemW;
  TextStyle textStyle;

  //上一次停留位置
  int lastPage = 1;
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    itemW = widget.itemW;
    contentOffset = widget.screenWidth - itemW;
    DateTime now = DateTime.now();
    setState(() {
      planTimes = planTimeByDay(now);
      planWeeks.addAll([
        planWeekByDateTimes(DateUtil.lastWeekDays(now)),
        planWeekByDateTimes(DateUtil.weekDays(now)),
        planWeekByDateTimes(DateUtil.nextWeekDays(now)),
        planWeekByDateTimes(DateUtil.nextNextWeekDays(now))
      ]);
    });
    _controller =
    new ScrollController(initialScrollOffset: contentOffset * lastPage);
    // scrollAnimToOffset(_controller, screenWidth * lastPage, () {});
  }

  PlanWeek planWeekByDateTimes(List<DateTime> dateTimes) {
    if (dateTimes.isEmpty) {
      return null;
    }
    List<PlanDay> planDays = [];
    dateTimes.forEach((item) {
      PlanDay day = new PlanDay(
          item, item.day, DateUtil.getZHShotWeekDay(item), planTimeByDay(item));
      planDays.add(day);
    });

    PlanWeek planWeek =
    new PlanWeek(dateTimes[0], dateTimes[0].month, planDays);

    return planWeek;
  }

  List<PlanTime> planTimeByDay(DateTime day) {
    List<PlanTime> times = [];
    for (int i = 8; i < 23; i++) {
      DateTime spanTime = new DateTime(day.year, day.month, day.day, i, 0);
      PlanTime time = new PlanTime(
          spanTime,
          DateUtil.getDateStrByDateTime(spanTime,
              format: DateFormat.HOUR_MINUTE));
      times.add(time);

      spanTime = new DateTime(day.year, day.month, day.day, i, 30);
      time = new PlanTime(
          spanTime,
          DateUtil.getDateStrByDateTime(spanTime,
              format: DateFormat.HOUR_MINUTE));
      times.add(time);
    }

    return times;
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  List<Widget> leftTimes() {
    List<Widget> widgets = [];

    planTimes?.forEach((item) {
      int index = planTimes.indexOf(item);
      Widget widget = Container(
        height: itemH,
        width: itemW,
        child: index.isEven
            ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('${item.time}', style: textStyle),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Divider(height: 1, color: Colors.black45)],
        ),
        color: Color.fromRGBO(234, 234, 234, 1),
      );
      widgets.add(widget);
    });

    return widgets;
  }

  List<Widget> getHeadDayViews(PlanWeek planWeek) {
    List<Widget> widgets = [];
    Widget monthWidget = Container(
      height: headHeight,
      width: itemW,
      child: Center(
        child: Text('${planWeek?.month}', style: textStyle),
      ),
      color: Color.fromRGBO(234, 234, 234, 1),
    );
    widgets.add(monthWidget);
    planWeek?.days?.forEach((item) {
      Widget widget = Container(
        height: headHeight,
        width: itemW,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${item.day}', style: textStyle),
            Text('${item.week}', style: textStyle)
          ],
        ),
        color: Color.fromRGBO(234, 234, 234, 1),
      );
      widgets.add(widget);
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    textStyle = Theme.of(context).textTheme.bodyText1;
    PlanWeek planWeek;
    if (planWeeks.isNotEmpty) {
      planWeek = planWeeks[lastPage];
    }
    return CustomScrollView(
      controller: null,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            height: headHeight,
            child: Row(
              children: getHeadDayViews(planWeek),
            ),
          ),
        ),
        SliverList(
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              return shopList1(context);
            }, childCount: 1)),
      ],
    );
  }

  shopList1(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: itemW,
            child: Column(
              children: leftTimes(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: planTimes.length * itemH,
              child: Listener(
                onPointerDown: (event) {
                  pointerStart = event.position;
                  // print("down: ${event.position}");
                },
                onPointerMove: (event) {
                  // print("move: ${event.position}");
                },
                onPointerUp: getPonitUpListenerInHorizontal(planWeeks),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: planWeeks.length,
                    itemBuilder: (context, index) {
                      return shopList2(context, planWeeks[index]);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setLastPage(int page) {
    DateTime currentTime = planWeeks[page].dateTime;
    if (page == 0) {
      setState(() {
        planWeeks.insert(
            0, planWeekByDateTimes(DateUtil.lastWeekDays(currentTime)));
        planWeeks.removeLast();
      });

      setState(() {
        lastPage = 1;
      });
      scrollAnimToOffset(_controller, contentOffset, () {});
    }

    if (page == 2) {
      setState(() {
        planWeeks.removeAt(0);
        planWeeks.insert(
            3, planWeekByDateTimes(DateUtil.nextNextWeekDays(currentTime)));
      });

      setState(() {
        lastPage = 1;
      });
      jumpToOffset(_controller, contentOffset, () {});
    }
  }

  /// 构造横向滑动时候的触摸抬起监听
  PointerUpEventListener getPonitUpListenerInHorizontal(List<PlanWeek> data) {
    return (event) {
      double offset = widget.screenWidth / 7;
      pointerEnd = event.position;
      touchRangeX =
          (widget.reverse ? -1 : 1) * (pointerStart.dx - pointerEnd.dx);
      // print("本次拖动距离X： $touchRangeX offset: $offset");
      touchRangeY =
          (widget.reverse ? -1 : 1) * (pointerStart.dy - pointerEnd.dy);
      // print("本次拖动距离Y： $touchRangeY");

      //所有的操作必须要满足滑动距离>offset才算是滑动
      if (touchRangeX.abs() < offset) {
        // print("所有的操作必须要满足滑动距离>offset才算是滑动$lastPage");

        nextOffset = contentOffset * lastPage;
        scrollAnimToOffset(_controller, nextOffset, () {
          if (lastPage < 0) {
            setLastPage(0);
          } else if (lastPage >= data.length - 1) {
            setLastPage(data.length - 1);
          }
        });
        return;
      }

      //纵向操作大于横向操作三倍视为纵向操作
      //这个判断拦截只有在纵向操作距离大于20.0的时候才生效
      if (touchRangeX.abs() < touchRangeY.abs() && touchRangeY.abs() > 20) {
        // print("这个判断拦截只有在纵向操作距离大于20.0的时候才生效$lastPage");
        nextOffset = contentOffset * lastPage;
        scrollAnimToOffset(_controller, nextOffset, () {
          if (lastPage < 0) {
            setLastPage(0);
          } else if (lastPage >= data.length - 1) {
            setLastPage(data.length - 1);
          }
        });
        return;
      }

      //跳转到下一页或者上一页或者不懂
      if (touchRangeX > offset) {
        if (lastPage + 1 > data.length - 1) {
          return;
        }
        setLastPage(lastPage + 1);
        // print("animate to $nextOffset page:${lastPage + 1}");
      } else if (touchRangeX < -1 * offset) {
        if (lastPage - 1 < 0) {
          return;
        }
        // print("animate to $nextOffset page:${lastPage - 1}");
        setLastPage(lastPage - 1);
      } else {
        // scrollAnimToOffset(_controller, contentOffset * lastPage, null);
      }
    };
  }

  /// 滑动到指定位置
  void scrollAnimToOffset(ScrollController controller, double offset,
      void Function() onScrollCompleted) {
    controller
        .animateTo(offset,
        duration: Duration(
          milliseconds: 200,
        ),
        curve: Curves.easeIn)
        .then((v) {
      if (onScrollCompleted != null) {
        onScrollCompleted();
      }
    }).catchError((e) {
      print(e);
    });
  }

  void jumpToOffset(ScrollController controller, double offset,
      void Function() onScrollCompleted) {
    controller.jumpTo(offset);
  }

  List<Widget> listItem(PlanDay planDay) {
    List<Widget> widgets = [];

    planDay.times?.forEach((item) {
      int index = planDay.times.indexOf(item);
      Widget widget = index.isEven
          ? GestureDetector(
        onTap: () {
          // print(
          //     'planDay:${DateUtil.getDateStrByDateTime(planDay.dateTime)}  dateTime: ${DateUtil.getDateStrByDateTime(item.dateTime)}');
        },
        child: Container(
          height: itemH,
          width: itemW,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 0.5, //宽度
                color: Colors.black12, //边框颜色
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [],
          ),
        ),
      )
          : GestureDetector(
          onTap: () {
            print(DateUtil.getDateStrByDateTime(item.dateTime));
          },
          child: Container(
            height: itemH,
            width: itemW,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.5, //宽度
                  color: Colors.black12, //边框颜色
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Divider(height: 1, color: Colors.black45)],
            ),
          ));
      widgets.add(widget);
    });

    return widgets;
  }

  List<Widget> listItems(PlanWeek planWeek) {
    List<Widget> widgets = [];

    planWeek?.days?.forEach((item) {
      Widget widget = Container(
        height: planTimes.length * itemH,
        width: itemW,
        child: Column(
          children: listItem(item),
        ),
      );
      widgets.add(widget);
    });

    return widgets;
  }

  shopList2(BuildContext context, PlanWeek planWeek) {
    //第二层横向list的item

    return Container(
      width: itemW * 7,
      child: Row(children: listItems(planWeek)),
    );
  }
}
