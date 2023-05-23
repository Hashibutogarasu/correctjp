// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<StatefulWidget> createState() => _Info();
}

class _Info extends State<Info> {
  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("このアプリについて"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("ライセンス"),
            subtitle: const Text("Licences"),
            onTap: () {
              showLicensePage(context: context);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder<PackageInfo>(
              future: _getPackageInfo(),
              builder:
                  (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
                if (snapshot.hasError) {
                  return const Text('ERROR');
                } else if (!snapshot.hasData) {
                  return const Text('Loading...');
                }

                final data = snapshot.data!;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('App Name: ${data.appName}'),
                    Text('Package Name: ${data.packageName}'),
                    Text('Version: ${data.version}'),
                    Text('Build Number: ${data.buildNumber}'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
