import 'package:flutter/material.dart';
import 'package:stray_dog_app/Application/tools/AppText.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(children: [
          gyap(30, 0),
          Text(
            'Get in Touch',
            style: HeadStyle,
          ),
          Text('_____*_____'),
          gyap(30, 0),
          GetinTouchCard(
            icon: Icons.phone_android,
            caption: ' 0483 – 2734917',
            headname: 'Phone',
          ),
          gyap(20, 0),
          GetinTouchCard(
            headname: 'Email',
            icon: Icons.email,
            caption: 'itcellmlp.rev@kerala.gov.in',
          ),
          gyap(20, 0),
          GetinTouchCard(
            icon: Icons.location_on,
            headname: 'Place',
            caption: 'Malappuram,Kerala,india',
          ),
          gyap(30, 0),
        ]),
      ),
    );
  }
}

class GetinTouchCard extends StatelessWidget {
  String headname;
  IconData icon;
  String caption;
  GetinTouchCard({
    super.key,
    required this.icon,
    required this.caption,
    required this.headname,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconButton(onPressed: () {}, icon: Icon(icon)),
            gyap(5, 0),
            SkillText(
                textname: headname, txtweight: FontWeight.bold, txtSize: 12),
            gyap(10, 0),
            SkillText(
                textname: caption, txtweight: FontWeight.normal, txtSize: 10),
          ],
        ),
      ),
    );
  }
}

class SkillText extends StatelessWidget {
  String textname;
  dynamic txtweight;
  dynamic txtSize;

  SkillText({
    required this.textname,
    required this.txtweight,
    required this.txtSize,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      textname,
      style: TextStyle(
          fontSize: txtSize.toDouble(),
          fontWeight: txtweight,
          color: Colors.black),
    );
  }
}
