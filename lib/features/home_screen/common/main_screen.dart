/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 23-08-2026 - 12:30
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:expensetrackerapp/core/network/dio_client.dart';
import 'package:expensetrackerapp/core/storage/secure_storage_service.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_bloc/add_expense_bloc.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_data/add_expense_api_provider.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_data/add_expense_repo.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_presentation/add_expense_screen.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_bloc/home_screen_bloc.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_bloc/home_screen_event.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_data/home_screen_api_provider.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_data/home_screen_repo.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_model/expense_model.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_presentation/home_screen.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_presentation/transaction_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  Expense? _selectedExpense;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    final homeScreenRepo = HomeScreenRepo(
      HomeScreenApiProvider(
        DioClient(
          SecureStorageService(),
        ).dio,
      ),
    );

    _screens = [
      BlocProvider(
        create: (_) => HomeBloc(
          repository: homeScreenRepo,
        )..add(HomeStarted()),
        child: HomeScreen(
          onTransactionTap: _openTransactionDetails,
        ),
      ),
      const Placeholder(),
      const Placeholder(),
      const Placeholder(),
      BlocProvider(
        create: (_) => AddExpenseBloc(
          AddExpenseRepo(
            AddExpenseApiProvider(
              DioClient(
                SecureStorageService(),
              ).dio,
            ),
          ),
        ),
        child: AddExpenseScreen(
          onSubmitSuccess: () => _onTabTapped(0),
        ),
      ),
    ];
  }

  void _openTransactionDetails(Expense expense) {
    setState(() {
      _selectedExpense = expense;
    });
  }

  void _closeTransactionDetails() {
    setState(() {
      _selectedExpense = null;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedExpense = null;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTransactionDetails = _selectedExpense != null;

    return PopScope(
      canPop: !isTransactionDetails && _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (isTransactionDetails) {
            _closeTransactionDetails();
          } else {
            _onTabTapped(0);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        body: isTransactionDetails
            ? TransactionDetailsScreen(
          expense: _selectedExpense!,
          onBack: _closeTransactionDetails,
        )
            : IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),

        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,

        floatingActionButton:
        isTransactionDetails || _currentIndex == 4
            ? null
            : FloatingActionButton(
          onPressed: () => _onTabTapped(4),
          backgroundColor: const Color(0xFF0F6E56),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
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
                const SizedBox(
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
        color: isSelected
            ? const Color(0xFF0F6E56)
            : Colors.grey,
      ),
      onPressed: onTap,
    );
  }
}