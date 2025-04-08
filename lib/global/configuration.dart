library configuration;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/features/auth/data/local/auth_local_data_source.dart';
import 'package:taskmanager/features/auth/data/remote/auth_remote_data_source.dart';
import 'package:taskmanager/features/auth/data/repository/auth_repository_impl.dart';
import 'package:taskmanager/features/auth/domain/repository/auth_repository.dart';
import 'package:taskmanager/features/auth/domain/usecase/auth_usecase.dart';
import 'package:taskmanager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanager/features/auth/presentation/check_user_cubit/check_user_cubit.dart';
import 'package:taskmanager/features/bottom_nav/cubit/bottom_nav_cubit.dart';
import 'package:taskmanager/features/task/data/remote/task_remote_data_source.dart';
import 'package:taskmanager/features/task/data/repository/task_repository_impl.dart';
import 'package:taskmanager/features/task/domain/repository/task_repository.dart';
import 'package:taskmanager/features/task/domain/usecase/task_usecase.dart';
import 'package:taskmanager/features/task/presentation/cubit/task_cubit.dart';

part 'dependency_injection.dart';
part 'app_start_widget.dart';
