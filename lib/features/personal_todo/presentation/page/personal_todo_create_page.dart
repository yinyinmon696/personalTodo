import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personaltodoapp/common_widgets/custom_buttom.dart';
import 'package:personaltodoapp/common_widgets/custom_text_from_field.dart';
import 'package:personaltodoapp/features/personal_todo/domain/personal_todo_model.dart';
import 'package:personaltodoapp/features/personal_todo/presentation/bloc/todo_bloc.dart';
import 'package:personaltodoapp/features/personal_todo/presentation/todo_online_bloc/bloc/todo_online_bloc.dart';
import 'package:personaltodoapp/theme/colors.dart';
import 'package:personaltodoapp/utils/constants.dart';

class PersonalTodoCreatePage extends StatefulWidget {
  const PersonalTodoCreatePage({super.key});

  @override
  State<PersonalTodoCreatePage> createState() => _PersonalTodoCreatePageState();
}

class _PersonalTodoCreatePageState extends State<PersonalTodoCreatePage> {
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsLight.primary,
          title: const Text(
            'Create Personal Todo',
            style: TextStyle(color: ColorsLight.white),
          ),
        ),
        body: BlocConsumer<TodoOnineBloc, TodoOnineState>(
          listener: (context, state) {
            if (state is CreateTodoFailed) {
              context.read<TodoBloc>().add(GetAllTodoList());
              descriptionController.clear();
            }
            if (state is CreateTodoSuccess) {
              final personalTodoModel = PersonalTodoModel(
                  id: state.id,
                  title: descriptionController.text,
                  done: false,
                  needToSync: false);
              context
                  .read<TodoBloc>()
                  .add(UpdateTodo(personalTodoModel: personalTodoModel));
              context.read<TodoBloc>().add(GetAllTodoList());
              context.read<TodoOnineBloc>().add(GetAllTodoServerList());
              descriptionController.clear();
            }
          },
          builder: (context, state) {
            return BlocConsumer<TodoBloc, TodoState>(
              listener: (context, state) {
                if (state is UpdateTodoSuccess) {
                  context.read<TodoBloc>().add(GetAllTodoList());
                }
                if (state is AddTodoFailed) {
                  final snackBar = SnackBar(
                    content: Text(state.message.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (state is AddTodoSuccess) {
                  const snackBar = SnackBar(
                    content: Text('Add Successfully!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  if (state.personalTodoModel.needToSync == true) {
                    state.personalTodoModel.needToSync = false;
                    context.read<TodoOnineBloc>().add(
                        CreateToDo(personalTodoModel: state.personalTodoModel));
                  }
                }
              },
              builder: (context, state) {
                if (state is AddTodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(Sizes.p8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Write Test',
                            style: TextStyle(fontSize: 16),
                          ),
                          gapH12,
                          CustomTextFormField(
                            prefixIcon: const Icon(Icons.app_registration),
                            controller: descriptionController,
                            hintText: 'Description.....',
                          ),
                          gapH32,
                          Row(
                            children: [
                              const Expanded(child: gapH12),
                              CustomButtom(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      final description =
                                          descriptionController.text;
                                      final personalTodoModel =
                                          PersonalTodoModel(
                                              title: description,
                                              done: false,
                                              needToSync: true);
                                      context.read<TodoBloc>().add(AddTodo(
                                          personalTodoModel:
                                              personalTodoModel));
                                    }
                                  },
                                  text: 'Add'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
