import 'package:flutter/material.dart';
import 'package:Todo/core/models/task_model.dart';

Widget TaskItem(BuildContext context, TaskModel task) {
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
                            Icon(Icons.push_pin),
                            Text('Pin'),
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
                        onPressed: () {},
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
            // AnimatedPositioned(
            // duration: const Duration(microseconds: 250),
            // right: 0, // !isPopupMenu ?// 0 : -200,
            // top: 0,
            // child: SizedBox(
            //   width: 200,
            //   height: MediaQuery.of(context).size.height,
            //   child: ListView(
            //     children: const [
            //       ListTile(/
            //         title: Text/('data'),
            //       ),
            //     ],
            //   ),
            // ),
            // ),
            // );
          ],
        ),
        // FloatingActionButton(
        //   onPressed: () {},
        //   mini: true,
        //   child: const Icon(Icons.done),
        // ),
        // const SizedBox(height: 5.0),
        // FloatingActionButton(
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       builder: ((BuildContext context) {
        //         return AlertDialog(
        //           // shadowColor: Colors.grey,
        //           title: const Text(
        //             'delete',
        //             style: TextStyle(color: Colors.red),
        //           ),
        //           content: const Text('are you sure!!'),
        //           actions: [
        //             TextButton(
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //               child: const Text('cancel'),
        //             ),
        //             TextButton(
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //               child: const Text('yes'),
        //             ),
        //           ],
        //         );
        //       }),
        //     );
        //   },
        //   mini: true,
        //   child: const Icon(Icons.delete),
        // ),
      ),
    ],
  );
}

isArabic(String text) {
  if (text.isEmpty) return false;
  RegExp arabic = RegExp(r'[\u0600-\u06ff]');
  return arabic.hasMatch(text);
}
