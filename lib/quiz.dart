import 'package:flutter/material.dart';
import 'registration.dart'; // Import UserData (for saving score)
import 'results_screen.dart'; // Import the ResultsScreen

// --- DATA MODELS ---

class Question {
  final String text;
  final List<String> choices;
  final int correctAnswerIndex; // Index of the correct choice (0-3)

  const Question({
    required this.text,
    required this.choices,
    required this.correctAnswerIndex,
  });
}

// --- QUIZ DATA ---

final List<Question> quizQuestions = [
  // 1. Correct Answer: B (Index 1)
  Question(
    text: 'Yeah, what is this Diddy blud doing on the calculator, is blud Einstein? \n\nWhat is this Diddy blud doing on the calculator, is blud _______?',
    choices: ['A: Einstein', 'B: Eipstein', 'C: Aidan', 'D: Michael'],
    correctAnswerIndex: 1,
  ),
  // 2. Correct Answer: D (Index 3)
  Question(
    text: 'When will Diddy be released from prison?',
    choices: ['A: He was never imprisoned', 'B: January, 2035', 'C: December, 2025', 'D: May, 2028'],
    correctAnswerIndex: 3,
  ),
  // 3. Correct Answer: C (Index 2)
  Question(
    text: 'Which one of these jobs that can’t be replaced by AI?',
    choices: ['A: Receptionists', 'B: Translators', 'C: PS4 Repairman', 'D: Historians'],
    correctAnswerIndex: 2,
  ),
  // 4. Correct Answer: C (Index 2)
  Question(
    text: 'Which of these numbers is the most niche?',
    choices: ['A: 41', 'B: 67', 'C: 61', 'D: 69'],
    correctAnswerIndex: 2,
  ),
  // 5. Correct Answer: D (Index 3)
  Question(
    text: 'Which one is the most hyped game on the Xbox 50?',
    choices: ['A: Halo', 'B: Call of Duty', 'C: Fish Game', 'D: Bird Game 3'],
    correctAnswerIndex: 3,
  ),
  // 6. Correct Answer: B (Index 1)
  Question(
    text: 'Who is the Toughest?',
    choices: ['A: Dr Disrespect', 'B: Epstein', 'C: EDP 445', 'D: Diddy'],
    correctAnswerIndex: 1,
  ),
  // 7. Correct Answer: C (Index 2)
  Question(
    text: 'What is CP as in Basketball term?',
    choices: ['A: Court Presence', 'B: Career Points', 'C: Chris Paul', 'D: Clutch Passer'],
    correctAnswerIndex: 2,
  ),
  // 8. Correct Answer: C (Index 2)
  Question(
    text: 'Epstein owned a private island in the U.S. Virgin Islands that became famous. What is the official name given to this island?',
    choices: ['A: Tortuga Key', 'B: Eipstein Island', 'C: Little St. James', 'D: Calypso Cay'],
    correctAnswerIndex: 2,
  ),
  // 9. Correct Answer: C (Index 2)
  Question(
    text: 'Who owns the Codex Leicester?',
    choices: ['A: Jeff Bezos', 'B: Elon Musk', 'C: Bill Gates', 'D: Donald Trump'],
    correctAnswerIndex: 2,
  ),
  // 10. Correct Answer: C (Index 2)
  Question(
    text: 'The name of the seventh month, July, is named after ______.',
    choices: ['A: Julian Decimus', 'B: Marcus Julius', 'C: Gaius Julius Caesar', 'D: Quintus Julyus'],
    correctAnswerIndex: 2,
  ),
];


