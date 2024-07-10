import 'package:flutter/material.dart';


class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}


class _DetailScreenState extends State<DetailScreen> {
  var informationTextStyle = const TextStyle(fontFamily: 'Oxygen');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset('assets/pasar.jpg'),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: const Text(
                'Pasar Pabean Surabaya',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Staatliches',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Icon(Icons.calendar_today),
                      const SizedBox(height: 8.0),
                      Text(
                        'Open Everyday',
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Icon(Icons.access_time),
                      const SizedBox(height: 8.0),
                      Text(
                        '02:00 - 10:00',
                        style: informationTextStyle,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Icon(Icons.monetization_on),
                      const SizedBox(height: 8.0),
                      Text(
                        'Rp 15.000 - Rp 100.000',
                        style: informationTextStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Pasar Pabean Surabaya adalah salah satu pasar tradisional tertua dan paling terkenal di kota ini, terletak di Kecamatan Pabean Cantikan. Dikenal sebagai pusat perdagangan ikan segar, daging, sayuran, buah-buahan, dan rempah-rempah, pasar ini telah ada sejak zaman kolonial Belanda dan terus menjadi tempat penting bagi masyarakat lokal untuk berbelanja bahan makanan sehari-hari.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Oxygen',
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6svulpzmei89edUezzFewwgCk8RGYJBSqGQ&s'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          'https://a-cdn.sindonews.net/dyn/620/content/2015/03/07/151/973312/pabean-setia-menjaga-tradisi-r0q-thumb.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVcuAnjFVgHmZdyOKDWxAoxebSyMcB9drFlA&s'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
