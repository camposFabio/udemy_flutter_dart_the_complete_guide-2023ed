import "package:flutter/material.dart";
import 'package:first_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 123, 2, 236),
          Color.fromARGB(255, 34, 4, 90),
        ),
      ),
    ),
  );
}


// void main() {
//   runApp(
//     const MaterialApp(
//       home: Scaffold(
//         body: GradientContainer(colors: [
//           Color.fromARGB(255, 26, 2, 80),
//           Color.fromARGB(255, 45, 7, 98),
//         ]),
//       ),
//     ),
//   );
// }
