import '../../domain/entities/experience.dart';

class ExperienceModel {
  static List<Experience> getExperiences() {
    return const [
      Experience(
        id: '1',
        company: 'DimensionLeap',
        position: 'Associate Flutter Developer',
        duration: 'Sep 2025 - Present',
        location: 'India',
        isCurrent: true,
        responsibilities: [],
        logoUrl: 'assets/images/dimensionlogo.jpeg',
      ),
      Experience(
        id: '2',
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
      ),
    ];
  }
}

