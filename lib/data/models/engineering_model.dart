import '../../domain/entities/engineering_highlight.dart';

/// Engineering capabilities, each traceable to content in
/// [ExperienceModel] / [CaseStudyModel]. No metrics are invented; numbers that
/// appear (30 FPS, 70%/30%, 47 test files) are quoted from that content.
///
/// Items marked "brief" come from the owner's own description of their work
/// and have no further detail recorded in the repo; keep them at this level
/// until more is documented.
class EngineeringModel {
  static List<EngineeringHighlight> getHighlights() {
    return const [
      EngineeringHighlight(
        id: 'video-editor',
        title: 'Custom multi-track video editor',
        description:
            'Timeline editors with video, audio, image and text layers and real-time preview rendering at 30 FPS. At Emilo Ventures: an animated-captions system with word-level timing, a multi-script font registry (Latin, Devanagari, Malayalam, Telugu) and five caption animations.',
        context: 'Spotlight · Emilo Ventures',
        iconKey: 'editor',
        tags: ['Flutter', 'BLoC', 'Clean Architecture'],
      ),
      EngineeringHighlight(
        id: 'ffmpeg-export',
        title: 'FFmpeg-based export engine',
        description:
            'Spotlight renders video with FFmpeg through JavaScript Interop, with asynchronous export and background status polling. At Emilo: an FFmpegKit pipeline that renders caption states as cancellable PNG sequences, reusing the preview\'s animation evaluator for editor-consistent output.',
        context: 'DimensionLeap · Emilo Ventures',
        iconKey: 'export',
        tags: ['FFmpeg', 'FFmpegKit', 'JS Interop'],
      ),
      EngineeringHighlight(
        id: 'media-sync',
        title: 'Real-time rendering & media synchronization',
        description:
            'Fixed a native Android master-clock race where stale seek listeners resumed playback at the wrong position during fast timeline scrubbing, using generation-token and listener-identity gating plus latest-wins seek queueing in the BLoC.',
        context: 'Emilo Ventures',
        iconKey: 'sync',
        tags: ['Kotlin', 'Media3 ExoPlayer', 'BLoC'],
      ),
      EngineeringHighlight(
        id: 'playback',
        title: 'Playback optimization & HLS',
        description:
            'Reworked feed media arbitration (VisibilityBloc) so only the dominant post owns audio (70% dominance / 30% release thresholds), verified on a physical device. HLS streaming with a proxy and caching layer for video playback.',
        context: 'Emilo Ventures',
        iconKey: 'playback',
        tags: ['HLS', 'VisibilityBloc', 'Caching'],
      ),
      EngineeringHighlight(
        id: 'native-debugging',
        title: 'Android & iOS debugging',
        description:
            'Debugging platform-level media issues on Android and iOS, including root-causing a native Android playback race in Kotlin and Media3 ExoPlayer, and verifying fixes on physical devices.',
        context: 'Emilo Ventures',
        iconKey: 'debug',
        tags: ['Android', 'iOS', 'Kotlin'],
      ),
      EngineeringHighlight(
        id: 'architecture',
        title: 'Clean Architecture & scalable modules',
        description:
            'Modular Flutter applications built on Clean Architecture with BLoC or Provider and GetIt dependency injection, backed by 47 unit and widget test files covering the caption pipeline, animation, export and music visibility.',
        context: 'DimensionLeap · Emilo Ventures',
        iconKey: 'architecture',
        tags: ['Clean Architecture', 'GetIt', 'Testing'],
      ),
    ];
  }
}
