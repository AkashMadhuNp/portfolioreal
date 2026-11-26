import '../../domain/entities/case_study.dart';

/// Case-study content for each featured project, keyed by [Project.id].
///
/// Everything here is condensed or reframed from the project descriptions,
/// feature lists and experience bullets already on the site. There are no
/// invented metrics: where no number is documented, "results" state what was
/// delivered. Add real outcomes (users, performance gains) to `results` as
/// they become available.
class CaseStudyModel {
  static CaseStudy? forProject(String projectId) {
    for (final study in all()) {
      if (study.projectId == projectId) return study;
    }
    return null;
  }

  static List<CaseStudy> all() {
    return const [_spotlight, _healthcare, _connect, _refineSpot];
  }

  // ── Spotlight ───────────────────────────────────────────────────────────

  static const _spotlight = CaseStudy(
    projectId: '3',
    subtitle: 'AI-Powered Filmmaking & Storytelling Platform',
    tagline:
        'Takes a story idea to production-ready scripts, storyboards, videos and pitch decks in one automated workflow.',
    role: 'Flutter Developer · DimensionLeap',
    problem:
        'Spotlight collapses the path from a story idea to production-ready scripts, storyboards, video and pitch decks into a single automated workflow, so a filmmaker can move from concept to a presentable pitch inside one product.',
    contribution: [
      'Engineered the Flutter application behind story generation, storyboard visualization, video editing and pitch-deck creation.',
      'Built the custom timeline-based video editor with real-time rendering and FFmpeg-powered exports through JavaScript Interop.',
      'Developed an immersive digital book-reading experience with dynamic pagination and realistic 3D page-turn animations.',
    ],
    architecture: [
      'Modular Flutter application using Clean Architecture, with Provider for state management and GetIt for dependency injection.',
      'FFmpeg-based video rendering runs through JavaScript Interop, bridging Flutter with web-based media processing.',
      'Firebase Authentication and Google Sign-In, REST API integration and secure local storage (Hive, Shared Preferences).',
    ],
    decisions: [
      'A timeline model with separate video, audio, image and text layers, with real-time preview rendering at 30 FPS.',
      'Export and rendering run asynchronously with background status polling and cross-platform file handling.',
      'AI-generated characters, locations, props and cinematic scenes are managed through an asset system with optimized caching.',
    ],
    challenges: [
      CaseStudyChallenge(
        challenge: 'Rendering finished video from a Flutter app.',
        solution:
            'Integrated Flutter with web-based media processing through JavaScript Interop for FFmpeg-based rendering, with asynchronous export and background status polling.',
      ),
      CaseStudyChallenge(
        challenge: 'Keeping a multi-layer timeline editable and responsive.',
        solution:
            'Built a custom timeline supporting video, audio, image and text layers with real-time preview rendering at 30 FPS.',
      ),
      CaseStudyChallenge(
        challenge: 'Managing large volumes of AI-generated visual assets.',
        solution:
            'Added a visual asset management system for characters, locations, props and scenes, with optimized caching.',
      ),
      CaseStudyChallenge(
        challenge: 'Making long-form reading feel natural on screen.',
        solution:
            'Implemented dynamic pagination with realistic 3D page-turn animations.',
      ),
    ],
    results: [
      'Delivered the complete story → screenplay → storyboard → video → pitch-deck workflow as a single Flutter application.',
      'Shipped as a production company project at DimensionLeap, with a deployed environment you can open from the links below.',
    ],
    features: [
      'AI-driven story generation: loglines, beat sheets, synopses, character profiles and complete screenplay drafts',
      'Immersive digital book-reading experience with dynamic pagination and realistic 3D page-turn animations',
      'Visual asset management for AI-generated characters, locations, props and cinematic scenes, with optimized caching',
      'Custom timeline-based video editor with video, audio, image and text layers and real-time preview rendering at 30 FPS',
      'FFmpeg-based video rendering via JavaScript Interop',
      'Asynchronous export and rendering with background status polling and cross-platform file handling',
      'Automated storyboard generation, cinematic shot visualization and AI-assisted prompt engineering',
      'Industry-standard pitch-deck generation, exporting multi-slide investor presentations as PDF',
      'Firebase Authentication, Google Sign-In, REST APIs and secure local storage',
    ],
    links: [
      CaseStudyLink(
        label: 'Live app',
        url: 'https://dev-spotlight.storygenartist.com/login',
        kind: 'live',
      ),
      CaseStudyLink(
        label: 'Video walkthrough',
        url: 'https://youtu.be/Jn8dahpo3N8?si=JlZS5TkmwvS3RyGW',
        kind: 'video',
      ),
    ],
  );

