import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/resources/app_colors.dart';
import 'package:taskmanager/core/resources/text_theme.dart';
import 'package:taskmanager/core/utils/dimens.dart';
import 'package:taskmanager/core/utils/utils.dart';
import 'package:taskmanager/features/auth/presentation/screen/profile_screen.dart';
import 'package:taskmanager/features/bottom_nav/cubit/bottom_nav_cubit.dart';
import 'package:taskmanager/features/task/presentation/screen/create_task_screen.dart';
import 'package:taskmanager/features/task/presentation/screen/task_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List<Widget> _screens = [
    TaskScreen(),
    CreateTaskScreen(),
    ProfileScreen(),
  ];
  final List<String> screenTitle = ['Tasks', 'Create Task', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle[context.watch<BottomNavCubit>().state]),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30 * Utils.getScalingFactor(context),
            vertical: 14 * Utils.getScalingFactor(context),
          ),
          margin: EdgeInsets.only(
            left: 10 * Utils.getScalingFactor(context),
            right: 10 * Utils.getScalingFactor(context),
            bottom: 14 * Utils.getScalingFactor(context),
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _bottomNavItemWidget(icon: CupertinoIcons.home, index: 0),
              _bottomNavItemWidget(icon: CupertinoIcons.add, index: 1),
              _bottomNavItemWidget(icon: CupertinoIcons.person, index: 2),
            ],
          ),
        ),
      ),
      body: _screens[context.watch<BottomNavCubit>().state],
      // body: Container(),
    );
  }

  Widget _bottomNavItemWidget({required IconData icon, required int index}) {
    int currentIndex = context.watch<BottomNavCubit>().state;
    return GestureDetector(
      onTap: () => context.read<BottomNavCubit>().updateIndex(index),
      child:
          currentIndex == index
              ? Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Icon(icon, color: AppColors.primaryColor, size: 20),
              )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, color: AppColors.white, size: 22),
              ),
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
