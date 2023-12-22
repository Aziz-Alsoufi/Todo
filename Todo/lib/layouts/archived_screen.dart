import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Todo/core/components.dart';
import 'package:Todo/core/cubit/cubit.dart';
import 'package:Todo/core/cubit/states.dart';
import 'package:Todo/core/models/task_model.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {},
      builder: (context, state) {
        print('New State ------------------------------------------------------------------------');
        var cubit = TaskCubit.get(context);
        var tasks = cubit.archived;
        if (tasks.isEmpty) {
          return cubit.nullScreens[2];
        }
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => TaskItem(
                  context,
                  TaskModel(
                    id: tasks[index]["id"],
                    title: tasks[index]['title'],
                    date: tasks[index]['date'],
                    time: tasks[index]['time'],
                  ),
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

  Widget TaskItem(BuildContext context, TaskModel task) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
                              Directionality(
                                textDirection: isArabic(task.title)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: Text(
                                  task.title,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
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
                          onPressed: () {},
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
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.pin),
                              Text('Unpin'),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
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
                              Text('Delete', style: TextStyle(color: Colors.red)),
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
