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

//               // CHANGE: grams → kg
//               final double weightKg = snapshot.data! / 1000.0;

//               return Text(
//                 '${weightKg.toStringAsFixed(3)} kg',
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
//=================================================================


// import 'package:flutter/material.dart';
// import 'package:imin_weight_plugin/imin_weight_plugin.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: WeightScreen(),
//     );
//   }
// }

// class WeightScreen extends StatefulWidget {
//   const WeightScreen({super.key});

//   @override
//   State<WeightScreen> createState() => _WeightScreenState();
// }

// class _WeightScreenState extends State<WeightScreen> {
//   double _lastWeightKg = 0.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: StreamBuilder<int>(
//           stream: IminWeightPlugin.weightStream,
//           builder: (context, snapshot) {
//             //  HANDLE STREAM ERROR SAFELY
//             if (snapshot.hasError) {
//               return Text(
//                 '${_lastWeightKg.toStringAsFixed(3)} kg',
//                 style: const TextStyle(
//                   color: Colors.red,
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                 ),
//               );
//             }

//             //  WAITING STATE
//             if (!snapshot.hasData) {
//               return const Text(
//                 'Waiting for weight...',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               );
//             }

//             //  VALID DATA
//             _lastWeightKg = snapshot.data! / 1000.0;

//             return Text(
//               '${_lastWeightKg.toStringAsFixed(3)} kg',
//               style: const TextStyle(
//                 color: Colors.green,
//                 fontSize: 48,
//                 fontWeight: FontWeight.bold,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//=================================

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imin_weight_plugin/imin_weight_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeightScreen(),
    );
  }
}

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  StreamSubscription<int>? _subscription;
  double? _weightKg;

  @override
  void initState() {
    super.initState();

    //  START READING WHEN APP STARTS
    _subscription = IminWeightPlugin.weightStream.listen(
      (weight) {
        setState(() {
          _weightKg = weight / 1000.0;
        });
      },
      onError: (_) {},
    );
  }

  @override
  void dispose() {
    //  STOP READING WHEN APP CLOSES
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _weightKg == null
            ? const Text(
                'Waiting for weight...',
                style: TextStyle(color: Colors.white, fontSize: 24),
              )
            : Text(
                '${_weightKg!.toStringAsFixed(3)} kg',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
