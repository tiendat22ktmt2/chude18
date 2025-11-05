import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_bloc.dart';
import '../bloc/counter_event.dart';
import '../bloc/counter_state.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final _minController = TextEditingController(text: '-5');
  final _maxController = TextEditingController(text: '10');

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BLoC Pattern - Separation of Concerns',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white, // khung trắng
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/anhtes.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: BlocListener<CounterBloc, CounterState>(
            listenWhen: (prev, curr) =>
                prev.isMax != curr.isMax || prev.isMin != curr.isMin,
            listener: (context, state) {
              if (state.isMax) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.black87,
                    content: const Text(
                      'Reached MAX value!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              } else if (state.isMin) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.black87,
                    content: const Text(
                      'Reached MIN value!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
            child: BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Current value:',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
                      Text(
                        '${state.value}',
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ======== Nhập Min / Max + Set ========
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: _minController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                labelText: 'Min',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: _maxController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                labelText: 'Max',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              final min =
                                  int.tryParse(_minController.text) ?? -5;
                              final max =
                                  int.tryParse(_maxController.text) ?? 10;
                              context
                                  .read<CounterBloc>()
                                  .add(SetLimitPressed(min, max));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Set'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ======== Nút điều khiển ========
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 40,
                            color: Colors.white,
                            onPressed: () => context
                                .read<CounterBloc>()
                                .add(DecrementPressed()),
                            icon: const Icon(Icons.remove_circle),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            iconSize: 40,
                            color: Colors.white,
                            onPressed: () => context
                                .read<CounterBloc>()
                                .add(IncrementPressed()),
                            icon: const Icon(Icons.add_circle),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            iconSize: 40,
                            color: Colors.white,
                            onPressed: () => context
                                .read<CounterBloc>()
                                .add(ResetPressed()),
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
