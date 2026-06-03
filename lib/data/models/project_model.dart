import '../../domain/entities/project.dart';

class ProjectModel {
  static List<Project> getSampleProjects() {
    return [
      const Project(
        id: '3',
        title: 'Spotlight',
        description:
            'Developed a scalable Flutter application that automates story generation, screenplay creation, storyboard visualization, AI asset generation, video editing, and pitch deck creation. Engineered a custom timeline-based video editor with real-time rendering, FFmpeg-powered exports, and JavaScript Interop integration.',
        technologies: ['Flutter', 'Provider', 'Firebase', 'FFmpeg', 'JS Interop', 'REST APIs', 'Hive', 'Shared Preferences', 'Logger', 'Aptabase', 'Video Player', 'Audio Player', 'Razorpay'],
        imageUrl: 'assets/images/spotlightlogo.png',
        liveUrl: 'https://dev-spotlight.storygenartist.com/login',
        githubUrl: null,
        category: 'AI Platform',
        isFeatured: true,
        type: 'Company Project - Dimensionleap',
      ),
      const Project(
        id: '4',
        title: 'Healthcare Management Platform',
        description:
            'Contributed to the development of a multi-role Healthcare Management Platform supporting Patients, Doctors, Clinics, Pharmacies, Staff, and Super Admins across web and mobile applications. Developed pharmacy product and tax calculation modules, implemented clinic management features including a custom before-after image slider, integrated Agora-powered video consultations and treatment plan functionalities for doctors, and built clinic/pharmacy registration workflows in the Super Admin portal.',
        technologies: ['Flutter', 'Firebase', 'Hive', 'Shared Preferences', 'Agora SDK', 'Razorpay', 'Intl', 'REST APIs', 'Provider'],
        imageUrl: null,
        liveUrl: null,
        githubUrl: null,
        category: 'Health Eco System',
        isFeatured: true,
        type: 'Company Project - Dimensionleap',
      ),
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

