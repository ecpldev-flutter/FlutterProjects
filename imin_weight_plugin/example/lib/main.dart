// import 'package:flutter/material.dart';
// import 'package:imin_weight_plugin/imin_weight_plugin.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: StreamBuilder<int>(
//             stream: IminWeightPlugin.weightStream,
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return const Text(
//                   'Waiting for weight...',
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 );
//               }

//               return Text(
//                 '${snapshot.data} g',
//                 style: const TextStyle(
//                   color: Colors.green,
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:imin_weight_plugin/imin_weight_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: StreamBuilder<int>(
            stream: IminWeightPlugin.weightStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text(
                  'Waiting for weight...',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                );
              }

              // CHANGE: grams → kg
              final double weightKg = snapshot.data! / 1000.0;

              return Text(
                '${weightKg.toStringAsFixed(3)} kg',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
