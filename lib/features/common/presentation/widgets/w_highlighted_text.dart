import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

final int __int64MaxValue = double.maxFinite.toInt();

class HighlightedText extends StatelessWidget {
  const HighlightedText({
    required this.allText,
    this.caseSensitive = false,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.highlightedText,
    this.terms,
    this.textAlign = TextAlign.left,
    this.textStyle,
    this.textStyleHighlight,
    this.wordDelimiters = ' .,;?!<>[]~`@#\$%^&*()+-=|/_',
    this.words = false,
    this.highlightColor = AppColors.brightSun,
    super.key,
  }) : assert(highlightedText != null || terms != null);

  final bool caseSensitive;
  final TextOverflow overflow;
  final int? maxLines;
  final String? highlightedText;
  final List<String>? terms;
  final String allText;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final TextStyle? textStyleHighlight;
  final String wordDelimiters;
  final bool words;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    final String textLC = caseSensitive ? allText : allText.toLowerCase();
    // ignore: unnecessary_parenthesis
    final List<String> termList = [highlightedText ?? '', ...(terms ?? [])];
    final List<String> termListLC = termList.where((s) => s.isNotEmpty).map((s) => caseSensitive ? s : s.toLowerCase()).toList();
    List<InlineSpan> children = [];
    int start = 0;
    int idx = 0;
    while (idx < textLC.length) {
      nonHighlightAdd(int end) => children.add(TextSpan(text: allText.substring(start, end), style: textStyle ?? context.textTheme.headlineLarge));
      int iNearest = -1;
      int idxNearest = __int64MaxValue;
      for (int i = 0; i < termListLC.length; i++) {
        int at;
        if ((at = textLC.indexOf(termListLC[i], idx)) >= 0) {
          if (words) {
            if (at > 0 && !wordDelimiters.contains(textLC[at - 1])) {
              continue;
            }
            int followingIdx = at + termListLC[i].length;
            if (followingIdx < textLC.length && !wordDelimiters.contains(textLC[followingIdx])) {
              continue;
            }
          }
          if (at < idxNearest) {
            iNearest = i;
            idxNearest = at;
          }
        }
      }

      if (iNearest >= 0) {
        if (start < idxNearest) {
          nonHighlightAdd(idxNearest);
          start = idxNearest;
        }
        int termLen = termListLC[iNearest].length;
        children.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                allText.substring(start, idxNearest + termLen),
                style: textStyleHighlight ?? context.textTheme.headlineLarge,
                maxLines: maxLines,
                textAlign: textAlign,
                overflow: overflow,
              ),
            ),
          ),
        );
        start = idx = idxNearest + termLen;
      } else {
        if (words) {
          idx++;
          nonHighlightAdd(idx);
          start = idx;
        } else {
          nonHighlightAdd(textLC.length);
          break;
        }
      }
    }

    return RichText(
      maxLines: maxLines,
      overflow: overflow,
      text: TextSpan(
        children: children,
        style: textStyle,
      ),
      textAlign: textAlign,
      textScaler: MediaQuery.of(context).textScaler,
    );
  }
}
