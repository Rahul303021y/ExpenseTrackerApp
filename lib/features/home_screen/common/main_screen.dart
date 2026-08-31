/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 23-08-2026 - 12:30
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:expensetrackerapp/core/network/dio_client.dart';
import 'package:expensetrackerapp/core/storage/secure_storage_service.dart';
import 'package:expensetrackerapp/core/theme/app_theme.dart';
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

import '../home_screen_bloc/home_screen_state.dart';
import '../home_screen_presentation/all_transaction_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;
  late final HomeBloc _homeBloc;

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

    _homeBloc = HomeBloc(
      repository: homeScreenRepo,
    )..add(HomeStarted());

    _screens = [
      BlocProvider.value(
        value: _homeBloc,
        child: HomeScreen(
          onTransactionTap: _openTransactionDetails,
          onViewAllTransactions: _openAllTransactions,
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
          onSubmitSuccess: () {
            _homeBloc.add(HomeStarted());
            _onTabTapped(0);
          },
        ),
      ),
    ];
  }

  void _openAllTransactions() {
    final state = _homeBloc.state;

    if (state is HomeScreenLoaded) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AllTransactionsScreen(
            transactions: state.expenses,
            onTransactionTap: _openTransactionDetails,
          ),
        ),
      );
    }
  }

  void _openTransactionDetails(Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransactionDetailsScreen(
          expense: expense,
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.surfaceContainer,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,

      floatingActionButton: _currentIndex == 4
          ? null
          : FloatingActionButton(
        onPressed: () => _onTabTapped(4),
        backgroundColor: Theme.of(context).appColors.primary,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: Theme.of(context).appColors.onPrimary,
          size: 40,
        ),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).appColors.onPrimary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).appColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Theme.of(context).appColors.background,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              _currentIndex == 4 ? SizedBox(
                width: 0,
              ) : SizedBox(
                width: 15,
              ) ,
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
            ? Theme.of(context).appColors.primary
            : Theme.of(context).appColors.onSurfaceVariant,
      ),
      onPressed: onTap,
    );
  }
}