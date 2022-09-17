import 'dart:io';

import 'package:dogventurehq/constants/colors.dart';
import 'package:dogventurehq/constants/strings.dart';
import 'package:dogventurehq/ui/screens/home/box.dart';
import 'package:dogventurehq/ui/widgets/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isAdLoaded = false;
  late BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    _initBannerAd();
  }

  _initBannerAd() {
    print('init banner ad');
    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? ConstantStrings.kAdUnitIdAndroid
          : ConstantStrings.kAdUnitIdIOS,
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('ad loaded');
          setState(() => _isAdLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          setState(() => _isAdLoaded = false);
        },
      ),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // avatar
              Container(
                height: _isAdLoaded ? 118.h : 180.h,
                width: _isAdLoaded ? 118.w : 180.w,
                margin: EdgeInsets.only(top: 30.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber.shade100,
                ),
                child: Center(
                  child: Container(
                    height: _isAdLoaded ? 90.h : 150.h,
                    width: _isAdLoaded ? 90.h : 150.w,
                    padding: EdgeInsets.all(25.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amber.shade300,
                    ),
                    child: SvgPicture.asset(
                      ConstantStrings.kCatAvatar,
                    ),
                  ),
                ),
              ),
              addH(15.h),
              // greetings
              Text(
                "Good Morning,",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontFamily: ConstantStrings.kFontHandlee,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // name
              Text(
                "Mama!",
                style: TextStyle(
                  color: Colors.amber.shade800,
                  fontSize: 28.sp,
                  fontFamily: ConstantStrings.kFontPermanentMarker,
                  fontWeight: FontWeight.w700,
                ),
              ),
              addH(25.h),
              // boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // numbers
                  HomeBox(
                    bgClr: ConstantColors.kHomeBox1Clr,
                    onTapFn: () {},
                    img: ConstantStrings.kNumbers,
                    title: 'Numbers',
                    titleClr: Colors.green,
                    subTitle: 'All about number',
                  ),
                  // reading
                  HomeBox(
                    bgClr: ConstantColors.kHomeBox2Clr,
                    onTapFn: () {},
                    img: ConstantStrings.kReading,
                    title: 'Reading',
                    titleClr: Colors.red,
                    subTitle: 'Reading some word',
                  ),
                ],
              ),
              addH(30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // puzzle
                  HomeBox(
                    bgClr: ConstantColors.kHomeBox3Clr,
                    onTapFn: () {},
                    img: ConstantStrings.kNumbers,
                    title: 'Puzzle',
                    titleClr: Colors.blue,
                    subTitle: 'Arranging puzzle',
                  ),
                  // drawing
                  HomeBox(
                    bgClr: ConstantColors.kHomeBox4Clr,
                    onTapFn: () {},
                    img: ConstantStrings.kNumbers,
                    title: 'Drawing',
                    titleClr: Colors.purple,
                    subTitle: 'Coloring a picture',
                  ),
                ],
              ),
              if (_isAdLoaded)
                Container(
                  height: _bannerAd.size.height.toDouble(),
                  width: _bannerAd.size.width.toDouble(),
                  margin: EdgeInsets.only(top: 10.h),
                  child: AdWidget(ad: _bannerAd),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          color: Colors.amber.shade100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            Icon(
              Icons.home,
              color: Colors.amber.shade900,
            ),
            const Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
