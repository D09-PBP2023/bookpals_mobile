import 'package:bookpals_mobile/features/main/screens/widgets/top_home_shape.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: TopHomeShapeClipper(),
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                  Positioned(
                    top: 100,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        "Halo, Anon!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text("Ini list buku nanti..."),
          ],
        ),
      ),
    );
  }
}
