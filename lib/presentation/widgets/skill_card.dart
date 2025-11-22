import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../domain/entities/skill.dart';
import '../../core/theme/app_colors.dart';

class SkillCard extends StatefulWidget {
  final Skill skill;
  final int index;

  const SkillCard({
    super.key,
    required this.skill,
    required this.index,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.skill.proficiency)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    // Start animation with delay based on index
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      delay: Duration(milliseconds: widget.index * 50),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.skill.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Text(
                        '${(_animation.value * 100).toInt()}%',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: _getColorForProficiency(_animation.value),
                              fontWeight: FontWeight.bold,
                            ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: _animation.value,
                      minHeight: 8,
                      backgroundColor:
                          Theme.of(context).colorScheme.surface.withOpacity(0.5),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getColorForProficiency(widget.skill.proficiency),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorForProficiency(double proficiency) {
    // 80% and above: Green
    if (proficiency >= 0.8) {
      return AppColors.success;
    } 
    // 60% - 79%: Yellow/Gold
    else if (proficiency >= 0.6) {
      return AppColors.warning;
    } 
    // Below 60%: Red
    else {
      return AppColors.error;
    }
  }
}

