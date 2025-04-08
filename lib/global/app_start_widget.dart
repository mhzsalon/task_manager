part of 'configuration.dart';

class StartAppWidget extends StatelessWidget {
  final Widget child;
  const StartAppWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavCubit>(create: (_) => sl<BottomNavCubit>()),
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<TaskCubit>(create: (_) => sl<TaskCubit>()),
        BlocProvider<CheckUserCubit>(create: (_) => sl<CheckUserCubit>()),
      ],
      child: child,
    );
  }
}
