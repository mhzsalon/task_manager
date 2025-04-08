part of 'configuration.dart';

GetIt sl = GetIt.instance;
Future<void> initialize() async {
  // frebase handler
  // final firebaseStorage = FirebaseStorage.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFireStore = FirebaseFirestore.instance;

  // sl.registerLazySingleton(() => firebaseStorage);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseFireStore);

  //
  sl.registerFactory(() => AuthBloc(sl()));
  sl.registerFactory(() => BottomNavCubit());
  sl.registerFactory(() => CheckUserCubit(sl()));

  sl.registerFactory(() => TaskCubit(sl()));

  final preference = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(preference);

  // /// Local data source
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(preference),
  );

  // // usecases
  sl.registerLazySingleton(() => AuthUsecase(sl()));
  sl.registerLazySingleton(() => TaskUsecase(sl()));

  // //repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  // remote data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(),
  );
}
