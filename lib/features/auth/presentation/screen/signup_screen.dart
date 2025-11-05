import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/enums/messageType_enum.dart';
import 'package:taskmanager/core/resources/app_colors.dart';
import 'package:taskmanager/core/resources/text_theme.dart';
import 'package:taskmanager/core/utils/dimens.dart';
import 'package:taskmanager/core/utils/navigation.dart';
import 'package:taskmanager/core/utils/utils.dart';
import 'package:taskmanager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanager/features/auth/presentation/screen/login_screen.dart';
import 'package:taskmanager/features/bottom_nav/bottom_nav_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 160 * Utils.getScalingFactor(context),
            left: 20 * Utils.getScalingFactor(context),
            right: 20 * Utils.getScalingFactor(context),
          ),
          child: Form(
            key: registerKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create an account",
                  style: TextStyle(
                    fontSize: font28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10 * Utils.getScalingFactor(context)),
                Text(
                  "Register to continue",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 30 * Utils.getScalingFactor(context)),
                TextFormField(
                  validator: (value) => Utils.validate(value, field: "name"),
                  controller: fullName,
                  decoration: InputDecoration(
                    labelText: "Full name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15 * Utils.getScalingFactor(context)),
                TextFormField(
                  validator: (value) => Utils.validate(value, field: "email"),
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15 * Utils.getScalingFactor(context)),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  validator:
                      (value) => Utils.validate(value, field: "password"),
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 30 * Utils.getScalingFactor(context)),
                SizedBox(
                  width: double.infinity,
                  height: 50 * Utils.getScalingFactor(context),

                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthError) {
                        Utils().showSnackBar(
                          context,
                          MsgType.error,
                          state.errorMsg,
                        );
                      }
                      if (state is AuthSuccess) {
                        Navigation.pushandRemoveUntil(
                          context,
                          BottomNavScreen(),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CircularProgressIndicator()],
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (registerKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              SignUpEvent(
                                fullName.text.trim(),
                                email.text.trim(),
                                password.text.trim(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: font18),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20 * Utils.getScalingFactor(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap:
                          () => Navigation.pushandRemoveUntil(
                            context,
                            LoginScreen(),
                          ),
                      child: Text(
                        "Login",
                        style: AppTextTheme.bodyText.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
