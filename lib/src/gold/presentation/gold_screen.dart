import 'package:flutter/material.dart';
import 'package:gold_stream_app/src/gold/presentation/widgets/gold_header.dart';
import 'package:intl/intl.dart';
import 'package:gold_stream_app/src/gold/data/fake_gold_api.dart';

class GoldScreen extends StatelessWidget {
  const GoldScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoldHeader(),
              SizedBox(height: 20),
              Text(
                'Live Kurs:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
                StreamBuilder<double>(
                  stream: getGoldPriceStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Lädt...', style: Theme.of(context).textTheme.headlineLarge);
                    }
                    if (snapshot.hasError) {
                      return Text('Fehler beim Laden', style: Theme.of(context).textTheme.headlineLarge);
                    }
                    final price = snapshot.data ?? 0.0;
                    return Text(
                      NumberFormat.simpleCurrency(locale: 'de_DE').format(price),
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
