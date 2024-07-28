import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:coyote/modules/home/widget/card_debt.dart';
import 'package:coyote/modules/new_loan/loan_provider.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/routes/app_router.gr.dart';
import 'package:coyote/widgets/ss_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getClients();
    });
  }

  Future<void> getClients() async {
    try {
      setState(() {});
      await ref.read(loanProvider.notifier).getAllLoans();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(loanProvider.select((state) => state.loans));
    final loading = ref.watch(loanProvider.select((state) => state.loading));
    return SsScaffold(
      titleAppBar: 'HOME PAGE',
      actions: [
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            size: 30.sp,
          ),
          onPressed: () {
            appRouter.push(NewLoanRoute());
          },
        ),
        PopupMenuButton<String>(
          onSelected: (String result) async {
            switch (result) {
              case '1':
                appRouter.push(const ClientsRoute());
                break;
              case '2':
                appRouter.push(const SalesRoute());
                break;
              case '4':
                break;
              case '5':
                appRouter.push(const CashBoxRoute());
                break;
              case '7':
                appRouter.push(const ShowExpensesRoute());
                break;
              case '8':
                appRouter.push(const RegisterExpensesRoute());
                break;
              case '9':
                // await PaymentsDatabase.instance.updateDateFail();
                await exportDatabaseFolder();
                break;
              case '10':
                // await PaymentsDatabase.instance.updateDateFail();
                await replaceDatabaseFolder();
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: '1',
              child: Text('Ver Clientes'),
            ),
            const PopupMenuItem<String>(
              value: '2',
              child: Text('Ver Ventas'),
            ),
            const PopupMenuItem<String>(
              value: '5',
              child: Text('Ver Caja'),
            ),
            const PopupMenuItem<String>(
              value: '7',
              child: Text('Gastos Registrados'),
            ),
            const PopupMenuItem<String>(
              value: '8',
              child: Text('Agregar Gastos'),
            ),
            const PopupMenuItem<String>(
              value: '9',
              child: Text('Exportar base de datos'),
            ),
            const PopupMenuItem<String>(
              value: '10',
              child: Text('Importar base de datos'),
            ),
          ],
        ),
      ],
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                return CardDebt(loan: list[index]);
              },
              itemCount: list.length,
            ),
    );
  }

  Future<void> exportDatabaseFolder() async {
    try {
      var databasesPath = await getDatabasesPath();

      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String exportPath = path.join(documentsDirectory.path, 'database_backup');

      Directory(exportPath).createSync(recursive: true);

      Directory(databasesPath).listSync().forEach((file) {
        if (file is File) {
          String newPath = path.join(exportPath, path.basename(file.path));
          file.copySync(newPath);
        }
      });

      await Share.shareXFiles(
        Directory(exportPath)
            .listSync()
            .whereType<File>()
            .map((file) => XFile(file.path))
            .toList(),
        text: 'Aquí está la carpeta de bases de datos SQLite.',
      );
    } catch (e) {
      print('Error al exportar la carpeta de bases de datos: $e');
    }
  }

  Future<void> replaceDatabaseFolder() async {
    try {
      var databasesPath = await getDatabasesPath();

      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String backupPath = path.join(documentsDirectory.path, 'database_backup');

      if (Directory(backupPath).existsSync()) {
        await closeDatabases();

        var backupFiles = Directory(backupPath).listSync().whereType<File>();

        Directory(databasesPath).listSync().forEach((file) {
          if (file is File) {
            file.deleteSync();
          }
        });

        backupFiles.forEach((file) {
          String newPath = path.join(databasesPath, path.basename(file.path));
          file.copySync(newPath);
        });

        await openDatabases();

        print('Bases de datos reemplazadas exitosamente.');
      } else {
        print('La carpeta de respaldo no existe.');
      }
    } catch (e) {
      print('Error al reemplazar las bases de datos: $e');
    }
  }

  Future<void> closeDatabases() async {
    // await database.close();
  }

  Future<void> openDatabases() async {
    // database = await openDatabase('path_to_database');
  }
}
