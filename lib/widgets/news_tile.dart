import 'package:aym_news/models/article_model.dart';
import 'package:aym_news/views/web_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// cached network image
class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.articleModel});

  final ArticleModel articleModel;
  @override
  Widget build(BuildContext context) {
    const String errorImage =
        'https://media4.s-nbcnews.com/i/newscms/2019_01/2705191/nbc-social-default_b6fa4fef0d31ca7e8bc7ff6d117ca9f4.png';

    //Navigate to Details Page
    void navigateToDetailsPage() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WebView(url: '${articleModel.url}'),
        ),
      );
    }

    return GestureDetector(
      onTap: () => navigateToDetailsPage(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: articleModel.image ?? errorImage,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            articleModel.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            articleModel.subTitle ?? '',
            maxLines: 2,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          )
        ],
      ),
    );
  }
}
