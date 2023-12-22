import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Todo/core/cubit/cubit.dart';
import 'package:Todo/core/cubit/states.dart';
import 'package:Todo/core/models/task_model.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TaskCubit.get(context).tasks;
        var cubit = TaskCubit.get(context);
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => TaskItem(
                  context,
                  TaskModel(
                    id: tasks[index]['id'],
                    title: tasks[index]['title'],
                    date: tasks[index]['date'],
                    time: tasks[index]['time'],
                  ),
                  cubit,
                ),
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: const Color.fromARGB(255, 71, 71, 71),
                ),
                itemCount: tasks.length,
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        );
      },
    );
  }

  Widget TaskItem(BuildContext context, TaskModel task, cubit) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // height: 80,
          padding: const EdgeInsets.all(10),
          color: const Color.fromARGB(23, 35, 33, 36),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Text(
                        task.time,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                task.title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          Text(
                            task.date,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text('Options'),
                        TextButton(
                          onPressed: () {
                            TaskCubit.get(context).doneTask(task.id);
                          },
                          style: const ButtonStyle(
                            iconColor: MaterialStatePropertyAll(Colors.green),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.check_circle_outline),
                              Text(
                                'Done',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            TaskCubit.get(context).pinTask(task.id);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.push_pin),
                              Text('Pin'),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                final ValueNotifier<bool> isChecked =
                                    ValueNotifier<bool>(false);
                                var titleController = TextEditingController();
                                var timeController = TextEditingController();
                                var dateController = TextEditingController();
                                titleController.text = task.title;
                                dateController.text = task.date;
                                timeController.text = task.time;
                                return AlertDialog(
                                  actionsAlignment: MainAxisAlignment.start,
                                  title: const Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Edit Task',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: titleController,
                                        keyboardType: TextInputType.text,
                                        validator: (value) => (value!.isEmpty)
                                            ? "Title is empty."
                                            : null,
                                        decoration: const InputDecoration(
                                          labelText: 'Task title',
                                          prefixIcon: Icon(Icons.title),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        controller: dateController,
                                        keyboardType: TextInputType.datetime,
                                        validator: (value) => (value!.isEmpty)
                                            ? "date is empty."
                                            : null,
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now()
                                                .add(const Duration(days: 30)),
                                          ).then(
                                            (value) {
                                              dateController.text =
                                                  dateController.text =
                                                      DateFormat.yMMMd()
                                                          .format(value!);
                                            },
                                          );
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Task date',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          prefixIcon: Icon(Icons.date_range),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        controller: timeController,
                                        keyboardType: TextInputType.datetime,
                                        validator: (value) => (value!.isEmpty)
                                            ? "Time is empty."
                                            : null,
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            timeController.text =
                                                value!.format(context);
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Task time',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          prefixIcon: Icon(Icons.watch_later),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text('Do you want to pin it.'),
                                          ValueListenableBuilder<bool>(
                                            valueListenable: isChecked,
                                            builder: (context, value, child) {
                                              return Checkbox(
                                                value: value,
                                                onChanged: (value) {
                                                  isChecked.value = value!;
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 60,
                                            height: 30,
                                            child: FloatingActionButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: 60,
                                            height: 30,
                                            child: FloatingActionButton(
                                              onPressed: () {
                                                if (titleController
                                                        .text.isNotEmpty &&
                                                    dateController
                                                        .text.isNotEmpty &&
                                                    timeController
                                                        .text.isNotEmpty) {
                                                  cubit.updateTask(
                                                    id: task.id,
                                                    title: titleController.text,
                                                    date: dateController.text,
                                                    time: timeController.text,
                                                    status: isChecked.value,
                                                  );
                                                }
                                              },
                                              child: const Text('Ok'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.edit),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        TextButton(
                          style: const ButtonStyle(
                            iconColor: MaterialStatePropertyAll(Colors.red),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: ((BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: const Text('are you sure!!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        cubit.deleteTask(task.id);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('yes'),
                                    ),
                                  ],
                                );
                              }),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.delete),
                              Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
