import 'package:flutter/material.dart';

import '../widgets/task_card.dart';

class MyTaskMainView extends StatelessWidget {
  const MyTaskMainView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.builder(itemCount: 5,itemBuilder: (context,index){
        return TaskCard();
      }),
    );
  }
}
