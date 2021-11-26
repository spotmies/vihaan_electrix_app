import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// ignore: implementation_imports
import 'package:simple_animations/simple_animations.dart';
import 'package:vihaanelectrix/models/login/on_board.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';
import 'package:vihaanelectrix/views/login/login_screen.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<OnboardingModel> _list = OnboardingModel.list;
  int page = 0;
  final _controller = PageController();
  var showAnimatedContainer = false;

  /* -------------------------- THIS IS FOR CONSTATNS ------------------------- */
  dynamic constants;
  bool showUi = false;

  getText(String objId) {
    if (constants == null) return "loading..";
    int index = constants?.indexWhere(
        (element) => element['objId'].toString() == objId.toString());
    if (index == -1) return "null";
    return constants[index]['label'];
  }

  constantsFunc() async {
    dynamic allConstants = await getAppConstants();
    setState(() {
      showUi = true;
    });
    constants = allConstants['onBoard'];
  }

  /* -------------------------- END OF THE CONSTANTS -------------------------- */
  
  @override
  Widget build(BuildContext context) {
    // UserViewModel userViewModel = context.watch<UserViewModel>();
    // UserModel users = userViewModel.user[0];

    SizeConfig().init(context);
    _controller.addListener(() {
      setState(() {
        page = _controller.page!.round();
      });
    });
    return Scaffold(
        backgroundColor: Colors.white,
        // body: ListView.separated(
        //   itemBuilder: (context, index) {
        //     UserModel userModel = userViewModel.users[index] as UserModel;
        //     return Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         // ignore: avoid_unnecessary_containers
        //         Container(
        //           child: Text(
        //             userModel.toString(),
        //             style: TextStyle(fontSize: 100, color: Colors.black),
        //           ),
        //         ),
        //       ],
        //     );
        //   },
        //   separatorBuilder: (context, index) => Divider(),
        //   itemCount: userViewModel.users.length,
        // ),
        body: Stack(
          children: [
            showAnimatedContainer
                ? Center(
                    child: MyAnimatedContainer(),
                  )
                : SafeArea(
                    child: Column(
                      children: [
                        // SkipButton(),
                        Expanded(
                          child: PageView.builder(
                              controller: _controller,
                              itemCount: _list.length,
                              itemBuilder: (context, index) => MainContent(
                                    list: _list,
                                    index: index,
                                  )),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 15,
                        ),
                        StepsContainer(
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
                                          builder: (context) =>
                                              OnBoardingScreen()));
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
class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButtonWidget(
            height: SizeConfig.defaultSize! * 3.5,
            minWidth: width(context) * 0.25,
            bgColor: Colors.white,
            textColor: Colors.grey[900],
            textSize: width(context) * 0.05,
            textStyle: FontWeight.w600,
            buttonName: "Skip",
            elevation: 7.0,
            borderRadius: 15.0,
            onClick: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
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
      required PageController controller,
      required this.showAnimatedContainerCallBack})
      : _list = list,
        _controller = controller,
        super(key: key);

  final int page;
  final List<OnboardingModel> _list;
  final PageController _controller;
  final Function showAnimatedContainerCallBack;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.9,
      height: SizeConfig.defaultSize! * 3.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SkipButton(),
          ElevatedButtonWidget(
            height: SizeConfig.defaultSize! * 3.5,
            minWidth: width(context) * 0.6,
            bgColor: Colors.white,
            textColor: Colors.grey[900],
            elevation: 7.0,
            textSize: width(context) * 0.05,
            textStyle: FontWeight.w600,
            buttonName: "Next",
            borderRadius: 15.0,
            onClick: () {
              if (page < _list.length && page != _list.length - 1) {
                _controller.animateToPage(page + 1,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeInCirc);
                showAnimatedContainerCallBack(false);
              } else {
                showAnimatedContainerCallBack(true);
              }
            },
          ),
        ],
      ),
    );
  }
}

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
      {Key? key, required List<OnboardingModel> list, required this.index})
      : _list = list,
        super(key: key);

  final List<OnboardingModel> _list;
  final int index;

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
              SvgPicture.asset(
                _list[index].image!,
                height: SizeConfig.defaultSize! * 20,
                width: SizeConfig.defaultSize! * 20,
              ),
            ),
          ),
          FadeAnimation(
            0.9,
            Text(
              _list[index].title!,
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
              _list[index].text!,
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