  // ── Healthcare ──────────────────────────────────────────────────────────

  static const _healthcare = CaseStudy(
    projectId: '4',
    subtitle: 'Multi-role Healthcare Ecosystem',
    tagline:
        'One platform serving patients, doctors, clinics, pharmacies, staff and super admins across web and mobile.',
    role: 'Flutter Developer · DimensionLeap',
    problem:
        'A healthcare organisation needs one connected system for six very different groups (patients, doctors, clinics, pharmacies, staff and super admins), each with its own workflows, on both web and mobile.',
    contribution: [
      'Built pharmacy product management and tax calculation modules.',
      'Implemented clinic management features, including a custom before/after image comparison slider.',
      'Integrated Agora-powered video consultations and treatment-plan functionality for doctors.',
      'Built clinic and pharmacy registration and onboarding workflows in the Super Admin portal.',
    ],
    architecture: [
      'Role-based access control across mobile and web, serving six distinct stakeholder roles.',
      'Separate role-focused web apps (Pharmacy, Clinic, Doctor, Super Admin) alongside the mobile apps.',
      'Flutter with Clean Architecture and Provider state management; Firebase, Hive and REST APIs for data and local storage.',
    ],
    decisions: [
      'Agora SDK for secure video consultations between doctors and patients.',
      'Razorpay for payments, Hive and Shared Preferences for local persistence.',
      'A dedicated Super Admin portal for service management, clinic registration and pharmacy onboarding.',
    ],
    challenges: [
      CaseStudyChallenge(
        challenge: 'Letting clinics present before-and-after results visually.',
        solution:
            'Built a custom before/after image comparison slider for clinic workflows.',
      ),
      CaseStudyChallenge(
        challenge: 'Accurate pricing and billing for pharmacies.',
        solution:
            'Developed product management, tax calculation, billing, inventory and order management workflows.',
      ),
      CaseStudyChallenge(
        challenge: 'Remote consultations that are secure and reliable.',
        solution:
            'Integrated the Agora SDK for video consultations, with treatment-plan management for doctors.',
      ),
    ],
    results: [
      'Delivered modules across the Pharmacy, Clinic, Doctor and Super Admin web apps for a platform serving six stakeholder roles.',
      'Worked on a production company project at DimensionLeap. The product is not publicly accessible, so no demo link is available.',
    ],
    features: [
      'Pharmacy Web App: product management, tax calculation, billing, inventory and order management',
      'Clinic Web App: custom before/after image comparison slider and enhanced clinic workflows',
      'Doctor Web App: Agora-based video consultation and treatment-plan management',
      'Super Admin Portal: service management, clinic registration and pharmacy onboarding',
      'Role-based access control across mobile and web for six stakeholder groups',
    ],
  );

  // ── Connect ─────────────────────────────────────────────────────────────

