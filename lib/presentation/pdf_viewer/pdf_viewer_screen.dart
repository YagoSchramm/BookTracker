import 'package:book_tracker/presentation/pdf_viewer/pdf_viewer_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';

import 'package:book_tracker/entities/book.dart';

class PdfViewerScreen extends StatelessWidget {
  final Book book;
  const PdfViewerScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PdfViewerState(book: book),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Consumer<PdfViewerState>(
          builder: (context, state, child) {
            return Stack(
              children: [
                PdfView(
                  controller: state.pdfController,
                  backgroundDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  builders: PdfViewBuilders<DefaultBuilderOptions>(
                    options: const DefaultBuilderOptions(),
                    pageBuilder: (context, pageImage, index, document) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: PdfPageImageProvider(
                          pageImage,
                          index,
                          document.id,
                        ),
                        minScale: PhotoViewComputedScale.contained * 0.5,
                        initialScale: PhotoViewComputedScale.contained * 1.2,
                        maxScale: PhotoViewComputedScale.contained * 3.0,
                        heroAttributes: PhotoViewHeroAttributes(
                          tag: '${document.id}-$index',
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .inverseSurface
                            .withValues(alpha: .85),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                             CupertinoIcons.chevron_back,
                              color: Theme.of(context).colorScheme.onInverseSurface,
                            ),
                            onPressed: state.previousPage,
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: state.pdfController.pageListenable,
                            builder: (context, currentPage, child) {
                              return Text(
                                '$currentPage/${state.pdfController.pagesCount ?? 0}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onInverseSurface,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              CupertinoIcons.chevron_forward,
                              color: Theme.of(context).colorScheme.onInverseSurface,
                            ),
                            onPressed: state.nextPage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}