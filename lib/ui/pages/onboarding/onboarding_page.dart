import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:flutter_base/ui/pages/onboarding/onboarding_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends StatelessWidget {
  static const router = 'onBoarding';
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return OnBoardingCubit();
      },
      child: const OnBoardingChildPage(),
    );
  }
}

class OnBoardingChildPage extends StatefulWidget {
  const OnBoardingChildPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnBoardingChildPageState();
  }
}

class _OnBoardingChildPageState extends State<OnBoardingChildPage> {
  late OnBoardingCubit _cubit;
  final PageController _pageViewController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<OnBoardingCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Stack(
          children: [
            BlocBuilder<OnBoardingCubit, OnBoardingState>(
              bloc: _cubit,
              buildWhen: (previous, current) =>
                  previous.activePage != current.activePage,
              builder: (context, state) {
                return PageView.builder(
                    controller: _pageViewController,
                    onPageChanged: (index) {
                      debugPrint(index.toString());
                      _cubit.onPageChanged(index);
                    },
                    itemCount: _pages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _pages[state.activePage];
                    });
              },
            ),
            Positioned(
              bottom: 70,
              left: 0,
              right: 0,
              height: 28,
              child: SizedBox(
                width: double.infinity,
                child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
                  bloc: _cubit,
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            context.go("/${SignInPage.router}");
                          },
                          child: const Text("Skip"),
                        ),
                        const Spacer(),
                        ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _pages.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 5,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                _pageViewController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: state.activePage == index
                                    ? Colors.black
                                    : Colors.black.withOpacity(0.3),
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            int nextPage = state.activePage + 1;
                            _pageViewController.animateToPage(nextPage,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                            _cubit.onNextPage(
                              nextPage: nextPage,
                              context: context,
                            );
                          },
                          child: const Text('Next'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose(); // dispose the PageController
  }
}

final List<Widget> _pages = [
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        AppImages.bgImagePlaceholder,
        width: 300,
        height: 300,
        fit: BoxFit.fill,
      ),
      Text(
        "Welcome to Surf.",
        style: AppTextStyle.blackS18W800,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 24,
      ),
      Text(
        "I provide essential stuff for your ui designs every tuesday!",
        style: AppTextStyle.blackS14,
        textAlign: TextAlign.center,
      ),
    ],
  ),
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        AppImages.bgImagePlaceholder,
        width: 300,
        height: 300,
        fit: BoxFit.fill,
      ),
      Text(
        "Design Template uploads Every Tuesday!",
        style: AppTextStyle.blackS18W800,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 24,
      ),
      Text(
        "Make sure to take a look my uplab profile every tuesday",
        style: AppTextStyle.blackS14,
        textAlign: TextAlign.center,
      ),
    ],
  ),
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        AppImages.bgImagePlaceholder,
        width: 300,
        height: 300,
        fit: BoxFit.fill,
      ),
      Text(
        "Download now!",
        style: AppTextStyle.blackS18W800,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        "You can follow me if you wantand comment on any to get some freebies",
        style: AppTextStyle.blackS14,
        textAlign: TextAlign.center,
      ),
    ],
  ),
];
