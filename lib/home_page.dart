import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';
import 'package:trello_demo/widgets/card.dart';
import 'package:trello_demo/widgets/list_header.dart';
import 'kanban_data.dart';
import 'widgets/board_header.dart';
import 'widgets/list_footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get width =>
      Platform.isAndroid ||  Platform.isIOS ? 250.0 : 150.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 244, 240, 1),
      body: SafeArea(
          child: Column(
        children: [
          const BoardHeader(),
          Container(
            height: 1,
            width: MediaQuery.sizeOf(context).width,
            color: Colors.black,
          ),
          Expanded(
            child: KanbanBoard(
              List.generate(kanbanData.length, (index) {
                final element = kanbanData.values.elementAt(index);
                return BoardListsData(
                    backgroundColor: const Color.fromRGBO(249, 244, 240, 1),
                    width: width,
                    // footer: const ListFooter(),
                    headerBackgroundColor:
                        const Color.fromRGBO(249, 244, 240, 1),
                    header: ListHeader(
                      title: kanbanData.keys.elementAt(index),
                      statColor: element['color'],
                    ),
                    items: List.generate(element['items'].length, (index) {
                      int totalTasks = int.parse(element['items'][index]
                              ['tasks']
                          .toString()
                          .split('/')
                          .last);
                      int completedTasks = int.parse(element['items'][index]
                              ['tasks']
                          .toString()
                          .split('/')
                          .first);

                      return KanbanCard(
                          title: element['items'][index]['title'],
                          completedTask: completedTasks,
                          totalTasks: totalTasks,
                          date: element['items'][index]['date'],
                          tasks: element['items'][index]['tasks'],
                          avatar: persons[index % 4]);
                    }));
              }),
              onItemLongPress: (cardIndex, listIndex) {},
              onItemReorder:
                  (oldCardIndex, newCardIndex, oldListIndex, newListIndex) {},
              onListLongPress: (listIndex) {},
              onListReorder: (oldListIndex, newListIndex) {},
              onItemTap: (cardIndex, listIndex) {},
              onListTap: (listIndex) {},
              onListRename: (oldName, newName) {},
              backgroundColor: const Color.fromRGBO(249, 244, 240, 1),
              displacementY: 124,
              displacementX: 100,
              textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),

        ],
      )),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.call),
      //       label: 'Calls',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.camera),
      //       label: 'Camera',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.chat),
      //       label: 'Chats',
      //     ),
      //   ],
      // ),
    );
  }
}
