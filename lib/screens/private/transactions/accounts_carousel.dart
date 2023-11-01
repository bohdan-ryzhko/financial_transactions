import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_transactions/screens/private/transactions/transactions_history.dart';
import 'package:financial_transactions/state/account_bloc.dart';
import 'package:flutter/material.dart';

class AccountsCarousel extends StatefulWidget {
  final List<Account> accounts;
  final void Function(Account) onDeleteAccount;

  const AccountsCarousel({
    Key? key,
    required this.accounts,
    required this.onDeleteAccount,
  }) : super(key: key);

  @override
  State<AccountsCarousel> createState() => _AccountsCarouselState();
}

class _AccountsCarouselState extends State<AccountsCarousel> {
  int _currentIndex = 0;

  final CarouselController _controller = CarouselController();

  Future<void> dialogBuilder(BuildContext context, Account? account) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you shure to remove ${account!.account_name}"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                widget.onDeleteAccount(account);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accounts = widget.accounts;

    return Column(
      children: <Widget>[
        CarouselSlider(
          carouselController: _controller,
          items: accounts.map((account) {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue,
              ),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Text(
                      account.account_name ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TransactionsHistory(account: account);
                        }));
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: TextButton(
                      onPressed: () => dialogBuilder(context, account),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          options: CarouselOptions(
            enableInfiniteScroll: true,
            height: 200.0,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.accounts.asMap().entries.map((entry) {
            final int index = entry.key;
            return Container(
              width: 10.0,
              height: 10.0,
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 2.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blue : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
