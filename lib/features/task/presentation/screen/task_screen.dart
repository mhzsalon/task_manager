import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/firebase/firebase_helper.dart';
import 'package:taskmanager/core/resources/app_colors.dart';
import 'package:taskmanager/core/resources/text_theme.dart';
import 'package:taskmanager/core/utils/dimens.dart';
import 'package:taskmanager/core/utils/utils.dart';
import 'package:taskmanager/features/bottom_nav/cubit/bottom_nav_cubit.dart';
import 'package:taskmanager/features/task/data/model/task_model.dart';
import 'package:taskmanager/features/task/presentation/widget/task_card_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ['Pending', 'Running', 'Testing', 'Completed'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16 * Utils.getScalingFactor(context),
            top: 10 * Utils.getScalingFactor(context),
          ),
          child: TabBar(
            controller: _tabController,
            labelPadding: EdgeInsets.only(
              right: 12 * Utils.getScalingFactor(context),
            ),
            labelStyle: AppTextTheme.bodyText,
            isScrollable: true,
            dividerHeight: 0,
            tabAlignment: TabAlignment.start,
            indicator: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(18),
            ),
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: List.generate(
              tabs.length,
              (index) => _tabItemWidget(tabs[index], index),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: 10 * Utils.getScalingFactor(context),
              right: 10 * Utils.getScalingFactor(context),
              top: 20 * Utils.getScalingFactor(context),
            ),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseHelper.fetchTask(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return _emptyTaskWidget();
                }

                List<Map<String, dynamic>> tasks =
                    snapshot.data!.docs.map((doc) => doc.data()).toList();

                List<TaskModel> taskModel =
                    tasks.map((e) => TaskModel.fromMap(e)).toList();
                return TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children:
                      tabs.map((status) {
                        List<TaskModel> filteredTask =
                            taskModel.where((e) => e.status == status).toList();

                        return filteredTask.isEmpty
                            ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("No ${status.toLowerCase()} tasks found."),
                              ],
                            )
                            : ListView.builder(
                              itemCount: filteredTask.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return TaskCardWidget(
                                  taskModel: filteredTask[index],
                                );
                              },
                            );
                      }).toList(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _emptyTaskWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No tasks found."),
        ElevatedButton(
          onPressed: () => context.read<BottomNavCubit>().updateIndex(1),
          child: Text("Create Task"),
        ),
      ],
    );
  }

  Widget _tabItemWidget(String tab, int index) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * Utils.getScalingFactor(context),
        vertical: 12 * Utils.getScalingFactor(context),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(tab),
    );
  }
}
