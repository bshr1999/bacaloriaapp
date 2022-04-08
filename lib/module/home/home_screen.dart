import 'package:arena/module/home/home_cubit.dart';
import 'package:arena/module/home/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: HomeCubit.get(context).index,
            items: HomeCubit.get(context).item,
            onTap:(int index){
              HomeCubit.get(context).barIndex(index);
            } ,
          ),
          body: HomeCubit.get(context).screens[HomeCubit.get(context).index],
        );
      },
    );
  }
}
