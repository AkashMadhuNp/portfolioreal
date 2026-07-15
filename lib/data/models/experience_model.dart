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
        responsibilities: [
          'Developing and maintaining scalable Flutter applications.',
          'Collaborating with cross-functional teams to define, design, and ship new features.',
          'Ensuring application performance, code quality, and responsiveness.',
        ],
        logoUrl: 'assets/images/emilo.jpg',
      ),
      Experience(
        id: '2',
        company: 'DimensionLeap',
        position: 'Associate Flutter Developer',
        duration: 'Sep 2025 - Jun 2026',
        location: 'India',
        isCurrent: false,
        responsibilities: [
          'Engineered Spotlight, an AI-powered filmmaking platform automating story generation, storyboard visualization, video editing, and pitch deck creation.',
          'Built a custom timeline-based video editor with real-time rendering and FFmpeg-powered exports using JavaScript Interop for Spotlight.',
          'Developed an immersive digital book-reading experience with dynamic pagination and realistic 3D page-turn animations.',
          'Contributed to a comprehensive Healthcare Management Platform serving Patients, Doctors, Clinics, Pharmacies, Staff, and Super Admins across web and mobile apps.',
          'Developed pharmacy product management, tax calculation modules, and clinic management features including a custom before-after image slider.',
          'Integrated Agora SDK for secure video consultations and implemented robust clinic/pharmacy onboarding workflows in the Super Admin portal.',
          'Utilized Flutter, Firebase, Hive, Razorpay, Clean Architecture, and Provider for scalable state management across production applications.',
        ],
        logoUrl: 'assets/images/dimensionlogo.jpeg',
      ),
      Experience(
        id: '3',
        company: 'Brototype',
        position: 'Flutter Developer Student',
        duration: 'Jun 2024 - Jul 2025',
        location: 'Remote',
        isCurrent: false,
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
        certificateUrl: 'https://brocamp.brototype.com/portfolio?id=509df9fe-1847-433b-a6b5-5f1b2a1269a2',
        logoUrl: 'assets/images/brototype logo.png',
      ),
    ];
  }
}

