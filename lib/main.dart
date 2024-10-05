import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:educatly/infrastructure/local_storage.dart';
import 'package:educatly/view_models/auth_cubit/cubit.dart';
import 'package:educatly/view_models/chat_cubit/cubit.dart';
import 'package:educatly/view_models/settings_cubit/cubit.dart';
import 'package:educatly/view_models/settings_cubit/states.dart';
import 'package:educatly/widgets/loading_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  await SecureStorage.init();
  await CacheHelper.init();
  runApp(const Educatly());
}

class Educatly extends StatelessWidget {
  const Educatly({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => SettingCubit()..getUser()),
        BlocProvider(create: (_) => ChatCubit()),
      ],
      child: BlocConsumer<SettingCubit, SettingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SettingCubit cubit = SettingCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Educatly',
            theme: cubit.getIsDarkMode(),
            home: ConditionalBuilder(
              condition: state is! GetUserDataLoadingState,
              builder: (context) => cubit.currentView(),
              fallback: (context) => const LoadingView(),
            ),
          );
        },
      ),
    );
  }
}
