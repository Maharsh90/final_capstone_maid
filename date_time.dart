import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: DateSelectorPage(),));
}

class DateSelectorPage extends StatefulWidget {
  const DateSelectorPage({Key? key}) : super(key: key);

  @override
  _DateSelectorPageState createState() => _DateSelectorPageState();
}

class _DateSelectorPageState extends State<DateSelectorPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date and Time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a date:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date selected'
                        : 'Selected date: ${_selectedDate!.toString()}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                IconButton(
                  onPressed: () => _selectDate(context),
                  icon: Icon(Icons.calendar_today),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Select a time:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedTime == null
                        ? 'No time selected'
                        : 'Selected time: ${_selectedTime!.format(context)}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                IconButton(
                  onPressed: () => _selectTime(context),
                  icon: Icon(Icons.access_time),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Here you can handle the selected date and time and navigate to the next page
                if (_selectedDate != null && _selectedTime != null) {
                  DateTime selectedDateTime = DateTime(
                    _selectedDate!.year,
                    _selectedDate!.month,
                    _selectedDate!.day,
                    _selectedTime!.hour,
                    _selectedTime!.minute,
                  );
                  print('Selected date and time: $selectedDateTime');
                  // Navigate to the next page with the selectedDateTime
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
