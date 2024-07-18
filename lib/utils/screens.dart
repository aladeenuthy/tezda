import 'dart:async';

import 'package:flutter/material.dart';


class AppScaffold extends StatefulWidget {
  const AppScaffold({
    Key? key,
    required this.body,
    this.backgroundColor,
    this.isLoading = false,
    this.appBar,
    this.floatingActionButton,
    this.isUnavailableFeatureScreen = false,
    this.addPadding = false,
    this.bottomsheet,
    this.bottomAppBar,
  }) : super(key: key);

  final Widget body;
  final Color? backgroundColor;
  final bool isLoading;
  final PreferredSizeWidget? appBar;
  final Widget? bottomsheet;
  final Widget? floatingActionButton, bottomAppBar;
  final bool isUnavailableFeatureScreen;
  final bool addPadding;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        floatingActionButton: widget.floatingActionButton,
        bottomSheet: widget.bottomsheet,
        backgroundColor: widget.backgroundColor,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: widget.bottomAppBar,
        appBar: widget.appBar,
        body:  Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                 padding: widget.addPadding ?  const EdgeInsets.symmetric(horizontal: 20) : EdgeInsets.zero,
                child: widget.body,
              ),
              if (widget.isLoading)
                Container(
                  color: Colors.black.withOpacity(.2),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                const SizedBox.shrink()
            ],
          ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title,
      this.leading,
      this.actions,
      this.backgroundColor,
      this.centerTitle,
      this.isLoading = false});
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool? centerTitle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor:
          isLoading ? Colors.black.withOpacity(.2) : backgroundColor,
      title: AbsorbPointer(absorbing: isLoading, child: title),
      leading: AbsorbPointer(absorbing: isLoading, child: leading),
      actions: actions != null
          ? [
              ...actions!
                  .map((action) => AbsorbPointer(
                        absorbing: isLoading,
                        child: action,
                      ))
                  .toList()
            ]
          : actions,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}



class AppAnimatedColumn extends StatefulWidget {
  const AppAnimatedColumn({
    AnimationController? animationController,
    required this.children,
    Key? key,
    this.mainAxisAlignment,
    this.duration,
    this.delay,
    this.crossAxisAlignment,
    this.direction = Axis.vertical,
    this.mainAxisSize,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController? _animationController;
  final List<Widget> children;
  final Duration? duration;
  final Duration? delay;
  final MainAxisAlignment? mainAxisAlignment;
  final Axis direction;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;

  @override
  State<AppAnimatedColumn> createState() => _AppAnimatedColumnState();
}

class _AppAnimatedColumnState extends State<AppAnimatedColumn>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Timer? delay;
  @override
  void initState() {
    super.initState();
    _animationController = widget._animationController ??
        AnimationController(
          vsync: this,
          duration: widget.duration ??
              Duration(
                milliseconds: widget.children.length * 150,
              ),
        );
    if (widget._animationController == null) {
      delay = Timer(widget.delay ?? Duration.zero, () {
        _animationController?.forward();
      });
    }
  }

  @override
  void dispose() {
    delay?.cancel();
    if (widget._animationController == null) {
      _animationController?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext context, Widget? child) {
        return Column(
          mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
          crossAxisAlignment:
              widget.crossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisAlignment:
              widget.mainAxisAlignment ?? MainAxisAlignment.start,
          children: <Widget>[
            ...List<Widget>.generate(widget.children.length, (int index) {
              return FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(
                  CurvedAnimation(
                    curve: Interval(
                      1 / widget.children.length * index * 0.5,
                      1 / widget.children.length * index,
                      curve: Curves.easeInOut,
                    ),
                    parent: _animationController!,
                  ),
                ),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: widget.direction == Axis.vertical
                        ? const Offset(0.0, 4)
                        : const Offset(.9, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      curve: Interval(
                        1 /
                            widget.children.length *
                            (index + index == 0 ? 2 : 1) *
                            0.25,
                        1 / widget.children.length * (index + 1),
                        curve: Curves.linearToEaseOut,
                      ),
                      parent: _animationController!,
                    ),
                  ),
                  child: widget.children[index],
                ),
              );
            })
          ],
        );
      },
    );
  }
}

class AppAnimatedRow extends StatefulWidget {
  const AppAnimatedRow({
    AnimationController? animationController,
    required this.children,
    Key? key,
    this.mainAxisAlignment,
    this.duration,
    this.delay,
    this.crossAxisAlignment,
    this.direction = Axis.vertical,
    this.mainAxisSize,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController? _animationController;
  final List<Widget> children;
  final Duration? duration;
  final Duration? delay;
  final MainAxisAlignment? mainAxisAlignment;
  final Axis direction;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;

  @override
  State<AppAnimatedRow> createState() => _AppAnimatedRowState();
}

class _AppAnimatedRowState extends State<AppAnimatedRow>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = widget._animationController ??
        AnimationController(
          vsync: this,
          duration: widget.duration ??
              Duration(milliseconds: widget.children.length * 200),
        );

    if (widget._animationController == null) {
      if (mounted) {
        Future<void>.delayed(widget.delay ?? const Duration(milliseconds: 100))
            .then((_) => _animationController.forward());
      }
    }
  }

  @override
  void dispose() {
    if (widget._animationController == null) {
      Future<void>.delayed(widget.delay ?? const Duration(milliseconds: 200))
          .then((_) => _animationController.forward());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Row(
          mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
          crossAxisAlignment:
              widget.crossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisAlignment:
              widget.mainAxisAlignment ?? MainAxisAlignment.start,
          children: <Widget>[
            ...List<Widget>.generate(widget.children.length, (int index) {
              return FadeTransition(
                key: ValueKey<int>(index),
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(
                  CurvedAnimation(
                    curve: Interval(
                      1 / widget.children.length * index * 0.1,
                      1 / widget.children.length * index,
                      curve: Curves.easeInOut,
                    ),
                    parent: _animationController,
                  ),
                ),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: widget.direction == Axis.vertical
                        ? const Offset(0.0, 1.0)
                        : const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      curve: Interval(
                        1 / widget.children.length * index * 0.1,
                        1 / widget.children.length * index,
                        curve: Curves.ease,
                      ),
                      parent: _animationController,
                    ),
                  ),
                  child: widget.children[index],
                ),
              );
            })
          ],
        );
      },
    );
  }
}
