import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/features/auth/presentation/check_user_cubit/check_user_cubit.dart';
import 'package:taskmanager/features/auth/presentation/screen/login_screen.dart';
import 'package:taskmanager/features/bottom_nav/bottom_nav_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CheckUserCubit>().checkUser();
    return BlocBuilder<CheckUserCubit, CheckUserState>(
      builder: (context, state) {
        if (state is UserLoggedIn) {
          return const BottomNavScreen();
        } else if (state is UserLoggedOut) {
          return const LoginScreen();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
