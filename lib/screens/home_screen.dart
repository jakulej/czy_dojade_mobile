import 'dart:async';
import 'dart:convert';

import 'package:czy_dojade/widgets/lines_bottom_sheet.dart';
import 'package:flutter/material.dart' hide FilterChip;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/transport.dart';
import '../widgets/filter_chip.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});

  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<Transport> transports = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _breslau = CameraPosition(
      bearing: 0, target: LatLng(51.1094948, 17.0244067), tilt: 0, zoom: 14.04);

  final Map<String, IconData> _icons = {
    'Route': Icons.route,
    'Bus': Icons.directions_bus,
    'Tram': Icons.tram,
    'Bus stop': Icons.signpost_sharp,
    'Collision': Icons.car_crash
  };
  final Map<String, bool> _selections = {
    'Route': true,
    'Bus': true,
    'Tram': true,
    'Bus stop': true,
    'Collision': true
  };

  @override
  void initState() {
    loadTransports();
    super.initState();
  }

  loadTransports() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/mocks/wroclaw-live2.json");
    Map<String, dynamic> json = jsonDecode(data)['data'];
    transports = json.values.map((e) => Transport.fromJson(e)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: _breslau,
            buildingsEnabled: false,
            zoomControlsEnabled: false,
            markers: transports.map((e) => e.mapMarker).toSet(),
          ),
          SafeArea(child: _searchAndFilterBar()),
          Align(
            alignment: Alignment.centerLeft,
            child: Material(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              child: InkWell(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: const SizedBox(
                  height: 80,
                  width: 30,
                  child: Icon(Icons.chevron_right),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showLinesFilterBottomSheet(context: context);
        },
        child: const Icon(Icons.filter_alt),
      ),
      drawer: _drawer(),
    );
  }

  _searchAndFilterBar() {
    return Row(
      children: [
        IconButton.filled(
          icon: const Icon(Icons.search),
          color: Colors.white,
          onPressed: () {},
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: _icons.keys
                  .map((e) => FilterChip(
                        label: e,
                        icon: _icons[e]!,
                        isSelected: _selections[e]!,
                        onTap: () {
                          setState(() {
                            _selections.update(e, (value) => !value);
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }

  _drawer() {
    return Container(
      color: Colors.white,
      width: 250,
      child: SafeArea(
        child: Column(
          children: [
            const ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 56,
              ),
              title: Text(
                'John Doe',
                style: TextStyle(fontSize: 24),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
            ),
            const Divider(
              thickness: 3,
            ),
            ListTile(
              leading: const Icon(
                Icons.manage_accounts_rounded,
                size: 52,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {},
              iconColor: Colors.black,
              textColor: Colors.black,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.settings,
                size: 52,
              ),
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {},
              iconColor: Colors.black,
              textColor: Colors.black,
            ),
            const Divider(),
            const Expanded(child: SizedBox()),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.power_settings_new,
                size: 52,
              ),
              title: const Text(
                'Sign out',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {},
              iconColor: Colors.red,
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
