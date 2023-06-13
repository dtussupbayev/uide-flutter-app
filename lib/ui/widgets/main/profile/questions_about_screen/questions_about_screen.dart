import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/ui/widgets/main/profile/questions_about_screen/questions_data.dart';

class QuestionsAboutScreen extends StatelessWidget {
  const QuestionsAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      decoration: kMainBackgroundGradientDecoration,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          appBar: const QuestionsAboutAppBarWidget(),
          extendBody: true,
          backgroundColor: ProjectColors.kTransparent,
          body: SizedBox(
            height: MediaQuery.of(context).size.height * 0.76,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 60.0,
              ),
              itemCount: questionAnswers.length,
              itemBuilder: (BuildContext context, int index) {
                return QuestionTile(
                  question: questionAnswers[index].question,
                  answer: questionAnswers[index].answer,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionsAboutAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const QuestionsAboutAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,
      centerTitle: true,
      elevation: 0,
      title: const Text(
        'Вопросы про Uide',
        style: TextStyle(
          letterSpacing: 0.5,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: ProjectColors.kTransparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}

class QuestionTile extends StatefulWidget {
  final String question;
  final String answer;

  const QuestionTile({super.key, required this.question, required this.answer});

  @override
  State<QuestionTile> createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        collapsedBackgroundColor: Colors.grey[200],
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
              right: 16.0,
              left: 16.0,
            ),
            child: Text(widget.answer),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            expanded = expanded;
          });
        },
      ),
    );
  }
}
