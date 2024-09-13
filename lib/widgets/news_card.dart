import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

getNewsCard(e) {
  return Card(
    elevation: 1,
    margin: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      children: [
        //   image
        if (e['urlToImage'] != null) Image.network(e['urlToImage'].toString()),

        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 16.0,
            left: 8.0,
            right: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //   title || heading
                  Flexible(
                    child: Text(
                      e['title'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  // if (e['title'] != null) Text(e['title'].toString()),
                  const SizedBox(width: 5.0),
                  //   share
                  IconButton(
                      onPressed: () {
                        Share.share(e['url'].toString());
                      },
                      icon: const Icon(Icons.share)),
                ],
              ),

              const SizedBox(height: 10.0),

              //   short description
              if (e['description'] != null)
                Text(
                  e['description'].toString(),
                  style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                ),

              const SizedBox(height: 10.0),

              //   read more button
              InkWell(
                onTap: () {
                  _launchUrl(e["url"].toString());
                },
                child: const Text(
                  "Click here to read more...",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
