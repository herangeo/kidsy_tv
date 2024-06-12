import 'package:flutter/material.dart';
import 'package:kidsy_tv/Firebase/links_store.dart';
import 'package:kidsy_tv/admob_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:kidsy_tv/admin_verification_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LinksDisplayPage extends StatefulWidget {
  const LinksDisplayPage({super.key});

  @override
  _LinksDisplayPageState createState() => _LinksDisplayPageState();
}

class _LinksDisplayPageState extends State<LinksDisplayPage> {
  BannerAd? _banner;
  InterstitialAd? _interstitialAd;
  WebViewController? controller;
  String _initialUrl = 'about:blank'; 

  @override
  void initState() {
    super.initState();
    _createBannerAd();
    _createInterstitialAd();
    _fetchLink();
  }

  Future<void> _fetchLink() async {
    FirestoreService firestoreService = FirestoreService();
    String? link = await firestoreService.getLink();
    if (link != null) {
      setState(() {
        _initialUrl = link;
      });
      controller?.loadRequest(Uri.parse(_initialUrl));
    }
  }

  void _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdunitId!,
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          print('Banner Ad failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_initialUrl));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminLoginPage()),
              );
            },
            icon: const Icon(Icons.person_4_sharp, color: Color.fromARGB(255, 37, 35, 35)),
          )
        ],
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "V I D E O S",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  "K I D S Y - T V",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black),
              title: const Text(
                "H O M E",
                style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: WebViewWidget(controller: controller!),
      bottomNavigationBar: _banner == null
          ? const Center(child: Text("Ad is not loading"))
          : Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 52,
              child: AdWidget(ad: _banner!),
            ),
    );
  }
}
