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
  void initState() {
    super.initState();

    // Khi mở app, đọc giá trị min/max đã lưu và hiển thị lại
    final repo = context.read<CounterBloc>().repository;
    _minController.text = repo.min.toString();
    _maxController.text = repo.max.toString();
  }

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
          'BLOC PATTERN',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
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
                  const SnackBar(
                    backgroundColor: Colors.black87,
                    content: Text('Reached MAX value!',
                        style: TextStyle(color: Colors.white)),
                  ),
                );
              } else if (state.isMin) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.black87,
                    content: Text('Reached MIN value!',
                        style: TextStyle(color: Colors.white)),
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
                      const Text(
                        'Current value',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${state.value}',
                        style: const TextStyle(
                          fontSize: 110,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 110,
                            height: 70,
                            child: TextField(
                              controller: _minController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                label: Transform.translate(
                                  offset: const Offset(0, 12),
                                  child: const Text(
                                    'Min',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 110,
                            height: 70,
                            child: TextField(
                              controller: _maxController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                label: Transform.translate(
                                  offset: const Offset(0, 12),
                                  child: const Text(
                                    'Max',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 110,
                            height: 70,
                            child: ElevatedButton(
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
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                                minimumSize: const Size(110, 70),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: Colors.black),
                                ),
                              ),
                              child: const Text('Set'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 50,
                            color: Colors.white,
                            onPressed: () => context
                                .read<CounterBloc>()
                                .add(DecrementPressed()),
                            icon: const Icon(Icons.remove_circle),
                          ),
                          const SizedBox(width: 30),
                          IconButton(
                            iconSize: 50,
                            color: Colors.white,
                            onPressed: () => context
                                .read<CounterBloc>()
                                .add(IncrementPressed()),
                            icon: const Icon(Icons.add_circle),
                          ),
                          const SizedBox(width: 30),
                          IconButton(
                            iconSize: 50,
                            color: Colors.white,
                            onPressed: () =>
                                context.read<CounterBloc>().add(ResetPressed()),
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
