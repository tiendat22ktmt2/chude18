// lib/ui/counter_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_bloc.dart';
import '../bloc/counter_event.dart';
import '../bloc/counter_state.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLoC Pattern - Separation of Concerns')),
      body: Center(
        child: BlocListener<CounterBloc, CounterState>(
          listenWhen: (prev, curr) => prev.isMax != curr.isMax || prev.isMin != curr.isMin,
          listener: (context, state) {
            if (state.isMax) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reached MAX value (10)!')),
              );
            } else if (state.isMin) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reached MIN value (-5)!')),
              );
            }
          },
          child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Current value:', style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    '${state.value}',
                    style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 40,
                        onPressed: () => context.read<CounterBloc>().add(DecrementPressed()),
                        icon: const Icon(Icons.remove_circle),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        iconSize: 40,
                        onPressed: () => context.read<CounterBloc>().add(IncrementPressed()),
                        icon: const Icon(Icons.add_circle),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        iconSize: 40,
                        onPressed: () => context.read<CounterBloc>().add(ResetPressed()),
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
