import 'package:expense_tracker/data/app_images.dart';
import 'package:flutter/material.dart';

class NoExpenseFound extends StatelessWidget {
  const NoExpenseFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200, child: Image.asset(AppImages.noData)),
            const SizedBox(height: 20),
            Text(
              'No expenses found',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
  }
}