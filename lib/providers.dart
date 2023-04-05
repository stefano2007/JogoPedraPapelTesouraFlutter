
import 'package:contador/controllers/JogoController.dart';
import 'package:contador/services/JogoService.dart';
import 'package:provider/provider.dart';

final providers = [
  Provider<JogoService>(
    create: (context) => JogoService(),
  ),
   Provider<JogoController>(
     create: (context) => JogoController(service: context.read<JogoService>()),
   ),
];