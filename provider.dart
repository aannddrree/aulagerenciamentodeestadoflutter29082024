import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Modelo de Contador com ChangeNotifier
class CounterModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }
}

// Aplicativo Principal
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  void initState() {
    super.initState();

    // Adiciona o listener ao modelo CounterModel
    final counterModel = Provider.of<CounterModel>(context, listen: false);
    counterModel.addListener(_counterChangedListener);
  }

  // Listener que será chamado quando notifyListeners() for disparado
  void _counterChangedListener() {
    print("O valor do contador mudou para: ${Provider.of<CounterModel>(context, listen: false).counter}");
  }

  @override
  void dispose() {
    // Remove o listener ao desmontar o widget
    final counterModel = Provider.of<CounterModel>(context, listen: false);
    counterModel.removeListener(_counterChangedListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador com Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Você pressionou o botão este número de vezes:',
            ),
            Consumer<CounterModel>(
              builder: (context, counter, child) {
                return Text(
                  '${counter.counter}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterModel>().increment(),
            tooltip: 'Incrementar',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => context.read<CounterModel>().decrement(),
            tooltip: 'Decrementar',
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
