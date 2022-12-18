import 'package:flutter/material.dart';
import 'package:tutorial/table_multi_example.dart';

const int itemCount = 20;

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  List<String> feriados = [
    'Año nuevo',
    'Carnaval día 1',
    'Carnaval día 2',
    'Viernes Santo',
    'Día del Trabajo',
    'Batalla de Pichincha',
    'Primer Grito de Independencia',
    'Independencia de Guayaquil',
    'Independencia de Cuenca',
    'Navidad',
  ];
  List<DateTime> fechas = [
    DateTime(2023, 01, 02),
    DateTime(2023, 02, 20),
    DateTime(2023, 02, 21),
    DateTime(2023, 04, 07),
    DateTime(2023, 05, 01),
    DateTime(2023, 05, 26),
    DateTime(2023, 08, 11),
    DateTime(2023, 09, 09),
    DateTime(2023, 11, 02),
    DateTime(2023, 11, 03),
    DateTime(2023, 12, 25)
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: feriados.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: Text(feriados[index]),
            leading: const Icon(Icons.calendar_today),
            //trailing: const Icon(Icons.select_all),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return TableEventsExample();
                  },
                ),
              );
              //debugPrint('Item ${(index + 1)}');
            });
      },
    );
  }
}
