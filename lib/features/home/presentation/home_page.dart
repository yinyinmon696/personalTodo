// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personaltodoapp/features/personal_todo/presentation/page/personal_todo_create_page.dart';
import 'package:personaltodoapp/features/personal_todo/presentation/page/personal_todo_offline_list_page.dart';
import 'package:personaltodoapp/features/personal_todo/presentation/page/personal_todo_online_list_page.dart';
import 'package:personaltodoapp/features/personal_todo/presentation/todo_online_bloc/bloc/todo_online_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late StreamSubscription<List<ConnectivityResult>> subscription;

  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile)) {
      } else if (result.contains(ConnectivityResult.wifi)) {
      } else if (result.contains(ConnectivityResult.ethernet)) {}
    });

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 2) {
      context.read<TodoOnineBloc>().add(GetAllTodoServerList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IndexedStack(
        index: _selectedIndex,
        children: const <Widget>[
          PersonalTodoCreatePage(),
          PersonalTodoOfflineListPage(),
          PersonalTodoOnlineListPage(),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Offline List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Online List',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: 'Setting',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
