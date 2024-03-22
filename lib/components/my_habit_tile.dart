import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:provider/provider.dart';

class MyHabitTile extends StatelessWidget {
   final Habit habit;
  final String text;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;
  final List<Habit> completedTasks;
  const MyHabitTile(
      {super.key,
      required this.habit, 
      required this.text,
      required this.isCompleted,
      required this.onChanged,
      required this.editHabit,
      required this.deleteHabit,
      required this.completedTasks, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //info
  SlidableAction(
  onPressed: (context) async {
   final habitDatabase = Provider.of<HabitDatabase>(context, listen: false);
   final completedTasks = await habitDatabase.getCompletedTasksForHabit(habit.id);
 Navigator.push(
      context,
      MaterialPageRoute(
         builder: (context) => InfoHabit(
                      habitName: habit.name,
                      completedTasks: completedTasks, // Pass completedTasks here
                    ),
      ),
    );
  },
  backgroundColor: Colors.blue.shade800,
  icon: Icons.calendar_month,
  borderRadius: BorderRadius.circular(8),
),
            //edit
            SlidableAction(
              onPressed: editHabit,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(8),
            ),

            //delete
            SlidableAction(
              onPressed: deleteHabit,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              //toggle completion status
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(text,
                  style: TextStyle(
                      color: isCompleted
                          ? Colors.white
                          : Theme.of(context).colorScheme.inversePrimary)),
              leading: Checkbox(
                activeColor: Colors.green,
                side: isCompleted
                    ? (const BorderSide(color: Colors.white))
                    : (const BorderSide(color: Colors.black)),
                value: isCompleted,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoHabit extends StatelessWidget {
  final String habitName;
  final List<Habit> completedTasks;

  const InfoHabit({
    Key? key,
    required this.habitName,
    required this.completedTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredTasks = completedTasks
        .where((habit) => habit.name == habitName)
        .expand((habit) => habit.completedDays.map((date) => {'name': habit.name, 'date': date}))
        .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Logs"),
      ),
      body:  Container(
  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10), // Adjust margin as needed
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
  ),
  child: ListView.builder(
    itemCount: filteredTasks.length,
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(), // Ensure list is always scrollable
    itemBuilder: (context, index) {
      final task = filteredTasks[index];
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5), // Adjust margin as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),// Background color of each list item
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: ListTile(
          title:completedTasks.isEmpty ? const Text("No Record of finishing this habit",style: TextStyle(fontSize: 18),) : Text('Habit: ${task['name']}\nCompleted Date: ${task['date'].toString().split(' ')[0]}',style:const TextStyle(fontSize: 18),),
          contentPadding: const EdgeInsets.all(12),
        ),
      );
    },
  ),
),

    );
  }
}