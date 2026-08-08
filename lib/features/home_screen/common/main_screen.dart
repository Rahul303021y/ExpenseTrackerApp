import 'package:expensetrackerapp/core/storage/secure_storage_service.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_presentation/add_expense_screen.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/dio_client.dart';
import '../../add_expense/add_expense_bloc/add_expense_bloc.dart';
import '../../add_expense/add_expense_data/add_expense_api_provider.dart';
import '../../add_expense/add_expense_data/add_expense_repo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;


  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const Placeholder(),
      const Placeholder(),
      const Placeholder(),
      BlocProvider(
        create: (_) => AddExpenseBloc(
          AddExpenseRepo(
            AddExpenseApiProvider(
              DioClient(SecureStorageService()).dio,
            ),
          ),
        ),
        child: AddExpenseScreen(
          onSubmitSuccess: () => _onTabTapped(0),
        ),
      ),
    ];
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _onTabTapped(0);
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _currentIndex == 4
            ? null
            : FloatingActionButton(
                onPressed: () => _onTabTapped(4),
                backgroundColor: const Color(0xFF0F6E56),
                shape: const CircleBorder(),
                child: const Icon(Icons.add, color: Colors.white, size: 40),
              ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: BottomAppBar(
            color: Colors.white,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_filled,
                  isSelected: _currentIndex == 0,
                  onTap: () => _onTabTapped(0),
                ),
                _NavItem(
                  icon: Icons.call_split,
                  isSelected: _currentIndex == 1,
                  onTap: () => _onTabTapped(1),
                ),
                SizedBox(
                  width: 15,
                ),
                _NavItem(
                  icon: Icons.account_balance_wallet_outlined,
                  isSelected: _currentIndex == 2,
                  onTap: () => _onTabTapped(2),
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  isSelected: _currentIndex == 3,
                  onTap: () => _onTabTapped(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? const Color(0xFF0F6E56) : Colors.grey,
      ),
      onPressed: onTap,
    );
  }
}
