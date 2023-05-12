import 'package:flutter/material.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/utils/app_date_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({
    Key? key,
  }) : super(key: key);

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  DateTime? _date;
  TimeOfDay? _timeOfDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DateTime"),
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return ListView(
      children: [
        //Pick date
        ListTile(
          title: Text(
              "Pick Date${_date != null ? ": ${_date!.toIso8601String()}" : ""}"),
          trailing: const Icon(Icons.chevron_right),
          onTap: _openDatePicker,
        ),
        //Pick date & time
        ListTile(
          title: Text(
              "Pick DateTime ${_timeOfDay != null ? ": ${_timeOfDay!.toString()}" : ""}"),
          trailing: const Icon(Icons.chevron_right),
          onTap: _openDateTimePicker,
        ),
        //Date to String
        const ListTile(title: Text("DateTime String")),
        _buildDateToStringWidget(),
      ],
    );
  }

  void _openDatePicker() async {
    final dateTime = await AppDialog.showDateDialog(context);
    setState(() {
      _date = dateTime;
    });
  }

  void _openDateTimePicker() async {
    final timeOfDay = await AppDialog.showTimeDialog(context);
    setState(() {
      _timeOfDay = timeOfDay;
    });
  }

  Widget _buildDateToStringWidget() {
    DateTime now = DateTime.now();
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              const Text("Ref: "),
              InkWell(
                  child: const Text(
                    'https://www.w3.org/TR/NOTE-datetime',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () => launchUrl(
                      Uri.parse('https://www.w3.org/TR/NOTE-datetime'))),
            ],
          ),
          Row(
            children: [
              const Text(
                "Flutter: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(now.toUtc().toIso8601String()),
            ],
          ),
          Row(
            children: [
              const Text(
                "ISO 8601: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(now.toUtc().toIso8601String()),
            ],
          ),
          Row(
            children: [
              const Text(
                "Date: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(AppDateUtils.toDateString(now)),
            ],
          ),
          Row(
            children: [
              const Text(
                "DateTime: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(AppDateUtils.toDateTimeString(now)),
            ],
          ),
          Row(
            children: [
              const Text(
                "Date API: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(AppDateUtils.toDateAPIString(now)),
            ],
          ),
          Row(
            children: [
              const Text(
                "DateTime API: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(AppDateUtils.toDateTimeAPIString(now,
                  format: "yyyy-MM-dd'T'HH:mm:ss.SSS")),
            ],
          ),
        ],
      ),
    );
  }
}
