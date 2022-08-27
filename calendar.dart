import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarDemo extends StatefulWidget {
  const CalendarDemo({Key? key}) : super(key: key);

  @override
  State<CalendarDemo> createState() => _CalendarDemoState();
}

class _CalendarDemoState extends State<CalendarDemo> {

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final today = DateTime.now();
  late DateTime firstDay;
  late DateTime lastDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting('ja_JP');
    firstDay = DateTime(today.year, today.month - 3, today.day);
    lastDay = DateTime(today.year, today.month + 3, today.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar'),
      ),
      body: TableCalendar(

        // ローカライズ
        locale: 'ja_JP',

        //選択できる最初と最後の日付
        firstDay: firstDay,
        lastDay: lastDay,

        // 色がついている日付
        focusedDay: _focusedDay,

        // どの日付をマークするかの条件を決める
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },

        // 日付をタップしたときの処理
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
            });
          }
        },

        // ヘッダーの見た目を変更する
        headerStyle: HeaderStyle(
          formatButtonVisible: false
        ),


        // カレンダーの見た目を変更する
        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, date, events) => Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                date.day.toString(),
                style: TextStyle(color: Colors.white),
              )),
          defaultBuilder: (context, date, events) => Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 1, color: Colors.grey),
              ),
              child: Text(
                date.day.toString(),
              )),
          todayBuilder: (context, date, events) => Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.orange.shade500,
                  borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                date.day.toString(),
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
