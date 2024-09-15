import 'package:eghyptproject/Featuer/home/presentation/manger/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget/home_view_body.dart';
import 'widget/leading_icons_home_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Future.delayed(const Duration(seconds: 2));
        setState(() {
          loadTokenAndInitRefrsh(HomeCubit());
        });
      },
      child: Scaffold(
        backgroundColor: const Color(0xffE8E2E2),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: (const Color(0xffE32020)),
          title: const AppBarHomeView(),
        ),
        body: const PopScope(canPop: false, child: HomeViewBody()),
      ),
    );
  }

  void loadTokenAndInitRefrsh(HomeCubit cubit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token != null) {
      cubit.loadSuppliers(token);
    } else {
      return;
    }
  }
}
