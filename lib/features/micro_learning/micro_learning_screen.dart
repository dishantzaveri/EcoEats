import 'package:flutter/material.dart';

class MicroLearningScreen extends StatelessWidget {
const MicroLearningScreen({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Micro Learning'),
      ),
      body: const Center(
        child: Text('Micro Learning'),
      ),
    );
  }
}