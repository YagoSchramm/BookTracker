import 'package:book_tracker/presentation/add/add_book_state.dart';
import 'package:book_tracker/presentation/components/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookScreen extends StatelessWidget {
  const AddBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "BookTracker",
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
      ),
      body: Consumer<AddBookState>(
        builder: (context, state, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 8),

                Image.asset("assets/images/add_book_image.png", height: 180),

                const SizedBox(height: 12),

                Text(
                  "Add a new book",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Import a PDF and organize your reading library",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colors.inverseSurface, fontSize: 14),
                ),

                const SizedBox(height: 32),

                CustomTextField(
                  label: "TITLE",
                  controller: state.titleController,
                  hint: "Clean Code",
                ),

                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "PDF FILE",
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () async {
                      bool sucess = await state.pickPdf();
                      if (!context.mounted) return;

                      final IconData icone = sucess
                          ? CupertinoIcons.checkmark_alt_circle
                          : CupertinoIcons.clear_circled;
                      final Color corDeFundo = sucess
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.error;
                      final String mensagem = sucess
                          ? 'Pdf picked with succes!'
                          : 'An error ocurred.';

                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: corDeFundo,
                          content: Row(
                            children: [
                              Icon(
                                icone,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                mensagem,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.doc_fill, color: colors.primary),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              state.selectedPdfName.isEmpty
                                  ? "Choose a PDF file"
                                  : state.selectedPdfName,
                              style: TextStyle(color: colors.onSurface),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Icon(
                            CupertinoIcons.chevron_right,
                            size: 18,
                            color: colors.inverseSurface,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                GestureDetector(
                  onTap: () {
                    // criar livro
                  },
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: state.isLoading
                        ? CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.add,
                                size: 18,
                                color: colors.onPrimary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Create Book",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colors.onPrimary,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
