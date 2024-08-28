import 'package:flutter/material.dart';
import 'package:kpu_app_serkom/view/form_entry_screen.dart';
import 'package:kpu_app_serkom/view/information_screen.dart';

import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              "KPU",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(20, 100, 20, 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: cDarkGreen),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InformationScreen()));
                },
                child: const Text(
                  "Informasi",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: cDarkGreen),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FormEntry()));
                },
                child: const Text(
                  "Form Entri",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: cDarkGreen),
                onPressed: () {},
                child: const Text(
                  "Lihat Data",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: cDarkGreen),
                onPressed: () {},
                child: const Text(
                  "Keluar",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}