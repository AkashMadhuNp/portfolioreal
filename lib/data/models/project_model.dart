import '../../domain/entities/project.dart';

class ProjectModel {
  /// Featured projects, in display order. Spotlight leads because of the
  /// depth of its media-engineering work.
  static List<Project> getSampleProjects() {
    return [
      const Project(
        id: '3',
        title: 'Spotlight',
        description:
            'Developed a scalable Flutter application that automates story generation, screenplay creation, storyboard visualization, AI asset generation, video editing, and pitch deck creation. Engineered a custom timeline-based video editor with real-time rendering, FFmpeg-powered exports, and JavaScript Interop integration.',
        summary:
            'An AI-powered filmmaking platform that takes a story idea to scripts, storyboards, video and pitch decks. I built its custom timeline video editor and the FFmpeg export pipeline.',
        technologies: [
          'Flutter',
          'Provider',
          'Firebase',
          'FFmpeg',
          'JS Interop',
          'REST APIs',
          'Hive',
          'Shared Preferences',
          'Logger',
          'Aptabase',
          'Video Player',
          'Audio Player',
          'Razorpay',
        ],
        highlightTags: [
          'Flutter',
          'FFmpeg',
          'JS Interop',
          'Provider',
          'Firebase',
          'Video Player',
        ],
        imageUrl: 'assets/images/spotlightlogo.webp',
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
        summary:
            'A multi-role healthcare platform for patients, doctors, clinics, pharmacies and admins across web and mobile. I built pharmacy and tax modules, a before/after image slider and Agora video consultations.',
        technologies: [
          'Flutter',
          'Firebase',
          'Hive',
          'Shared Preferences',
          'Agora SDK',
          'Razorpay',
          'Intl',
          'REST APIs',
          'Provider',
        ],
        highlightTags: [
          'Flutter',
          'Firebase',
          'Agora SDK',
          'Razorpay',
          'Hive',
          'Provider',
        ],
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
        summary:
            'An offline-first task and event manager with reminders, local notifications and progress tracking, built on Hive local storage.',
        technologies: ['Flutter', 'Dart', 'Hive', 'intl', 'Shared Preferences'],
        highlightTags: [
          'Flutter',
          'Dart',
          'Hive',
          'Shared Preferences',
          'intl',
        ],
        imageUrl: 'assets/images/connect.webp',
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
        summary:
            'A salon booking ecosystem of three Flutter apps (user, salon, admin) with Firebase, Stripe payments and OpenStreetMap-based navigation.',
        technologies: [
          'Flutter',
          'Firebase',
          'Cloudinary',
          'OpenStreetMap',
          'Stripe',
          'Geolocator',
        ],
        highlightTags: [
          'Flutter',
          'Firebase',
          'Stripe',
          'Cloudinary',
          'OpenStreetMap',
          'Geolocator',
        ],
        imageUrl: 'assets/images/Refine.webp',
        githubUrl: null, // Multiple repos, handled in the case study
        liveUrl: null, // Multiple URLs, handled in the case study
        category: 'Multi-App Ecosystem',
        isFeatured: true,
      ),
    ];
  }
}
