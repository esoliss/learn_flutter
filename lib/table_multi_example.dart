// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class TableEventsExample extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  int pastDays = 0;
  int tTrans = 0;
  int dTrans = 0;
  bool isTurn = false; //false Turno 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TableCalendar<Event>(
              headerStyle: const HeaderStyle(formatButtonVisible: false),
              calendarBuilders:
                  CalendarBuilders(singleMarkerBuilder: ((context, day, event) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: isTurn ? Colors.blue : Colors.green,
                    //border: Border.all(),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  width: 25.0,
                  height: 9.0,
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  child: isTurn
                      ? const Text('Turno 1',
                          style: TextStyle(color: Colors.white, fontSize: 7),
                          textAlign: TextAlign.center)
                      : const Text('Turno 2',
                          style: TextStyle(color: Colors.white, fontSize: 7),
                          textAlign: TextAlign.center),
                );
              })),
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              rowHeight: 100,
              //eventLoader: _getEventsForDay,
              eventLoader: (day) {
                pastDays = day.difference(DateTime(2022, 12, 26)).inDays;
                tTrans = pastDays ~/ 14;
                dTrans = pastDays % 14;
                if (tTrans % 2 == 0) {
                  if (pastDays % 14 == 0) {
                    isTurn = false;
                  } else {
                    isTurn = true;
                  }
                  return [const Event('Turno')];
                } else {
                  if (pastDays % 14 == 0) {
                    isTurn = true;
                  } else {
                    isTurn = false;
                  }
                  return [const Event('Turno')];
                }
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: const CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                outsideDaysVisible: true,
              ),
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    //_calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ],
        ),
      ),
    );
  }
}
