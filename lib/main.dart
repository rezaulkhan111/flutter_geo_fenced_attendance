import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/location_repository.dart';
import 'logic/attendance_bloc.dart';
import 'logic/attendance_event.dart';
import 'presentation/screens/attendance_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => LocationRepository(),
      child: BlocProvider(
        create: (context) => AttendanceBloc(
          context.read<LocationRepository>(),
        )..add(LoadOfficeLocation()),
        child: MaterialApp(
          title: 'Geo-Fenced Attendance',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const AttendanceScreen(),
        ),
      ),
    );
  }
}