  static const _connect = CaseStudy(
    projectId: '1',
    subtitle: 'Task & Event Management App',
    tagline:
        'A clean, fast and intuitive way to organise everyday life, offline-first.',
    role: 'Personal project · Brototype',
    problem:
        'A task manager that stays fast and usable without a network: planning, reminders and event tracking in a clean interface, with data kept on the device.',
    contribution: [
      'Designed and built the complete application as a demo project during the Brototype Flutter program.',
      'Implemented the task and event flows, local notifications, gesture actions and login persistence.',
    ],
    architecture: [
      'Hive local storage for fast, secure offline data handling.',
      'Shared Preferences for persistent login sessions.',
      'intl for date and time formatting; local notifications for reminders and alerts.',
    ],
    decisions: [
      'Offline-first: all data lives in Hive on the device.',
      'Gesture-based edit and delete for quick task management.',
      'A visual progress bar to track task completion.',
    ],
    results: [
      'A working Android application with the full feature set below, available as an APK.',
      'Source code is public on GitHub.',
    ],
    features: [
      'Task and event management with a clean visual layout',
      'Hive-powered local storage for fast, secure offline data handling',
      'Shared Preferences for persistent login sessions',
      'Local notifications for reminders and alerts',
      'Save images as event memories',
      'Visual progress bar to track task completion',
      'Gesture actions (edit/delete) for task management',
    ],
    links: [
      CaseStudyLink(
        label: 'Source code',
        url: 'https://github.com/AkashMadhuNp/Connect',
        kind: 'github',
      ),
      CaseStudyLink(
        label: 'Download APK',
        url: 'https://apkpure.com/p/com.example.first_project_app',
        kind: 'apk',
      ),
    ],
  );

  // ── Refine Spot ─────────────────────────────────────────────────────────

  static const _refineSpot = CaseStudy(
    projectId: '2',
    subtitle: 'Salon Booking Ecosystem',
    tagline: 'A complete multi-role salon appointment booking platform.',
    role: 'Personal project · Brototype',
    problem:
        'Salon discovery, booking, payments and management usually live in separate places. Refine Spot connects customers, salon owners and administrators in one platform, each with an app suited to their role.',
    contribution: [
      'Built all three applications (User, Salon and Admin) as a demo project during the Brototype Flutter program.',
      'Integrated Firebase, Cloudinary, Stripe and OpenStreetMap across the apps.',
    ],
    architecture: [
      'Three separate Flutter applications: User, Salon and Admin.',
      'Firebase for authentication, real-time data and password recovery.',
      'Cloudinary for salon image storage; OpenStreetMap with Geolocator for navigation.',
    ],
    decisions: [
      'Stripe for secure online payments with dynamic confirmation.',
      'Deep linking and quick actions: WhatsApp chats and one-tap phone calls.',
      'A review and rating system after each appointment.',
    ],
    results: [
      'Three working applications covering the full booking lifecycle.',
      'Apps and admin panel are published; source repositories are public on GitHub.',
    ],
    features: [
      'Multi-role architecture: separate User, Salon and Admin applications',
      'Firebase integration: authentication, real-time data and password recovery',
      'Cloudinary media management for salon images',
      'Stripe payments with dynamic confirmation',
      'OpenStreetMap and Geolocator for salon navigation',
      'Deep linking and quick actions (WhatsApp, phone calls)',
      'Review and rating system after appointments',
      'Salon dashboard to track income, appointments and services',
      'Admin controls to verify salons and manage service categories',
    ],
    modules: [
      CaseStudyModule(
        name: 'User Application',
        links: [
          CaseStudyLink(
            label: 'APK',
            url: 'https://apkpure.net/refine-spot/com.example.sec_pro',
            kind: 'apk',
          ),
          CaseStudyLink(
            label: 'GitHub',
            url: 'https://github.com/AkashMadhuNp/refinespotuser',
            kind: 'github',
          ),
        ],
      ),
      CaseStudyModule(
        name: 'Salon Application',
        links: [
          CaseStudyLink(
            label: 'APK',
            url: 'https://apkpure.com/p/com.example.sec_pro_saloon_app',
            kind: 'apk',
          ),
          CaseStudyLink(
            label: 'GitHub',
            url: 'https://github.com/AkashMadhuNp/refinespot_saloon',
            kind: 'github',
          ),
        ],
      ),
      CaseStudyModule(
        name: 'Admin Panel',
        links: [
          CaseStudyLink(
            label: 'Live',
            url: 'https://secpro-8c421.web.app/',
            kind: 'live',
          ),
          CaseStudyLink(
            label: 'GitHub',
            url: 'https://github.com/AkashMadhuNp/refinespotadmin',
            kind: 'github',
          ),
        ],
      ),
    ],
  );
}
