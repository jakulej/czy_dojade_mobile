import 'package:flutter/material.dart';

Future<void> showLinesFilterBottomSheet({required BuildContext context}) async {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.0),
                child: Divider(
                  thickness: 3,
                ),
              ),
              SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Buses:',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Wrap(
                    children: List.generate(
                        25,
                        (index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FilterChip(
                                  label: Text('${100 + index}'),
                                  onSelected: (_) {}),
                            )),
                  ),
                  const Text(
                    'Trams:',
                    style: TextStyle(color: Colors.black),
                  ),
                  Wrap(
                    children: List.generate(
                        17,
                        (index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FilterChip(
                                  label: Text('$index'), onSelected: (_) {}),
                            )),
                  ),
                ],
              )),
            ],
          ),
        );
      });
}
