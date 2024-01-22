import 'package:flutter/material.dart';
import 'package:stray_dog_app/Application/tools/AppText.dart';
import 'package:stray_dog_app/Application/tools/asset.dart';

class HelpWaysScreen extends StatelessWidget {
  const HelpWaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'How to Help:',
          style: appBartitleStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
              'How To Help A Stray Dog In Our Society : 6 Simple Ways.',
              style: HeadStyle,
            ),
            gyap(10, 0),
            waysCard("1. Find your 'Community dog'", 'assets/images/dog4.jpg',
                caption1),
            waysCard("2. Arrange Shelter", 'assets/images/dog1.jpg', caption2),
            waysCard("3. Get vaccinations&medical care",
                'assets/images/vaccinedog.jpg', caption3),
            waysCard("4. Dealing with unfriendly neighbors",
                'assets/images/dog2.jpg', caption4),
            waysCard("5. Dealing with lost or abandoned dogs",
                'assets/images/sadDog.jpg', caption5),
            waysCard("6.Provide food and water", 'assets/images/dogfeed.webp',
                caption6),
            Card(
              color: Colors.blueGrey,
              margin: const EdgeInsets.only(right: 10),
              child: TextButton.icon(
                label: Text(
                  'Inform Us',
                  style: titleStyle,
                ),
                icon: const Icon(
                  Icons.next_plan,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('saveScreen');
                },
              ),
            ),
            gyap(10, 0)
          ],
        ),
      ),
    );
  }
}
