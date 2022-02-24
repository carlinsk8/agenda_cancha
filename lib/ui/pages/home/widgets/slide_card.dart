import 'package:flutter/material.dart';

import 'package:agenda_cancha/domain/entities/cancha.dart';

class SlideCard extends StatefulWidget {
  final List<Cancha>? canchas;
  final String? title;
  final Function? onNextPage;

  const SlideCard({
    Key? key,
    required this.canchas,
    this.onNextPage,
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

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        //widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.canchas!.length,
                itemBuilder: (_, int index) => _CanchaPoster(
                    widget.canchas![index],
                    '${widget.title}-$index-${widget.canchas![index].id}')),
          ),
        ],
      ),
    );
  }
}

class _CanchaPoster extends StatelessWidget {
  final Cancha cancha;
  final String heroId;

  const _CanchaPoster(this.cancha, this.heroId);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 190,
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
                  width: 200,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            cancha.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
