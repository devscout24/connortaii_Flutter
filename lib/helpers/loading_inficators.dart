import 'package:flutter/widgets.dart';


class BookLoadingLottieWidget extends StatelessWidget {
  const BookLoadingLottieWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: shimmer(
        context: context, ),
    );
  }
}
class LoadingLottieWidget extends StatelessWidget {
  const LoadingLottieWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: shimmer(
        context: context, ),
    );
  }
}

class DropLoadingLottieWidget extends StatelessWidget {
  const DropLoadingLottieWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: shimmer(
        context: context, ),
    );
  }
}

Widget shimmer({
  String? name,
  required BuildContext context,
  Color? color,
  double? size,
}) {
  return Center(
    child: Container(

    ),
  );
}