// --- QUIZ SCREEN WIDGET ---

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  final Color _startColor = const Color(0xFF48006D);
  final Color _endColor = const Color(0xFF050067);
  final Color _nextButtonColor = const Color(0xFF2600FF);
  final Color _choiceDefaultColor = const Color(0xFF8A8A8A); // Gray
  final Color _choiceSelectedColor = const Color(0xFF209200); // Green

  int _currentQuestionIndex = 0;
  // Map to store user's answers: {questionIndex: selectedChoiceIndex}
  late Map<int, int> _userAnswers;

  // Animation for the question block (fades in)
  late AnimationController _questionController;
  late Animation<double> _questionOpacityAnimation;

  // Animation for the navigation button (fades in)
  late AnimationController _navButtonController;
  late Animation<double> _navButtonOpacityAnimation;


  @override
  void initState() {
    super.initState();

    _userAnswers = Map.fromIterable(
      List.generate(quizQuestions.length, (i) => i),
      key: (i) => i,
      value: (i) => -1, // -1 means no answer selected
    );

    // Controller for question fade-in animation
    _questionController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _questionOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _questionController, curve: Curves.easeIn),
    );

    // Controller for initial navigation button fade-in animation
    _navButtonController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _navButtonOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _navButtonController, curve: Curves.easeIn),
    );

    // Start the navigation button animation immediately
    _navButtonController.forward();

    // Fix for 'delay' error: Use Future.delayed to start question fade-in after a pause
    Future.delayed(const Duration(milliseconds: 500), () {
      if(mounted) {
        _questionController.forward();
      }
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    _navButtonController.dispose();
    super.dispose();
  }

  // --- NAVIGATION LOGIC ---

  void _goToNextQuestion() {
    // Check if the current question has been answered before moving on
    if (_userAnswers[_currentQuestionIndex] == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an answer first.')),
      );
      return;
    }

    if (_currentQuestionIndex < quizQuestions.length - 1) {
      _changeQuestion(1);
    } else {
      _showResultScreen();
    }
  }

  void _goToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      _changeQuestion(-1);
    }
  }

  void _changeQuestion(int delta) {
    // 1. Reverse the current question's animation (fade out)
    _questionController.reverse().then((_) {
      // 2. Change the state (question index)
      setState(() {
        _currentQuestionIndex += delta;
      });
      // 3. Start the forward animation for the new question (fade in)
      _questionController.forward();
    });
  }

  void _showResultScreen() {
    // 1. Calculate the final score
    int correctCount = 0;
    for (int i = 0; i < quizQuestions.length; i++) {
      if (_userAnswers[i] == quizQuestions[i].correctAnswerIndex) {
        correctCount++;
      }
    }

    // 2. Save the final score statically
    UserData.score = correctCount;

    // 3. Navigate to the results screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const ResultsScreen()),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildChoiceButton(int index, String choiceText) {
    final bool isSelected = _userAnswers[_currentQuestionIndex] == index;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            // Update the selected answer for the current question
            _userAnswers[_currentQuestionIndex] = index;
          });
        },
        style: ElevatedButton.styleFrom(
          // Use green if selected, otherwise use gray
          backgroundColor: isSelected ? _choiceSelectedColor : _choiceDefaultColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          elevation: 5,
          textStyle: const TextStyle(
            fontFamily: 'DoHyeon',
            fontSize: 18,
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(choiceText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = quizQuestions[_currentQuestionIndex];
    final isFirstQuestion = _currentQuestionIndex == 0;
    final isLastQuestion = _currentQuestionIndex == quizQuestions.length - 1;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          // Gradient Background
          gradient: LinearGradient(
            colors: [_startColor, _endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Spacer for top area
            const SizedBox(height: 50),

            // Question Content Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: FadeTransition(
                  opacity: _questionOpacityAnimation,
                  child: SingleChildScrollView( // Allows scrolling if question is long
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        // Custom gradient with low opacity white layers
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.2), // 20% opacity
                            Colors.white.withOpacity(0.1), // 10% opacity
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Question Text
                          Text(
                            '${_currentQuestionIndex + 1}. ${currentQuestion.text}',
                            style: const TextStyle(
                              fontFamily: 'DoHyeon',
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Choices
                          ...currentQuestion.choices.asMap().entries.map((entry) {
                            return _buildChoiceButton(entry.key, entry.value);
                          }).toList(),

                          const SizedBox(height: 20), // Padding below choices
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Navigation Bar (Buttons)
            FadeTransition(
              opacity: _navButtonOpacityAnimation,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button (Hidden on Question 1)
                    Opacity(
                      opacity: isFirstQuestion ? 0.0 : 1.0,
                      child: Container(
                        width: 70,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isFirstQuestion ? null : _goToPreviousQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                    ),

                    // Next / Finish Button
                    Expanded(
                      child: Container(
                        height: 50,
                        margin: isFirstQuestion ? null : const EdgeInsets.only(left: 10),
                        child: ElevatedButton.icon(
                          onPressed: _goToNextQuestion,
                          icon: isLastQuestion
                              ? const SizedBox.shrink()
                              : const Icon(Icons.arrow_forward, color: Colors.white),
                          label: Text(
                            isLastQuestion ? 'Finish' : 'Next',
                            style: const TextStyle(
                              fontFamily: 'DoHyeon',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _nextButtonColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(horizontal: isLastQuestion ? 40 : 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
