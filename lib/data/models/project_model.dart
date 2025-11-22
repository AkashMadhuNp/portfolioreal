import '../../domain/entities/project.dart';

class ProjectModel {
  static List<Project> getSampleProjects() {
    return [
      const Project(
        id: '1',
        title: 'Connect',
        description:
            'A simple, smart, and fast task-management app built to help you stay organized every day. '
            'With reminders, event marking, and a clean yellow-themed UI, Connect keeps your goals clear and your routine stress-free. '
            'Designed with Hive local storage and smooth user experience in mind.',
        technologies: ['Flutter', 'Dart', 'Hive', 'intl', 'Shared Preferences'],
        imageUrl: 'assets/images/connect.png',
        githubUrl: 'https://github.com/AkashMadhuNp/Connect',
        liveUrl: null,
        category: 'Productivity',
        isFeatured: true,
      ),
      const Project(
        id: '2',
        title: 'Refine Spot',
        description:
            'A complete multi-role salon appointment booking ecosystem built using Flutter. '
            'Showcases how users, salon owners, and administrators can interact within a unified digital platform. '
            'Streamlines salon discovery, booking, payments, and management with powerful backend integrations.',
        technologies: ['Flutter', 'Firebase', 'Cloudinary', 'OpenStreetMap', 'Stripe', 'Geolocator'],
        imageUrl: 'assets/images/Refine.png',
        githubUrl: null, // Multiple repos, handled in detail view
        liveUrl: null, // Multiple URLs, handled in detail view
        category: 'Multi-App Ecosystem',
        isFeatured: true,
      ),
    ];
  }
}

