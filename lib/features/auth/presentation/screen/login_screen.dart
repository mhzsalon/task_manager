import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/enums/messageType_enum.dart';
import 'package:taskmanager/core/resources/app_colors.dart';
import 'package:taskmanager/core/resources/text_theme.dart';
import 'package:taskmanager/core/utils/dimens.dart';
import 'package:taskmanager/core/utils/navigation.dart';
import 'package:taskmanager/core/utils/utils.dart';
import 'package:taskmanager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanager/features/auth/presentation/screen/signup_screen.dart';
import 'package:taskmanager/features/bottom_nav/bottom_nav_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: sizeX20 * Utils.getScalingFactor(context),
          right: sizeX20 * Utils.getScalingFactor(context),
        ),
        child: Form(
          key: loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back!",
                style: TextStyle(fontSize: font28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10 * Utils.getScalingFactor(context)),
              Text(
                "Login to continue",
                style: TextStyle(fontSize: sizeX16, color: Colors.grey),
              ),
              SizedBox(height: 30 * Utils.getScalingFactor(context)),
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
                validator: (value) => Utils.validate(value, field: "password"),
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10 * Utils.getScalingFactor(context)),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Forgot Password?",
                    style: AppTextTheme.subTitleText.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20 * Utils.getScalingFactor(context)),
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
                      Navigation.pushandRemoveUntil(context, BottomNavScreen());
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
                        if (loginKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            LoginEvent(email.text.trim(), password.text.trim()),
                          );
                        }
                      },
                      child: Text("Login", style: TextStyle(fontSize: 18)),
                    );
                  },
                ),
              ),
              SizedBox(height: sizeX20 * Utils.getScalingFactor(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    onTap:
                        () => Navigation.pushandRemoveUntil(
                          context,
                          SignupScreen(),
                        ),
                    child: Text(
                      "Register",
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
    );
  }
}
