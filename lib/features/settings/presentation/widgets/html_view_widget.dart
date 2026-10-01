import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlViewWidget extends StatelessWidget {
  final String input;
  const HtmlViewWidget({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      input,
      onTapUrl: (String url) async {
        final Uri uri = Uri.parse(url);

        if (url.startsWith('mailto:')) {
          try {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
            return true;
          } catch (e) {
            debugPrint("Error launching mail: $e");
            return false;
          }
        }

        String formattedUrl = url;
        if (!url.startsWith('http')) {
          formattedUrl = 'https://$url';
        }

        final Uri webUri = Uri.parse(formattedUrl);
        if (await canLaunchUrl(webUri)) {
          await launchUrl(webUri, mode: LaunchMode.externalApplication);
          return true;
        }
        return false;
      },
      renderMode: RenderMode.column,
      customStylesBuilder: (element) {
        if (element.localName == 'img') {
          return {'max-width': '100%', 'height': 'auto'};
        }
        return null;
      },
      textStyle: TextFontStyle.headlinePoppins40014.copyWith(
        color: AppColors.c000000,
      ),
    );
  }
}

// class HtmlViewWidget extends StatelessWidget {
//   final String input;
//   const HtmlViewWidget({super.key, required this.input});

//   @override
//   Widget build(BuildContext context) {
//     return HtmlWidget(
//       ''' $input ''',
//       customStylesBuilder: (element) {
//         if (element.classes.contains('foo')) {
//           return {'color': 'red'};
//         }
//         return null;
//       },
//       customWidgetBuilder: (element) {
//         if (element.attributes['foo'] == 'bar') {
//           // render a custom widget that takes the full width
//         }
//         if (element.attributes['fizz'] == 'buzz') {
//           // render a custom widget that inlines with surrounding text
//         }
//         return null;
//       },
//       renderMode: RenderMode.column,
//       textStyle: TextFontStyle.headlinePoppins40012.copyWith(
//         color: AppColors.c000000,
//       ),
//     );
//   }
// }
