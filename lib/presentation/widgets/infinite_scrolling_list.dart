import 'package:flutter/material.dart';

class InfiniteScrollingList extends StatefulWidget {
  final List<Widget> children;
  final Axis scrollDirection;
  final double speed;
  final double gap;
  final bool reverse;

  const InfiniteScrollingList({
    super.key,
    required this.children,
    this.scrollDirection = Axis.horizontal,
    this.speed = 40.0, // pixels per second
    this.gap = 20.0,
    this.reverse = false,
  });

  @override
  State<InfiniteScrollingList> createState() => _InfiniteScrollingListState();
}

class _InfiniteScrollingListState extends State<InfiniteScrollingList> {
  late ScrollController _scrollController;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() {
    if (!mounted || !_scrollController.hasClients) return;
    
    setState(() {
      _isScrolling = true;
    });
    
    _scrollLoop();
  }

  Future<void> _scrollLoop() async {
    while (_isScrolling && mounted && _scrollController.hasClients) {
      final currentPos = _scrollController.position.pixels;
      final maxScroll = _scrollController.position.maxScrollExtent;
      
      // Calculate how much distance is left to scroll
      final distanceToScroll = maxScroll - currentPos;
      
      if (distanceToScroll <= 0) {
        // If we reached the end, jump back to the start
        _scrollController.jumpTo(0);
        continue;
      }
      
      // Calculate duration based on distance and speed
      final durationMs = (distanceToScroll / widget.speed * 1000).toInt();
      
      await _scrollController.animateTo(
        maxScroll,
        duration: Duration(milliseconds: durationMs),
        curve: Curves.linear,
      );
      
      // Once it completes (or is interrupted), if it reached the end, jump to start
      if (mounted && _scrollController.hasClients && 
          _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 1) {
        _scrollController.jumpTo(0);
      }
    }
  }

  @override
  void dispose() {
    _isScrolling = false;
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.children.isEmpty) return const SizedBox.shrink();
    
    return IgnorePointer(
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10000, // Large number to simulate infinite loop
        separatorBuilder: (context, index) => SizedBox(
          width: widget.scrollDirection == Axis.horizontal ? widget.gap : 0,
          height: widget.scrollDirection == Axis.vertical ? widget.gap : 0,
        ),
        itemBuilder: (context, index) {
          int actualIndex = index % widget.children.length;
          return widget.children[actualIndex];
        },
      ),
    );
  }
}
