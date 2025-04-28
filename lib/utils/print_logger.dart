import 'package:logger/logger.dart';

Logger logger = Logger(
  // filter: DevelopmentFilter(), // Filter to show only development logs
  output: ConsoleOutput(),
  level: Level.fatal,
  printer: PrettyPrinter(

      // methodCount: 2, // Number of method calls to be displayed
      // errorMethodCount: 8, // Number of method calls if stacktrace is provided
      // lineLength: 120, // Width of the output
      // colors: true, // Colorful log messages
      // printEmojis: true, // Print an emoji for each log message
      // Should each log print contain a timestamp
      //dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
);

// logger.Level? loggerLevel = Level.warning;


  // Logger.level = Level.warning;

  // logger.t('Trace log');

  // logger.d('Debug log');

  // logger.i('Info log');

  // logger.w('Warning log');

  // logger.e('Error log', error: 'Test Error');

  // logger.f(
  //   'What a fatal log',
  // );