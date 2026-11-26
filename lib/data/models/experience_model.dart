import '../../domain/entities/experience.dart';

class ExperienceModel {
  static List<Experience> getExperiences() {
    return const [
      Experience(
        id: '1',
        company: 'Emilo Ventures Private Limited',
        position: 'Flutter Developer',
        duration: 'Jun 2026 - Present',
        location: 'Raipur',
        isCurrent: true,
        highlights: [
          'Built an animated-captions system for the in-app multi-track video editor: word-level transcript timing, a multi-script font registry (Latin, Devanagari, Malayalam, Telugu) and five caption animations.',
          'Extended the FFmpegKit export pipeline to render caption states as cancellable PNG sequences, reusing the preview\'s animation evaluator for editor-consistent output.',
          'Fixed a native Android master-clock race (Kotlin, Media3 ExoPlayer) that resumed playback at the wrong position during fast timeline scrubbing.',
          'Reworked feed music and media-visibility arbitration so only the dominant post owns audio, and verified it on a physical device.',
          'Built real-time support-ticket chat (Socket.IO, BLoC) and socket-driven forced logout across devices.',
          'Core contributor to the Business Page module (87 commits); wrote 47 unit and widget test files.',
        ],
        responsibilities: [
          'Built an animated-captions system for the in-app multi-track video editor (Flutter, BLoC, Clean Architecture): a transcript chunker with word-level timing, a Unicode text audit, a multi-script font registry (Latin, Devanagari, Malayalam, Telugu) and five caption animations (Fade, Pop, Slide, Typewriter, Word-by-word).',
          'Extended the FFmpeg (FFmpegKit) export pipeline to render caption states as bounded PNG sequences (ffconcat inputs, cancellable capture), reusing the preview\'s animation evaluator and caption widget for editor-consistent output.',
          'Fixed a native Android master-clock race (Kotlin, Media3 ExoPlayer) where stale seek listeners resumed playback at the wrong position during fast timeline scrubbing; added generation-token and listener-identity gating, plus latest-wins seek queueing in the BLoC.',
          'Reworked feed music and media-visibility arbitration (VisibilityBloc) so only the dominant post owns audio (70% dominance / 30% release thresholds) and verified it on a physical device; also fixed carousel music visibility (with a test), Create Post audio bleed and Best Clip music delay.',
          'Built real-time support-ticket chat for Soft Corner over Socket.IO and BLoC: paginated history, send with retry, typing indicators, ticket status events, resolve/close, feedback and attachments; added business-notification socket events.',
          'Implemented socket-driven forced logout for "Log out of all devices" (session-revoked event handled across the socket service and AuthBloc), device-tested against a fake Socket.IO server.',
          'Core contributor to the Business Page module (87 commits): analytics with date filters, events with invite accept/reject and weekly/monthly schedules, follow/unfollow interactions, search, notifications and light/dark theming.',
          'Built the Invite and Follow Contacts flow (contact sync in 50-record chunks, country-code normalization, find-people with QR) and fixed Android Flix deep links to open the exact shared video.',
          'Wrote 47 unit and widget test files (caption pipeline, animation, export, music visibility); worked within Git workflows, code reviews, sprint planning and CI/CD pipelines using Jira.',
        ],
        logoUrl: 'assets/images/emilo.webp',
      ),
      Experience(
        id: '2',
        company: 'DimensionLeap',
        position: 'Associate Flutter Developer',
        duration: 'Sep 2025 - Jun 2026',
        location: 'India',
        isCurrent: false,
        highlights: [
          'Engineered Spotlight, an AI-powered filmmaking platform: story generation, storyboard visualization, video editing and pitch-deck creation.',
          'Built Spotlight\'s custom timeline video editor with real-time rendering and FFmpeg-powered exports through JavaScript Interop.',
          'Developed an immersive book-reading experience with dynamic pagination and 3D page-turn animations.',
          'Contributed to a multi-role Healthcare Management Platform serving six stakeholder groups across web and mobile.',
          'Built pharmacy product and tax modules, a custom before/after image slider and clinic/pharmacy onboarding workflows.',
          'Integrated the Agora SDK for secure video consultations.',
          'Applied Clean Architecture, Provider, Firebase, Hive and Razorpay across production applications.',
        ],
        responsibilities: [
          'Engineered Spotlight, an AI-powered filmmaking platform automating story generation, storyboard visualization, video editing, and pitch deck creation.',
          'Built a custom timeline-based video editor with real-time rendering and FFmpeg-powered exports using JavaScript Interop for Spotlight.',
          'Developed an immersive digital book-reading experience with dynamic pagination and realistic 3D page-turn animations.',
          'Contributed to a comprehensive Healthcare Management Platform serving Patients, Doctors, Clinics, Pharmacies, Staff, and Super Admins across web and mobile apps.',
          'Developed pharmacy product management, tax calculation modules, and clinic management features including a custom before-after image slider.',
          'Integrated Agora SDK for secure video consultations and implemented robust clinic/pharmacy onboarding workflows in the Super Admin portal.',
          'Utilized Flutter, Firebase, Hive, Razorpay, Clean Architecture, and Provider for scalable state management across production applications.',
        ],
        logoUrl: 'assets/images/dimensionlogo.webp',
      ),
      Experience(
        id: '3',
        company: 'Brototype',
        position: 'Flutter Developer Student',
        duration: 'Jun 2024 - Jul 2025',
        location: 'Remote',
        isCurrent: false,
        highlights: [
          'Completed an intensive full-time Flutter development program.',
          'Built two complete applications: Connect (task and event manager) and Refine Spot (multi-role salon booking).',
          'Practiced end-to-end delivery: UI/UX, state management, authentication, databases, debugging and deployment.',
          'Worked with Hive, Firebase, Cloudinary, OpenStreetMap and Stripe; used Git and GitHub for collaboration.',
        ],
        responsibilities: [
          'Completed an intensive full-time Flutter development program at Brototype',
          'Built two complete demo applications: Connect (task & event manager) and Refine Spot (multi-role salon booking system)',
          'Gained hands-on experience in building production-style UIs, local storage, API integrations, and real-time features',
          'Strengthened understanding of Flutter architecture, state management, authentication flows, and database systems',
          'Practiced end-to-end development: planning, UI/UX, feature implementation, debugging, optimization, and deployment',
          'Explored Flutter ecosystem deeply, including Hive, Firebase, Cloudinary, OpenStreetMap, and Stripe',
          'Learned version control and collaborative workflows using Git & GitHub',
          'Completed Brototype internship tasks, improving practical problem-solving and project delivery skills',
        ],
        certificateUrl:
            'https://brocamp.brototype.com/portfolio?id=509df9fe-1847-433b-a6b5-5f1b2a1269a2',
        logoUrl: 'assets/images/brototype logo.webp',
      ),
    ];
  }
}
