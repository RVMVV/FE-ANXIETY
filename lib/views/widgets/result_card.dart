import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screening_app/views/widgets/youtube_player.dart';

import '../../utils/constant_finals.dart';

class ResultCard extends StatefulWidget {
  const ResultCard({
    super.key,
    required this.screenWidth,
    required this.icon,
    required this.title,
    required this.emotion,
    required this.status,
    required this.score,
    this.youtubeUrls = const [],
    this.materiText,
  });
  final String icon;
  final String title;
  final String emotion;
  final String status;
  final double screenWidth;
  final String score;
  final List<String> youtubeUrls;
  final String? materiText;

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  int _currentVideoIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: widget.screenWidth,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: textColor.withAlpha(30),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          //top section
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: onahau,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(
                  child: SvgPicture.asset(widget.icon, width: 30, height: 30),
                ),
              ),
              SizedBox(width: 15),
              Text(
                widget.title,
                style: Styles.urbanistBold.copyWith(
                  color: textColor,
                  fontSize: 26,
                ),
              ),
            ],
          ),

          //emotion
          const SizedBox(height: 30),
          Image.asset(widget.emotion, width: 105, height: 105),
          const SizedBox(height: 15),
          Text(
            widget.status,
            style: Styles.urbanistBold.copyWith(
              color: primaryColor,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Skor ${widget.title} ${widget.score}',
            style: Styles.urbanistBold.copyWith(color: textColor, fontSize: 18),
          ),
          const SizedBox(height: 50),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Materi Edukasi',
              style: Styles.urbanistBold.copyWith(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (widget.youtubeUrls.isNotEmpty)
            Column(
              children: [
                YoutubeVideoPlayer(
                  key: ValueKey(widget.youtubeUrls[_currentVideoIndex]),
                  youtubeUrl: widget.youtubeUrls[_currentVideoIndex],
                ),
                if (widget.youtubeUrls.length > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed:
                            _currentVideoIndex > 0
                                ? () => setState(() => _currentVideoIndex--)
                                : null,
                      ),
                      Text(
                        '${_currentVideoIndex + 1} / ${widget.youtubeUrls.length}',
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed:
                            _currentVideoIndex < widget.youtubeUrls.length - 1
                                ? () => setState(() => _currentVideoIndex++)
                                : null,
                      ),
                    ],
                  ),
              ],
            ),
          if (widget.materiText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                widget.materiText!,
                style: Styles.urbanistRegular.copyWith(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
