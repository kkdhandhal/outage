import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:outage/component/dropdown.dart';

import 'Tabview.dart';

//import 'package:searchfield/searchfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _clist = ["India", "USA", "UK"];
  late TextEditingController _searchController;
  String Selected_value = "";

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();

    super.dispose();
  }

  int suggestionsCount = 12;
  @override
  Widget build(BuildContext context) {
    final suggList = [
      '11  KV FULZAR-43507',
      '11 JAYSHAKTI-99005',
      '11 KV  FALKU AG-47409',
      '11 KV  JESDA-108404',
      '11 KV ABHAY-98702',
      '11 KV ACHHAVADA-86305',
      '11 KV ADARIYANA-86401',
      '11 KV ADHELI JGY-365601',
      '11 KV AHINSHA-47402',
      '11 KV AJMER AG-120710',
      '11 KV AKALVAD-47012',
      '11 KV AKASH-144806',
      '11 KV ALAMPURA-86304',
      '11 KV AMARAPAR-43407',
      '11 KV AMBA-47908',
      '11 KV AMBAVADI-46305',
      '11 KV AMBEDKARNAGAR URB-25201',
      '11 KV AMBIKA IND-144803',
      '11 KV ANANDPUR-43405',
      '11 KV ANKADIYA AG-366204',
      '11 KV ANKEVALIYA-46109',
      '11 KV ARJUN AG-144710',
      '11 KV ASHAPURA AG-86207',
      '11 KV AVADH URB-365306',
      '11 KV AYA-43806',
      '11 KV BABA RAMDEV AG-365505',
      '11 KV BAISABGADH-98706',
      '11 KV BAJANA-53001',
      '11 KV BAJRAN AG-367002',
      '11 KV BAJRANG AG-125208',
      '11 KV BAJRANG AG-366904',
      '11 KV BAJRANG-82503',
      '11 KV BAKARTHADI-46712',
      '11 KV BALA HANUMAN-47916',
      '11 KV BALALA JGY-364702',
      '11 KV BALDANA AG(TUVA-98806',
      '11 KV BALI-144906',
      '11 KV BALOL (PANDARI) JGY-46107',
      '11 KV BALOL (PANDRI)-46107',
      '11 KV BAMANVA-45507',
      '11 KV BANDIYABELI JGY-43411',
      '11 KV BHADAR AG-368302',
      '11 KV BHAGWANPAR AG-365704',
      '11 KV BHAIRAV-365507',
      '11 KV BHALAGADI-46612',
      '11 KV BHALAHANUMAN-99001',
      '11 KV BHALGADI-46612',
      '11 KV BHANEJDA-42109',
      '11 KV BHARAD AG-46706',
      '11 KV BHARAD-46706',
      '11 KV BHARDESWAR JGY-363903',
      '11 KV BHAVANI AG-47109',
      '11 KV BHECHADA-86102',
      '11 KV BHESJAL JGY-364203',
      '11 KV BHOJPARI JGY-46801',
      '11 KV BHOLESHWAR JGY-365401',
      '11 KV BHRUGUPUR-42110',
      '11 KV BODIYA-42107',
      '11 KV BORANA-42104',
      '11 KV BORIYA-99404',
      '11 KV BRAMHA-144601',
      '11 KV BROMIN-47002',
      '11 KV BUBVANA JGY-45407',
      '11 KV CHANDRELIYA AG-365103',
      '11 KV CHANPA JGY-162901',
      '11 KV CHHABLI-89405',
      '11 KV CHHADIYALI AG (NINAMA)-91001',
      '11 KV CHHALALA-367404',
      '11 KV CHHATRIYALA-42003',
      '11 KV CHHATROT-86302',
      '11 KV CHIKASAR-45505',
      '11 KV CHIRODA AG-366005',
      '11 KV CHOBARI-46804',
      '11 KV CHOKDI-42102',
      '11 KV CHOKI AG (PANSINA)-46104',
      '11 KV CHOKI AG-46104',
      '11 KV CHORVIRA AG-43809',
      '11 KV CHORVIRA JGY-47103',
      '11 KV CHORVIRA-43809',
      '11 KV CHOTILA CITY-43501',
      '11 KV CHUDA-42101',
      '11 KV CHULI JGY-86208',
      '11 KV D. C. W.-46402',
      '11 KV DADA AG-43408',
      '11 KV DAIRY-46307',
      '11 KV DANAVADA-108109',
      '11 KV DASADA-45402',
      '11 KV DEDADARA-47508',
      '11 KV DEEP AG-99305',
      '11 KV DEGAM-53002',
      '11 KV DEM JGY-367504',
      '11 KV DEVCHARDI-46702',
      '11 KV DEVGADH AG-151508',
      '11 KV DEVPARA(D) JGY-365101',
      '11 KV DEVSAR-43510',
      '11 KV DHAJALA  INDU.-46605',
      '11 KV DHAJALA AG-99705',
      '11 KV DHAJALA-91004',
      '11 KV DHAKANIYA-43811',
      '11 KV DHAMA-99203',
      '11 KV DHANDHALPUR JGY-99702',
      '11 KV DHAR AG-108409',
      '11 KV DHARMDEEP-86113',
      '11 KV DHARMDEV-46408',
      '11 KV DHARPIPLA-42004',
      '11 KV DHARTI AG-47206',
      '11 KV DHAVANA-108508',
      '11 KV DHG. CITY-46401',
      '11 KV DHIKWADI JGY-368801',
      '11 KV DHOKALVA  (L)-46807',
      '11 KV DHOKALVA-86601',
      '11 KV DHOLI-86104',
      '11 KV DHOLIYA AG-43808',
      '11 KV DHOLIYA JGY-144901',
      '11 KV DHRUV AG-47407',
      '11 KV DIGSAR-108103',
      '11 KV D-MART-368205',
      '11 KV DOLATPAR AG-366203',
      '11 KV DOLATPAR AG-46112',
      '11 KV DOLIYA-46603',
      '11 KV DUDAPUR-46705',
      '11 KV DUDHAI-108205',
      '11 KV DUDHESHWAR AG-365506',
      '11 KV EKLAVYA AG-98707',
      '11 KV EKTA-86214',
      '11 KV FULESWAR-46403',
      '11 KV FULGRAM-46607',
      '11 KV GAJANAND URBN-46316',
      '11 KV GAJANVAV-86105',
      '11 KV GANESH-46913',
      '11 KV GANGA AG-365606',
      '11 KV GANGAJAL AG-368303',
      '11 KV GANGANAGAR-366905',
      '11 KV GANGAVAV-47504',
      '11 KV GANJELA JGY-46710',
      '11 KV GARIDA AG-162911',
      '11 KV GASPUR-45508',
      '11 KV GAUTAM AG-366205',
      '11 KV GAVANA-86409',
      '11 KV GAYATRI AG-46917',
      '11 KV GELMA-46914',
      '11 KV GHADAD-86504',
      '11 KV GHASPUR-45508',
      '11 KV GIDC-368204',
      '11 KV GOKHARWADA-42105',
      '11 KV GOPALGADH-47006',
      '11 KV GOPALNAGAR-364705',
      '11 KV GOPINATH-365301',
      '11 KV GOSAL AG-364404',
      '11 KV GOSANA-86303',
      '11 KV GURUDATATRAY AG-86117',
      '11 KV GURUKRUPA AG-99807',
      '11 KV GURUKUL (BHALA HANUMAN)-99001',
      '11 KV GURUKUL(JADESHWAR)-99002',
      '11 KV H.C.C-45307',
      '11 KV HADALA JGY-98602',
      '11 KV HADALA-43803',
      '11 KV HAMPAR-46703',
      '11 KV HARI-47202',
      '11 KV HARIOM-108208',
      '11 KV HARIRAJ URBN-46315',
      '11 KV HATKESHWER-47906',
      '11 KV HIGHWAY URBAN-43514',
      '11 KV HIRANA-343304',
      '11 KV HIRAPUR-46708',
      '11 KV ISHADRA-125305',
      '11 KV ISHWARIYA JGY-25101',
      '11 KV ISHWARIYA-43810',
      '11 KV JAINABAD-45504',
      '11 KV JAISHAKTI-46909',
      '11 KV JALDHARA-144802',
      '11 KV JAMUNA URB-46111',
      '11 KV JAMVADI-43402',
      '11 KV JANSALI-46108',
      '11 KV JASAPAR  JGY-367501',
      '11 KV JASAPAR-86109',
      '11 KV JASMATPAR JGY-98601',
      '11 KV JASMATPUR-47001',
      '11 KV JAVAN AG-365602',
      '11 KV JAY BHIMNATH AG-366902',
      '11 KV JAY BHOLE-144711',
      '11 KV JAY HANUMAN AG-47105',
      '11 KV JAY KHODIYAR-99003',
      '11 KV JAY MATAJI AG-366903',
      '11 KV JAY SHAKTI-99005',
      '11 KV JAYBHAVANI AG-125206',
      '11 KV JETHIRA AG-363901',
      '11 KV JINTAN-46304',
      '11 KV JIVA-86203',
      '11 KV JIVAPAR JGY-46806',
      '11 KV JOBALA AG-367402',
      '11 KV JOG-43410',
      '11 KV JOLLY-43511',
      '11 KV JUGALIYA-144801',
      '11 KV JUNA PATDI-45403',
      '11 KV JUNA PATDI-II-45405',
      '11 KV JUNCTION-47901',
      '11 KV K. C. MILL-46306',
      '11 KV KABRAN AG-98304',
      '11 KV KAILASH AG-108113',
      '11 KV KALAMAD-108207',
      '11 KV KALAYANPUR-46905',
      '11 KV KALMAD-45812',
      '11 KV KALPANA AG-125303',
      '11 KV KALPAR URBN-368202',
      '11 KV KAMALPUR-89401',
      '11 KV KAMPALIYA-108214',
      '11 KV KANAKPAR-46911',
      '11 KV KANKAVATI-47005',
      '11 KV KANKESHVAR-125202',
      '11 KV KANPAR-43805',
      '11 KV KANSARA AG-43814',
      '11 KV KANTHARIYA-366201',
      '11 KV KARIYANI JGY-364001',
      '11 KV KARTIK-47401',
      '11 KV KATARIYA JGY-46110',
      '11 KV KATHADA JGY-86411',
      '11 KV KAVERI-47205',
      '11 KV KERALA AG-47506',
      '11 KV KERALA-47506',
      '11 KV KERIYA AG-42011',
      '11 KV KESARINANDAN AG-47107',
      '11 KV KESARPAR AG-364404',
      '11 KV KESARPAR AG-364405',
      '11 KV KESAV-47211',
      '11 KV KESHAV-46916',
      '11 KV KHAJELI JGY-47503',
      '11 KV KHAKHARALI-43406',
      '11 KV KHAKHARATHAL-144702',
      '11 KV KHAMBHADA-46704',
      '11 KV KHAMISANA-47907',
      '11 KV KHANDIYA AG-364704',
      '11 KV KHARAGHODA JGY-45509',
      '11 KV KHARESHVAR JGY-97501',
      '11 KV KHARVA-47505',
      '11 KV KHATDI-86501',
      '11 KV KHERALI JGY-47905',
      '11 KV KHERVA JGY-89406',
      '11 KV KHODIYAR AG-367403',
      '11 KV KHODU JGY-108105',
      '11 KV KISAN AG-365603',
      '11 KV KISHAN (B)-47406',
      '11 KV KISHAN AG-364107',
      '11 KV KISHAN AG-45309',
      '11 KV KONDH JGY-46912',
      '11 KV KONDHESHWAR-46910',
      '11 KV KORADA-91008',
    ];

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue[800],
      // appBar: AppBar(
      //   title: const Text("IT Application"),
      //   backgroundColor: Colors.deepPurple,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 8, bottom: 5, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Mr Krushna Dhandhal",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "JP, Surendranagar Circle",
                          style: TextStyle(
                              color: Color.fromARGB(255, 119, 186, 241),
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, top: 1, bottom: 1, right: 15),
              child: DropDown(
                suggList: suggList,
                OnSelect: ((value) {
                  Selected_value = value;
                  setState(() {});
                  //print(Selected_value);
                }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Selected Feeder  is : $Selected_value'),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: Tabview(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
