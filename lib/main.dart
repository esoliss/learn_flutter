import 'package:flutter/material.dart';
import 'package:tutorial/home_page.dart';
import 'package:tutorial/profile_page.dart';
import 'package:tutorial/table_multi_example.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(primarySwatch: Colors.blueGrey),
      //theme: ThemeData(
      //colorSchemeSeed: Colors.blue,
      //brightness: isDark ? Brightness.dark : Brightness.light,
      //scaffoldBackgroundColor: isDark ? Colors.black : Colors.white,
      //),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 1; // pagina de inicio
  List<Widget> pages = [ProfilePage(), TableEventsExample(), const HomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jornada 14-14  Mantenimiento CCS'),
      ),
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.beach_access), label: 'Feriados'),
          NavigationDestination(
              icon: Icon(Icons.calendar_month), label: 'Turnos'),
          NavigationDestination(icon: Icon(Icons.av_timer), label: 'Fecha')
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
