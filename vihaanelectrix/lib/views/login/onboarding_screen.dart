import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:vihaanelectrix/models/login/on_board.dart';
import 'package:vihaanelectrix/providers/common_provider.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/views/login/terms.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<OnboardingModel> _list = OnboardingModel.list;
  CommonProvider? co;
  int page = 0;
  final _controller = PageController();
  bool showAnimatedContainer = false;

  List<String> titles = [];
  List<String> content = [];
  List<String> images = [];

  getAllconstants() {
    List<String> titleName = [
      "screen1_title",
      "screen2_title",
      "screen3_title",
      "screen4_title",
      "screen5_title",
      "screen6_title",
      "screen7_title"
    ];
    List<String> contentName = [
      "screen1_content",
      "screen2_content",
      "screen3_content",
      "screen4_content",
      "screen5_content",
      "screen6_content",
      "screen7_content"
    ];
    List<String> imageNames = [
      "screen1_image",
      "screen2_image",
      "screen3_image",
      "screen4_image",
      "screen5_image",
      "screen6_image",
      "screen7_image"
    ];

    for (String item in titleName) {
      titles.add(co?.getText(item));
    }
    for (String item in contentName) {
      content.add(co?.getText(item));
    }
    for (String item in imageNames) {
      images.add(co?.getText(item));
    }
  }

  @override
  void initState() {
    // constantsFunc();
    co = Provider.of<CommonProvider>(context, listen: false);
    co?.setCurrentConstants("onBoard");
    getAllconstants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _controller.addListener(() {
      setState(() {
        page = _controller.page!.round();
      });
    });
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            showAnimatedContainer
                ? Center(
                    child: MyAnimatedContainer(),
                  )
                : SafeArea(
                    child: Column(
                      children: [
                        // ThisButton(),
                        Expanded(
                          child: PageView.builder(
                              controller: _controller,
                              itemCount: _list.length,
                              itemBuilder: (context, index) => MainContent(
                                  contents: content,
                                  titles: titles,
                                  images: images,
                                  index: index,
                                  list: _list)),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 15,
                        ),
                        StepsContainer(
                          nextLabel: co?.getText("next_button"),
                          skipLabel: co?.getText("skip_button"),
                          page: page,
                          list: _list,
                          controller: _controller,
                          showAnimatedContainerCallBack: (value) {
                            setState(() {
                              showAnimatedContainer = value;
                              if (value) {
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Terms()));
                                });
                              }
                            });
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize! * 4,
                        )
                      ],
                    ),
                  ),
          ],
        ));
  }
}

class MyAnimatedContainer extends StatelessWidget {
  const MyAnimatedContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      tween: Tween(
        begin: 0.0,
        end: SizeConfig.orientation == Orientation.portrait
            ? SizeConfig.screenHeight
            : SizeConfig.screenWidth,
      ),
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
      builder: (context, child, value) {
        return Container(
          width: value,
          height: value,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("images/welcome_image.png"))),
        );
      },
    );
  }
}

//skip button
class ThisButton extends StatelessWidget {
  final double? size;
  final String? label;
  const ThisButton({Key? key, required this.label, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButtonWidget(
            height: SizeConfig.defaultSize! * 3.5,
            minWidth: width(context) * size,
            bgColor: Colors.white,
            textColor: Colors.grey[900],
            textSize: width(context) * 0.05,
            textStyle: FontWeight.w600,
            buttonName: label,
            allRadius: true,
            elevation: 7.0,
            borderRadius: 15.0,
            onClick: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Terms()));
            },
          ),
        ],
      ),
    );
  }
}

//step container

class StepsContainer extends StatelessWidget {
  const StepsContainer(
      {Key? key,
      required this.page,
      required List<OnboardingModel> list,
      required this.skipLabel,
      required this.nextLabel,
      required PageController controller,
      required this.showAnimatedContainerCallBack})
      : lists = list,
        controllers = controller,
        super(key: key);

  final int page;
  final List<OnboardingModel> lists;
  final PageController controllers;
  final Function showAnimatedContainerCallBack;
  final String skipLabel;
  final String nextLabel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.9,
      height: SizeConfig.defaultSize! * 3.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ThisButton(
            size: 0.26,
            label: skipLabel,
          ),
          ThisButton(
            size: 0.6,
            label: nextLabel,
          )
        ],
      ),
    );
  }
}
//
//common widget button

class CommonButtonWidget extends StatelessWidget {
  final Function? onTap;
  final Color? textColor;
  final Color? bgColor;
  final String? title;
  final double? textSizePercentage;
  final double? width;
  final double? height;
  final Color? borderColor;
  final BorderRadius? raduis;
  const CommonButtonWidget(
      {Key? key,
      this.textColor,
      this.onTap,
      this.title,
      this.width,
      this.height,
      this.bgColor,
      this.textSizePercentage,
      this.borderColor,
      this.raduis})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 50,
      decoration: BoxDecoration(
          color: bgColor ?? Colors.blue[800],
          border:
              Border.all(color: borderColor ?? Colors.transparent, width: 1),
          borderRadius: raduis ??
              BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topLeft: Radius.circular(25))),
      child: Center(
        child: CommonText(
          text: title,
          textColor: textColor ?? Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: textSizePercentage,
        ),
      ),
    );
  }
}

//common text

class CommonText extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? fontSize;
  final double? padding;
  final FontWeight? fontWeight;
  const CommonText(
      {Key? key,
      this.text,
      this.textColor,
      this.fontWeight,
      this.padding,
      this.fontSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: textColor ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: SizeConfig.defaultSize! * (fontSize ?? 1.8)),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent(
      {Key? key,
      required this.images,
      required this.index,
      required this.titles,
      required this.contents,
      this.list})
      : super(key: key);

  final List<String> images;
  final int index;
  final List<String> contents;
  final List<String> titles;
  final List<OnboardingModel>? list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: FadeAnimation(
              0.5,
              Image.asset(
                list![index].image!,
                height: SizeConfig.defaultSize! * 25,
                width: SizeConfig.defaultSize! * 25,
              ),
            ),
          ),
          FadeAnimation(
            0.9,
            Text(
              // _list[index].title!,
              titles[index],

              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.defaultSize! * 2.6),
            ),
          ),
          SizedBox(
            height: SizeConfig.defaultSize!,
          ),
          FadeAnimation(
            1.1,
            Text(
              contents[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.defaultSize! * 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

//fade animation

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {Key? key, AssetImage? image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0),
          Duration(milliseconds: 500))
      ..add(AniProps.translateY, Tween(begin: -30.0, end: 0.0),
          Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(0, value.get(AniProps.translateY)), child: child),
      ),
    );
  }
}
