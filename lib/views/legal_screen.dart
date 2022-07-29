import 'package:flutter/material.dart';

//Utils
import '../util.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rechtliches',
          style: appBarTextStyle,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: const [
          Text(
            'AGB SHISHA VERMIETUNG & TABAKPROBEN',
            style: legalTitleTextStyle,
          ),
          SizedBox(height: 50),
          Text(
            "ahmet57yahya Jul 24, 4:03 PM Translate to English ReportSpam AGB SHISHA VERMIETUNG & TABAKPROBEN Laut Gesetz gilt folgendes:  Siegelbruch, § 25 Abs. 1 Satz 1 TabStG  Die Kleinverpackungen dürfen nicht geöffnet und das Steuerzeichen darf nicht beschädigt werden.   Ausnahmen:  Packungen, die nicht Feinschnitt oder Zigaretten enthalten, dürfen zur Kontrolle bzw. zur Verteilung kostenloser Proben geöffnet werden.   § 25 Abs. 1 Satz TabStG  (5) Rauchtabak ist Feinschnitt, wenn mehr als 25 Prozent des Gewichts der Tabakteile weniger als 1,5 Millimeter lang oder breit.   Mit dem Betreten des Lokals und dem Bestellen einer Shisha erklären Sie sich einverstanden.",
            style: legalSubTitleTextStyle,
          ),
        ],
      ),
    );
  }
}
