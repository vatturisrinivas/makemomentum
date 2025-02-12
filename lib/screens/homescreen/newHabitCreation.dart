import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/habitsModel.dart';
import '../../providers/habitProvider.dart';
import '../../widgets/NotificationHelper.dart';
import '../../widgets/floatingActionButtonAnimation.dart';
import '../../widgets/floatingActionButtonLocation.dart';
import '../../widgets/timeSelecting.dart';

class newHabitCreation extends StatelessWidget {
  const newHabitCreation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: AnimatedFABWrapper(
        floatingActionButton: FloatingActionButton(
          child: Text("Create Habit", style: TextStyle(fontSize: 20)),
          onPressed: () async {
            await NotificationHelper().requestNotificationPermission();
            _showAddHabitDialog(context);
          },
        ),
      ),
    );
  }
}
void _showAddHabitDialog(BuildContext context) {
  final habitProvider = Provider.of<HabitProvider>(context, listen: false);
  final TextEditingController _titleController = TextEditingController();
  List<bool> selectedDays = List.generate(7, (index) => false);

  // Variables to store selected time
  int selectedHour = TimeOfDay.now().hour % 12;
  int selectedMinute = TimeOfDay.now().minute;
  String selectedPeriod = TimeOfDay.now().period == DayPeriod.am ? "AM" : "PM";

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        backgroundColor: Color(0xFFD4BEE4),
        //title: const Text('Add Habit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                fillColor: Color(0xFF9B7EBD),
                filled: true,
                labelText: "Habit Title",
                labelStyle: TextStyle(
                  color: Color(0xFF3B1E54), // Set the label text color// Optional: Adjust font size
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.black
                    )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Color(0xFF3B1E54), // Outline color when focused
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Color(0xFF9B7EBD), // Outline color when not focused
                    width: 2.0,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 200,
              child: WheelPickerExample(
                onTimeChanged: (hour, minute, period) {
                  selectedHour = hour;
                  selectedMinute = minute;
                  selectedPeriod = period;
                  setState(() {}); // Update UI dynamically
                },
              ),
            ),

            // Wrap(
            //   children: List.generate(7, (index) {
            //     return ChoiceChip(
            //       label: Text(['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][index]),
            //       selected: selectedDays[index],
            //       onSelected: (bool selected) {
            //         setState(() {
            //           selectedDays[index] = selected;
            //         });
            //       },
            //     );
            //   }),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(7, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDays[index] = !selectedDays[index]; // Toggle selection
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: selectedDays[index] ? Color(0xFF3B1E54) : Color(0xFF9B7EBD), // Selected/unselected color
                        shape: BoxShape.circle,
                        boxShadow: selectedDays[index]? [BoxShadow(color: Colors.black54,blurRadius: 5,spreadRadius: 4,offset: Offset(4,4))]:[],
                      ),
                      child: Center(
                        child: Text(
                          ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'][index],
                          style: TextStyle(
                            color: selectedDays[index] ? Colors.white : Colors.black, // Text color
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Cancel',),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFF3B1E54),
                  backgroundColor: Color(0xFF9B7EBD),
                  //side: BorderSide(color: Color(0xFF9B7EBD), width: 1), // Border color and width
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      selectedDays.contains(true)) {
                    final adjustedHour = selectedPeriod == "PM" && selectedHour < 12
                        ? selectedHour + 12
                        : selectedPeriod == "AM" && selectedHour == 12
                        ? 0
                        : selectedHour;

                    final selectedTime = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      adjustedHour,
                      selectedMinute,
                    );

                    habitProvider.addHabit(
                      Habit(
                        title: _titleController.text,
                        scheduledTime: selectedTime,
                        recurringDays: selectedDays
                            .asMap()
                            .entries
                            .where((entry) => entry.value)
                            .map((entry) => entry.key)
                            .toList(),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFF3B1E54),
                  backgroundColor: Color(0xFF9B7EBD),
                  //side: BorderSide(color: Color(0xFF3B1E54), width: 1), // Border color and width
                ),
              ),
            ],
          )

        ],
      ),
    ),
  );
}
