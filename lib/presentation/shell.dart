import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'common/box_shadow.dart';
import 'styles.dart';

class Shell extends StatelessWidget {
  final String appBarTitle;
  final bool isAppBarBackButtonVisible;
  final StatefulNavigationShell navigationShell;

  const Shell({
    super.key,
    required this.appBarTitle,
    required this.isAppBarBackButtonVisible,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: ShellAppBar(
        title: appBarTitle,
        isBackButtonVisible: isAppBarBackButtonVisible,
      ),
      backgroundColor: Styles.scaffoldColor,
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            return Styles.navBarLabel.copyWith(
                color: states.contains(MaterialState.selected)
                    ? Styles.navBarSelectedColor
                    : Colors.black.withOpacity(0.4));
          }),
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [boxShadow],
            color: Colors.white,
          ),
          height: 94.h,
          child: NavigationBar(
            destinations: [
              NavBarDestination(
                svgImagePath: 'assets/images/nav_home.svg',
                label: l10n.homeRouteLabel,
              ),
              NavBarDestination(
                svgImagePath: 'assets/images/nav_atms.svg',
                label: l10n.atmsRouteLabel,
              ),
              NavBarDestination(
                svgImagePath: 'assets/images/nav_money_box.svg',
                label: l10n.moneyBoxRouteLabel,
              ),
            ],
            indicatorColor: Colors.transparent,
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            selectedIndex: navigationShell.currentIndex,
            surfaceTintColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ShellAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonVisible;

  const ShellAppBar({
    super.key,
    required this.title,
    required this.isBackButtonVisible,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Styles.appBarColor,
      title: Row(
        children: [
          SizedBox(width: 16.w),
          isBackButtonVisible
              ? Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(
                        'assets/images/arrow_back.svg',
                        width: 32.w,
                        height: 32.h,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Text(title, style: Styles.appBarTitle),
        ],
      ),
      titleSpacing: 0,
    );
  }
}

class NavBarDestination extends StatelessWidget {
  final String svgImagePath;
  final String label;

  const NavBarDestination({
    super.key,
    required this.svgImagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: SvgPicture.asset(
        svgImagePath,
        width: 26.w,
        height: 26.h,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.4),
          BlendMode.srcIn,
        ),
      ),
      label: label,
      selectedIcon: SvgPicture.asset(
        svgImagePath,
        width: 26.w,
        height: 26.h,
        colorFilter: const ColorFilter.mode(
          Styles.navBarSelectedColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
