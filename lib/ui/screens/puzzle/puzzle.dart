import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dogventurehq/constants/strings.dart';
import 'package:dogventurehq/states/data/color_list.dart';
import 'package:dogventurehq/states/data/puzzle.dart';
import 'package:dogventurehq/ui/designs/custom_btn.dart';
import 'package:dogventurehq/ui/screens/puzzle/char_con.dart';
import 'package:dogventurehq/ui/screens/puzzle/character_field.dart';
import 'package:dogventurehq/ui/widgets/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PuzzleScreen extends StatefulWidget {
  static String routeName = '/puzzle';
  const PuzzleScreen({Key? key}) : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  late final ConfettiController _controllerCenter = ConfettiController(
    duration: const Duration(seconds: 5),
  );
  List<String> choosenCharList = List.empty(growable: true);
  int _levelNo = 0;
  final bool _isAdLoaded = false;
  bool _finishFlag = false;
  bool _errorFlag = false;
  bool _isMute = false;
  List<bool> _charClickFlags = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: _isAdLoaded ? 590.h : 610.h,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Column(
                      children: [
                        // app bar
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // back btn
                              InkWell(
                                onTap: () => Get.back(),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: SvgPicture.asset(
                                  'assets/svgs/back.svg',
                                  width: 30.w,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              // level
                              Text(
                                'Level ${_levelNo + 1}',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: ConstantStrings.kFontHandlee,
                                ),
                              ),
                              InkWell(
                                onTap: () => setState(() => _isMute = !_isMute),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  width: 45.w,
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo.shade900,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    // speaker & mute btn
                                    child: SvgPicture.asset(
                                      _isMute
                                          ? 'assets/svgs/mute.svg'
                                          : 'assets/svgs/speaker.svg',
                                      color: _isMute ? Colors.white : null,
                                      width: 25.w,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        addH(25.h),
                        // question
                        Text(
                          'What animal is this?',
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        addH(25.h),
                        // picture
                        Container(
                          width: 350.w,
                          height: _isAdLoaded ? 360.h : 380.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: Image.asset(
                              PuzzleData.puzzleList[_levelNo].image,
                              height: _isAdLoaded ? 280.h : 300.h,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        addH(10.h),
                        // choosen characters
                        Row(
                          children: [
                            if (_finishFlag)
                              Container(
                                width: 55.w,
                                height: 55.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                    width: 2,
                                  ),
                                  color: Colors.blue.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    _errorFlag
                                        ? 'assets/svgs/cross.svg'
                                        : 'assets/svgs/check.svg',
                                    height: 35.h,
                                    color:
                                        _errorFlag ? Colors.red : Colors.green,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            const Spacer(),
                            SizedBox(
                              height: 55.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    PuzzleData.puzzleList[_levelNo].name.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CharacterField(
                                    char: choosenCharList.isEmpty
                                        ? ''
                                        : index > (choosenCharList.length - 1)
                                            ? ''
                                            : choosenCharList[index],
                                    clr: _errorFlag
                                        ? ColorList.clrs[5]
                                        : ColorList.clrs[index],
                                    noMargin: PuzzleData.puzzleList[_levelNo]
                                                    .name.length -
                                                1 ==
                                            index
                                        ? true
                                        : null,
                                  );
                                },
                              ),
                            ),
                            const Spacer(),
                            if (_finishFlag)
                              InkWell(
                                onTap: () => setState(() {
                                  if (!_errorFlag) {
                                    _controllerCenter.stop();
                                    _controllerCenter.play();
                                    return;
                                  }
                                  // erase fn
                                  _finishFlag = false;
                                  _errorFlag = false;
                                  choosenCharList.clear();
                                  _charClickFlags = <bool>[
                                    false,
                                    false,
                                    false,
                                    false,
                                    false,
                                    false,
                                    false,
                                    false,
                                  ];
                                }),
                                child: Container(
                                  width: 55.w,
                                  height: 55.h,
                                  decoration: _errorFlag
                                      ? BoxDecoration(
                                          border: Border.all(
                                            color: Colors.blueAccent,
                                            width: 2,
                                          ),
                                          color: Colors.blue.shade100,
                                          shape: BoxShape.circle,
                                        )
                                      : null,
                                  child: Center(
                                    child: _errorFlag
                                        ? SvgPicture.asset(
                                            'assets/svgs/erase.svg',
                                            height: 30.h,
                                            fit: BoxFit.fitHeight,
                                          )
                                        : Transform(
                                            transform: Matrix4.rotationY(pi),
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
                                              'assets/svgs/party.svg',
                                              height: 45.h,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // random characters
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5,
                      mainAxisExtent: _isAdLoaded ? 70.h : 80.h,
                      crossAxisSpacing: 30.w,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 5.h,
                    ),
                    itemCount: 8,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return _charClickFlags[index]
                          ? DottedBorder(
                              color: Colors.deepPurple,
                              radius: Radius.circular(20.r),
                              borderType: BorderType.RRect,
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                child: CharCon(
                                  char: PuzzleData
                                      .puzzleList[_levelNo].charList[index],
                                  noMargin: true,
                                  bgClr: ColorList.clrs[choosenCharList.indexOf(
                                    PuzzleData
                                        .puzzleList[_levelNo].charList[index],
                                  )],
                                  // onTapFn: () => setState(
                                  //   () => _charClickFlags[index] = false,
                                  // ),
                                ),
                              ),
                            )
                          : CharCon(
                              char: PuzzleData
                                  .puzzleList[_levelNo].charList[index],
                              onTapFn: () => setState(
                                () {
                                  if (choosenCharList.length <
                                      PuzzleData
                                          .puzzleList[_levelNo].name.length) {
                                    choosenCharList.add(
                                      PuzzleData
                                          .puzzleList[_levelNo].charList[index],
                                    );
                                    _charClickFlags[index] = true;
                                    var stringOfList = choosenCharList.join('');
                                    if (stringOfList ==
                                        PuzzleData.puzzleList[_levelNo].name) {
                                      _finishFlag = true;
                                      // print("success");
                                      _controllerCenter.play();
                                      return;
                                    }
                                    if (stringOfList.length ==
                                        PuzzleData
                                            .puzzleList[_levelNo].name.length) {
                                      setState(() {
                                        _finishFlag = true;
                                        _errorFlag = true;
                                      });
                                    }
                                  }
                                },
                              ),
                            );
                    },
                  ),
                  // ad view
                  if (_isAdLoaded)
                    Container(
                      width: 320.w,
                      height: 50.h,
                      margin: EdgeInsets.only(bottom: 5.h),
                      color: Colors.grey,
                    ),
                  if (!_isAdLoaded) addH(10.h),
                  CustomBtn(
                    onPressedFn: () => setState(() {
                      if (_levelNo < PuzzleData.puzzleList.length - 1) {
                        _controllerCenter.stop();
                        _finishFlag = false;
                        choosenCharList.clear();
                        _charClickFlags = <bool>[
                          false,
                          false,
                          false,
                          false,
                          false,
                          false,
                          false,
                          false,
                        ];
                        _levelNo++;
                      }
                    }),
                    btnTxt: 'Next',
                    btnSize: Size(200.w, 50.h),
                    btnBorderRadius: 20.r,
                    btnColor: Colors.green,
                    txtSize: 25.sp,
                  )
                ],
              ),
              ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    false, // start again as soon as the animation is finished
                colors:
                    ColorList.clrs, // manually specify the colors to be used
                createParticlePath: drawStar, // define a custom shape/path.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
