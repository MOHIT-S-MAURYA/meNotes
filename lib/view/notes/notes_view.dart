// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:menotes/enum/menu_action.dart';
import 'package:menotes/constants/routes.dart';
import 'package:menotes/services/auth/auth_service.dart';
import 'package:menotes/services/crud/notes_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _notesService = NotesService();
    _notesService.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Notes", style: TextStyle(color: Colors.white)),
        actions: [
          // add note icon
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(newNotesRoute);
            },
            icon: const Icon(Icons.add),
            color: Colors.white,
          ),

          // options menu - logout
          PopupMenuButton<MenuAction>(
            onSelected: (value) => _handleMenuSelection(context, value),
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                ),
              ];
            },
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _notesService.getOrCreateUser(email: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                stream: _notesService.allNotes,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      if (snapshot.hasData) {
                        final allNotes = snapshot.data as List<DatabaseNote>;
                        return ListView.builder(
                          itemCount: allNotes.length,
                          itemBuilder: (context, index) {
                            final note = allNotes[index];
                            return ListTile(
                              title: Text(
                                note.text,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                    default:
                      return const CircularProgressIndicator();
                  }
                },
              );

            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  void _handleMenuSelection(BuildContext context, MenuAction value) {
    switch (value) {
      case MenuAction.logout:
        _handleLogout(context);
        break;
      // Add more cases for other menu actions if needed
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final shouldLogout = await showLogOutDialog(context);
    if (shouldLogout) {
      await AuthService.firebase().logOut();
      Navigator.of(context).pushNamedAndRemoveUntil(
        loginRoute,
        (_) => false,
      );
    }
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Log out"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Log out"),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
