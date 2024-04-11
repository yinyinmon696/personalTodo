import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personaltodoapp/common_widgets/custom_buttom.dart';
import 'package:personaltodoapp/common_widgets/custom_text_from_field.dart';
import 'package:personaltodoapp/features/personal_todo/domain/personal_todo_model.dart';
import 'package:personaltodoapp/features/personal_todo/presentation/bloc/todo_bloc.dart';
import 'package:personaltodoapp/theme/colors.dart';
import 'package:personaltodoapp/utils/constants.dart';

class PersonalTodoUpdatePage extends StatefulWidget {
  final PersonalTodoModel personalTodoModel;
  const PersonalTodoUpdatePage({super.key, required this.personalTodoModel});

  @override
  State<PersonalTodoUpdatePage> createState() => _PersonalTodoUpdatePageState();
}

class _PersonalTodoUpdatePageState extends State<PersonalTodoUpdatePage> {
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    descriptionController.text = widget.personalTodoModel.title ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsLight.primary,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Update Personal Todo',
          style: TextStyle(color: ColorsLight.white),
        ),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is UpdateTodoFailed) {
            final snackBar = SnackBar(
              content: Text(state.message.toString()),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is UpdateTodoSuccess) {
            const snackBar = SnackBar(
              content: Text('Update Successfully!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // log('success');
            widget.personalTodoModel.done = false;
            descriptionController.clear();
            context.read<TodoBloc>().add(GetAllTodoList());
          }
        },
        builder: (context, state) {
          if (state is UpdateTodoLoading) {
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
                    Checkbox(
                        value: widget.personalTodoModel.done,
                        onChanged: (bool? value) {
                          setState(() {
                            widget.personalTodoModel.done = value;
                          });
                        }),
                    gapH32,
                    Row(
                      children: [
                        const Expanded(child: gapH12),
                        CustomButtom(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final description = descriptionController.text;
                                final personalTodoModel = PersonalTodoModel(
                                    id: widget.personalTodoModel.id,
                                    title: description,
                                    done: widget.personalTodoModel.done);
                                context.read<TodoBloc>().add(UpdateTodo(
                                    personalTodoModel: personalTodoModel));
                              }
                            },
                            text: 'Update'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
