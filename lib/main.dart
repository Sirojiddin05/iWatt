import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_theme/dark.dart';
import 'package:i_watt_app/core/config/app_theme/light.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/features/common/presentation/blocs/theme_switcher_bloc/theme_switcher_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  runApp(const IWatt());
}

class IWatt extends StatelessWidget {
  const IWatt({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeSwitcherBloc(),
      child: BlocBuilder<ThemeSwitcherBloc, ThemeSwitcherState>(
        builder: (context, state) {
          print('build ${state.appTheme}');

          return MaterialApp(
            title: 'I WATT',
            theme: state.appTheme.isLight ? LightTheme.theme() : DarkTheme.theme(),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              final bloc = context.read<ThemeSwitcherBloc>();
              bloc.add(const SwitchThemeModeEvent(ThemeMode.system));
              // if (bloc.state.appTheme.isLight) {
              //   bloc.add(const SwitchThemeModeEvent(ThemeMode.dark));
              // } else {
              //   bloc.add(const SwitchThemeModeEvent(ThemeMode.light));
              // }
            },
            tooltip: '',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              final bloc = context.read<ThemeSwitcherBloc>();
              bloc.add(const SwitchThemeModeEvent(ThemeMode.light));
              // if (bloc.state.appTheme.isLight) {
              //   bloc.add(const SwitchThemeModeEvent(ThemeMode.dark));
              // } else {
              //   bloc.add(const SwitchThemeModeEvent(ThemeMode.light));
              // }
            },
            tooltip: '',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              final bloc = context.read<ThemeSwitcherBloc>();
              bloc.add(const SwitchThemeModeEvent(ThemeMode.dark));
              // if (bloc.state.appTheme.isLight) {
              //   bloc.add(const SwitchThemeModeEvent(ThemeMode.dark));
              // } else {
              //   bloc.add(const SwitchThemeModeEvent(ThemeMode.light));
              // }
            },
            tooltip: '',
            child: const Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
