import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//loading indicator code is a modified and simplified version of this code
//https://github.com/fayaz07/ots

final _tKey = GlobalKey(debugLabel: 'overlay_parent');

/// Updates with the latest [OverlayEntry] child
late OverlayEntry _loaderEntry;

/// is dark theme
bool isDarkTheme = false;

/// To keep track if the [Overlay] is shown
bool _loaderShown = false;

class Loading extends StatelessWidget {
  const Loading({Key? key, this.child, this.darkTheme = false})
      : super(key: key);

  final Widget? child;
  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    isDarkTheme = darkTheme;
    return SizedBox(
      key: _tKey,
      child: child,
    );
  }
}

OverlayState? get _overlayState {
  final context = _tKey.currentContext;
  if (context == null) return null;

  NavigatorState? navigator;

  void visitor(Element element) {
    if (navigator != null) return;

    if (element.widget is Navigator) {
      navigator = (element as StatefulElement).state as NavigatorState;
    } else {
      element.visitChildElements(visitor);
    }
  }

  // ignore: unused_element
  context.visitChildElements(visitor);

  assert(navigator != null, '''unable to show overlay''');
  return navigator!.overlay;
}

/// To handle a loader for the application
Future<void> showLoadingIndicator({
  bool isModal = true,
  Color? modalColor,
}) async {
  try {
    Logger().e('Showing loading overlay');
    const _child = Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(),
      ),
    );
    await _showOverlay(
      child: isModal
          ? Stack(
              children: <Widget>[
                ModalBarrier(
                  color: modalColor,
                ),
                _child
              ],
            )
          : _child,
    );
  } catch (e) {
    Logger().e('Exception showing loading overlay\n${e.toString()}');
    rethrow;
  }
}

Future<void> hideLoadingIndicator() async {
  try {
    Logger().e('Hiding loading overlay');
    await _hideOverlay();
  } catch (err) {
    Logger().e('Exception hiding loading overlay');
    rethrow;
  }
}

///----------------------------------------------------------------------------
/// These methods deal with showing and hiding the overlay
Future<void> _showOverlay({required Widget child}) async {
  try {
    final overlay = _overlayState;

    if (_loaderShown) {
      Logger().e('An overlay is already showing');
      Future.value(false);
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => child,
    );

    overlay?.insert(overlayEntry);
    _loaderEntry = overlayEntry;
    _loaderShown = true;
  } catch (e) {
    Logger().e('Exception inserting loading overlay\n${e.toString()}');
    rethrow;
  }
}

Future<void> _hideOverlay() async {
  try {
    _loaderEntry.remove();
    _loaderShown = false;
  } catch (e) {
    Logger().e('Exception removing loading overlay\n${e.toString()}');
    rethrow;
  }
}
