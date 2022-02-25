import 'package:agenda_cancha/ui/widgets/custom_title.dart';
import 'package:flutter/material.dart';

import '/domain/entities/cancha.dart';

class SlideCard extends StatefulWidget {
  final List<Cancha>? canchas;
  final String? title;

  const SlideCard({
    Key? key,
    required this.canchas,
    this.title,
  }) : super(key: key);

  @override
  _SlideCardState createState() => _SlideCardState();
}

class _SlideCardState extends State<SlideCard> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              itemCount: widget.canchas!.length,
              itemBuilder: (_, int index) => _CanchaPoster(
                widget.canchas![index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CanchaPoster extends StatelessWidget {
  final Cancha cancha;

  const _CanchaPoster(this.cancha);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 256,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'agenda', arguments: cancha),
            child: Hero(
              tag: cancha.imgUrl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: AssetImage(cancha.imgUrl),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          CustomTilte(title: cancha.name),
        ],
      ),
    );
  }
}
