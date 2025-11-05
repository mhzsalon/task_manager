import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/resources/app_colors.dart';
import 'package:taskmanager/core/resources/text_theme.dart';
import 'package:taskmanager/core/utils/dimens.dart';
import 'package:taskmanager/core/utils/navigation.dart';
import 'package:taskmanager/core/utils/utils.dart';
import 'package:taskmanager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanager/features/auth/presentation/check_user_cubit/check_user_cubit.dart';
import 'package:taskmanager/features/auth/presentation/screen/login_screen.dart';
import 'package:taskmanager/features/bottom_nav/cubit/bottom_nav_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * Utils.getScalingFactor(context),
        vertical: 40 * Utils.getScalingFactor(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/dp.jpg",
              height: 100 * Utils.getScalingFactor(context),
              width: 100 * Utils.getScalingFactor(context),
            ),
          ),
          SizedBox(height: 10 * Utils.getScalingFactor(context)),
          Text(
            "Full Name",
            style: AppTextTheme.titleText.copyWith(fontWeight: FontWeight.w800),
          ),
          Text("mhze@test.com", style: AppTextTheme.subTitleText),
          SizedBox(height: 40 * Utils.getScalingFactor(context)),

          BlocListener<CheckUserCubit, CheckUserState>(
            listener: (context, state) {
              if (state is UserLoggedOut) {
                Navigation.pushandRemoveUntil(context, LoginScreen());
                context.read<BottomNavCubit>().updateIndex(0);
              }
            },
            child: GestureDetector(
              onTap: () => context.read<CheckUserCubit>().logOutUser(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * Utils.getScalingFactor(context),
                  vertical: 10 * Utils.getScalingFactor(context),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Logout"), Icon(Icons.logout_outlined)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
