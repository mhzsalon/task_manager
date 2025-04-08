import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/core/enums/task_enum.dart';
import 'package:taskmanager/core/firebase/firebase_helper.dart';
import 'package:taskmanager/core/resources/app_colors.dart';
import 'package:taskmanager/core/resources/text_theme.dart';
import 'package:taskmanager/core/utils/dimens.dart';
import 'package:taskmanager/core/utils/navigation.dart';
import 'package:taskmanager/core/utils/utils.dart';
import 'package:taskmanager/features/task/data/model/task_model.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel taskModel;
  const TaskCardWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    String taskStatus = taskModel.status.toLowerCase();
    Color backgroundColor =
        taskStatus == TaskStatusEnum.completed.name
            ? AppColors.completedColor
            : taskStatus == TaskStatusEnum.pending.name
            ? AppColors.pendingColor
            : taskStatus == TaskStatusEnum.testing.name
            ? AppColors.testingColor
            : AppColors.runningColor;

    Color titleColor =
        taskStatus == TaskStatusEnum.completed.name
            ? AppColors.completedTitleColor
            : taskStatus == TaskStatusEnum.pending.name
            ? AppColors.pendingTitleColor
            : taskStatus == TaskStatusEnum.testing.name
            ? AppColors.testingTitleColor
            : AppColors.runningTitleColor;
    return Container(
      margin: EdgeInsets.only(bottom: sizeX6 * Utils.getScalingFactor(context)),
      width: Utils().width,
      padding: EdgeInsets.symmetric(
        vertical: sizeX16 * Utils.getScalingFactor(context),
        horizontal: sizeX22 * Utils.getScalingFactor(context),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                taskModel.taskName,
                style: AppTextTheme.titleText.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: sizeX10 * Utils.getScalingFactor(context),
                  vertical: sizeX4 * Utils.getScalingFactor(context),
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  taskModel.status,
                  style: AppTextTheme.labelText.copyWith(
                    color: AppColors.completedTitleColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: sizeX8 * Utils.getScalingFactor(context)),
          Text(
            taskModel.description,
            style: AppTextTheme.subTitleText.copyWith(color: AppColors.label),
          ),
          SizedBox(height: sizeX12 * Utils.getScalingFactor(context)),

          if (taskStatus != TaskStatusEnum.completed.name)
            GestureDetector(
              onTap: () => showConfirmationDialog(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Move to next stage",
                    style: AppTextTheme.bodyText.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: sizeX6 * Utils.getScalingFactor(context)),
                  Icon(
                    CupertinoIcons.arrow_right,
                    size: sizeX18 * Utils.getScalingFactor(context),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to move this task to next stage?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigation.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                FirebaseHelper.moveTaskStage(
                  taskModel.taskId,
                  taskModel.status,
                );
                Navigation.pop(context);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
