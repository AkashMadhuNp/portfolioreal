import '../../domain/entities/skill.dart';

class SkillModel {
  static List<Skill> getTechnicalSkills() {
    return const [
      Skill(name: 'Flutter', proficiency: 0.9, category: 'Mobile Development'),
      Skill(name: 'Dart', proficiency: 0.9, category: 'Programming Language'),
      Skill(name: 'Firebase', proficiency: 0.85, category: 'Backend'),
      Skill(name: 'REST APIs', proficiency: 0.85, category: 'Backend'),
      Skill(name: 'Provider', proficiency: 0.8, category: 'State Management'),
      Skill(name: 'Bloc', proficiency: 0.9, category: 'State Management'),
      Skill(name: 'GetX', proficiency: 0.8, category: 'State Management'),
      Skill(name: 'Git', proficiency: 0.85, category: 'Version Control'),
      Skill(name: 'Figma', proficiency: 0.8, category: 'Design'),
      Skill(name: 'Clean Architecture', proficiency: 0.75, category: 'Architecture'),
      Skill(name: 'MVP', proficiency: 0.85, category: 'Architecture'),
      Skill(name: 'MVVM', proficiency: 0.85, category: 'Architecture'),
      Skill(name: 'Responsive Design', proficiency: 0.9, category: 'Design'),
      Skill(name: 'Animations', proficiency: 0.85, category: 'UI'),
      Skill(name: 'Hive', proficiency: 0.85, category: 'Database'),
      Skill(name: 'SQL/NoSQL', proficiency: 0.7, category: 'Database'),
    ];
  }

  static List<Skill> getSoftSkills() {
    return const [
      Skill(name: 'Problem Solving', proficiency: 0.9, category: 'Soft Skills'),
      Skill(name: 'Team Collaboration', proficiency: 0.85, category: 'Soft Skills'),
      Skill(name: 'Communication', proficiency: 0.8, category: 'Soft Skills'),
      Skill(name: 'Time Management', proficiency: 0.85, category: 'Soft Skills'),
      Skill(name: 'Adaptability', proficiency: 0.9, category: 'Soft Skills'),
      Skill(name: 'Attention to Detail', proficiency: 0.85, category: 'Soft Skills'),
      Skill(name: 'Quick Learner', proficiency: 0.85, category: 'Soft Skills'),
    ];
  }
}

