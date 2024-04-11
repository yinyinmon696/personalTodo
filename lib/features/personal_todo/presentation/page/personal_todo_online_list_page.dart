// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personaltodoapp/features/personal_todo/presentation/todo_online_bloc/bloc/todo_online_bloc.dart';
import 'package:personaltodoapp/theme/colors.dart';
import 'package:personaltodoapp/utils/constants.dart';

class PersonalTodoOnlineListPage extends StatefulWidget {
  const PersonalTodoOnlineListPage({super.key});

  @override
  State<PersonalTodoOnlineListPage> createState() =>
      _PersonalTodoOnlineListPageState();
}

class _PersonalTodoOnlineListPageState
    extends State<PersonalTodoOnlineListPage> {
  final descriptionController = TextEditingController();

  @override
  void initState() {
    context.read<TodoOnineBloc>().add(GetAllTodoServerList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsLight.primary,
        title: const Text(
          'Personal Todo Server List',
          style: TextStyle(color: ColorsLight.white),
        ),
      ),
      body: BlocConsumer<TodoOnineBloc, TodoOnineState>(
        listener: (context, state) {
          if (state is GetAllTodoServerListFailed) {
            final snackBar = SnackBar(
              content: Text(state.message.toString()),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is GetAllTodoServerListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetAllTodoServerListSuccess) {
            if (state.serverList == []) {
              return const Center(
                child: Text('There is no data!'),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<TodoOnineBloc>().add(GetAllTodoServerList());
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.p8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Personal Todo List',
                          style: TextStyle(fontSize: 16),
                        ),
                        Scrollbar(
                          thickness: 3,
                          trackVisibility: true,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: DataTable(
                                headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => ColorsLight.bgColor,
                                ),
                                dataRowColor: MaterialStateColor.resolveWith(
                                  (states) => ColorsLight.white,
                                ),
                                dividerThickness: 0.1,
                                headingRowHeight: 45,
                                border: TableBorder.all(
                                  color: ColorsLight.borderStoke,
                                  borderRadius: BorderRadius.circular(
                                    Sizes.p12,
                                  ),
                                  style: BorderStyle.none,
                                ),
                                columnSpacing: 12,
                                horizontalMargin: 12,
                                columns: [
                                  const DataColumn(label: Text('Status')),
                                  DataColumn(
                                      label: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.38,
                                          child: const Text('Title'))),
                                ],
                                rows: List.generate(
                                    state.serverList.length,
                                    (index) => _getDataRow(
                                        state.serverList[index], index)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  DataRow _getDataRow(result, int index) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Checkbox(value: result.done, onChanged: (bool? value) {})),
        DataCell(SizedBox(
          width: 200,
          child: Text(
            result.title,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        )),
      ],
    );
  }
}
