import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personaltodoapp/features/personal_todo/domain/personal_todo_model.dart';
import 'package:personaltodoapp/features/personal_todo/presentation/bloc/todo_bloc.dart';
import 'package:personaltodoapp/features/personal_todo/presentation/page/personal_todo_update_page.dart';
import 'package:personaltodoapp/features/personal_todo/presentation/todo_online_bloc/bloc/todo_online_bloc.dart';
import 'package:personaltodoapp/theme/colors.dart';
import 'package:personaltodoapp/utils/constants.dart';

class PersonalTodoOfflineListPage extends StatefulWidget {
  const PersonalTodoOfflineListPage({super.key});

  @override
  State<PersonalTodoOfflineListPage> createState() =>
      _PersonalTodoOfflineListPageState();
}

class _PersonalTodoOfflineListPageState
    extends State<PersonalTodoOfflineListPage> {
  final descriptionController = TextEditingController();
  List<PersonalTodoModel>? list = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(GetAllTodoList());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsLight.primary,
        title: const Text(
          'Personal Todo List',
          style: TextStyle(color: ColorsLight.white),
        ),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is GetAllTodoListFailed) {
            final snackBar = SnackBar(
              content: Text(state.message.toString()),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is DeleteTodoFailed) {
            final snackBar = SnackBar(
              content: Text(state.message.toString()),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is GetAllTodoListLoading || state is DeleteTodoLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DeleteTodoSuccess) {
            context.read<TodoBloc>().add(GetAllTodoList());
          }
          if (state is GetAllTodoListSuccess) {
            if (state.list == null) {
              return const Center(
                child: Text('There is no data!'),
              );
            }

            return SingleChildScrollView(
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
                                      width: MediaQuery.of(context).size.width *
                                          0.38,
                                      child: const Text('Title'))),
                              const DataColumn(label: Text('Edit')),
                              const DataColumn(
                                label: Text("Delete"),
                              ),
                              const DataColumn(label: Text('Sync'))
                            ],
                            rows: List.generate(
                                state.list!.length,
                                (index) =>
                                    _getDataRow(state.list?[index], index)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
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
          width: 150,
          child: Text(
            result.title,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        )),
        DataCell(
          InkWell(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PersonalTodoUpdatePage(personalTodoModel: result)));
            },
            child: const Icon(
              Icons.edit,
              color: ColorsLight.blackLight,
            ),
          ),
        ),
        DataCell(
          InkWell(
            onTap: () {
              context
                  .read<TodoBloc>()
                  .add(DeleteTodo(personalTodoModel: result));
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
        DataCell(
          result.needToSync == true
              ? InkWell(
                  onTap: () {
                    context
                        .read<TodoOnineBloc>()
                        .add(SyncTodoData(personalTodoModel: result));
                  },
                  child: const Icon(
                    Icons.sync,
                    color: Colors.green,
                  ),
                )
              : InkWell(
                  onTap: () {
                    context
                        .read<TodoOnineBloc>()
                        .add(SyncTodoData(personalTodoModel: result));
                  },
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
        ),
      ],
    );
  }
}
