import 'package:chordy/pages/settings.dart';
import 'package:flutter/material.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Account',
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: () => showDialog(context: context, 
            builder: (_) => Dialog(
              alignment: Alignment(0.0, -0.8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Chordy', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            onPressed: () => Navigator.pop(context), 
                            icon: const Icon(Icons.close_outlined, size: 20,)
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: ListTile(
                        minTileHeight: 60,
                        leading: const Icon(Icons.login_outlined),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        title: const Text("Login"),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.settings_outlined),
                            title: const Text("Settings"),
                            onTap: () {}
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings_outlined),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.only(
                                bottomLeft: Radius.circular(10), 
                                bottomRight: Radius.circular(10))
                              ),
                            title: const Text("Settings"),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
                            }
                          ),
                        ],
                      )
                    ),
                    const SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8,),
      ],
    );
  }
}