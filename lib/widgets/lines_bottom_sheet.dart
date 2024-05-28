import 'package:czy_dojade/helpers/set_value_notifier.dart';
import 'package:czy_dojade/models/transport.dart';
import 'package:flutter/material.dart';

Future<void> showLinesFilterBottomSheet({
  required BuildContext context,
  required List<Transport> transports,
  required SetValueNotifier<Set<String>> routesToSkip,
  required Function(Transport) onTap,
}) async {
  final List<Transport> trans = List.of(transports);
  final Set<String> ids = {};
  trans.retainWhere((trans) => ids.add(trans.routeId));
  trans.sort((a, b) {
    if (a.routeId.length != b.routeId.length) {
      return a.routeId.length.compareTo(b.routeId.length);
    } else {
      return a.routeId.compareTo(b.routeId);
    }
  });

  showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DraggableScrollableSheet(
            initialChildSize: 1,
            minChildSize: 1,
            expand: true,
            builder: (ctx, scrlController) {
              return ValueListenableBuilder(
                  valueListenable: routesToSkip,
                  builder: (_, toSkip, ___) => Column(
                        children: [
                          Expanded(
                            child: ListView(
                              controller: scrlController,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 100.0),
                                  child: Divider(
                                    thickness: 3,
                                  ),
                                ),
                                const Text(
                                  'Buses:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                  ),
                                ),
                                Wrap(
                                  children: trans
                                      .where((trans) => trans.type == 3)
                                      .map(
                                        (trans) => Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: FilterChip(
                                            selected:
                                                !toSkip.contains(trans.routeId),
                                            label: Text(trans.routeId),
                                            onSelected: (_) {
                                              onTap(trans);
                                            },
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const Text(
                                  'Trams:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                  ),
                                ),
                                Wrap(
                                  children: trans
                                      .where((trans) => trans.type == 0)
                                      .toSet()
                                      .map(
                                        (trans) => Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: FilterChip(
                                            selected:
                                                !toSkip.contains(trans.routeId),
                                            label: Text(trans.routeId),
                                            onSelected: (_) {
                                              onTap(trans);
                                            },
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  routesToSkip.value = {};
                                },
                                child: Text('Select all'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  routesToSkip.value = trans
                                      .map((trans) => trans.routeId)
                                      .toSet();
                                },
                                child: Text('Unselect all'),
                              ),
                            ],
                          ),
                        ],
                      ));
            },
          ),
        );
      });
}
