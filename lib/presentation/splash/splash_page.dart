import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/presentation/splash/splash_cubit.dart';
import 'package:hrm/presentation/splash/splash_state.dart';

import '../../configuration/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = SplashCubit();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    return Material(
      child: Container(
        color: AppColors.white,
        child: Center(
          child: BlocProvider(
            create: (_) => _cubit,
            child: BlocBuilder<SplashCubit, SplashState>(
              builder: (context, state) => Image.asset(
                'assets/images/Splash.png',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
