import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/enums/messageType_enum.dart';
import 'package:taskmanager/core/resources/app_colors.dart';
import 'package:taskmanager/core/resources/text_theme.dart';
import 'package:taskmanager/core/utils/dimens.dart';
import 'package:taskmanager/core/utils/utils.dart';
import 'package:taskmanager/features/task/presentation/cubit/task_cubit.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final GlobalKey<FormState> taskKey = GlobalKey<FormState>();
  final TextEditingController taskName = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: taskKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sizeX24 * Utils.getScalingFactor(context),
          vertical: sizeX30 * Utils.getScalingFactor(context),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _labelTextWidget("Task name"),
              SizedBox(height: sizeX8 * Utils.getScalingFactor(context)),
              TextFormField(
                controller: taskName,
                validator: (value) => Utils.validate(value, field: "task"),

                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: sizeX14 * Utils.getScalingFactor(context),
                    vertical: sizeX16 * Utils.getScalingFactor(context),
                  ),
                ),
              ),
              SizedBox(height: sizeX22 * Utils.getScalingFactor(context)),

              _labelTextWidget("Description"),
              SizedBox(height: sizeX8 * Utils.getScalingFactor(context)),
              TextFormField(
                controller: description,
                validator: (value) => Utils.validate(value, field: "desc"),

                textCapitalization: TextCapitalization.sentences,
                maxLines: 6,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: sizeX14 * Utils.getScalingFactor(context),
                    vertical: sizeX16 * Utils.getScalingFactor(context),
                  ),
                ),
              ),

              SizedBox(height: sizeX50 * Utils.getScalingFactor(context)),

              BlocConsumer<TaskCubit, TaskState>(
                listener: (context, state) {
                  if (state is TaskSuccess) {
                    taskName.clear();
                    description.clear();
                    Utils().showSnackBar(
                      context,
                      MsgType.success,
                      state.successMsg,
                    );
                  }
                  if (state is TaskError) {
                    Utils().showSnackBar(
                      context,
                      MsgType.error,
                      state.errorMsg,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    );
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(Utils().width),
                      padding: EdgeInsets.symmetric(
                        vertical: sizeX18 * Utils.getScalingFactor(context),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      if (taskKey.currentState!.validate()) {
                        context.read<TaskCubit>().createTask(
                          taskName.text,
                          description.text,
                        );
                      }
                    },
                    child: Text(
                      "Create",
                      style: AppTextTheme.bodyText.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _labelTextWidget(String label) =>
      Text(label, style: AppTextTheme.titleText);
}
