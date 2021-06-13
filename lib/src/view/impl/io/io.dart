import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webviewx/src/controller/interface.dart';
import 'package:webviewx/src/utils/utils.dart';
import 'package:webviewx/src/view/impl/io/mobile.dart' as mobile;

/// IO implementation
///
/// This will build the correct widget for the current platform, if available.
class WebViewXWidget extends StatefulWidget {
  /// Initial content
  final String initialContent;

  /// Initial source type. Must match [initialContent]'s type.
  ///
  /// Example:
  /// If you set [initialContent] to '<p>hi</p>', then you should
  /// also set the [initialSourceType] accordingly, that is [SourceType.HTML].
  final SourceType initialSourceType;

  /// User-agent
  /// On web, this is only used when using [SourceType.URL_BYPASS]
  final String? userAgent;

  /// Widget width
  final double? width;

  /// Widget height
  final double? height;

  /// Callback which returns a referrence to the [WebViewXController]
  /// being created.
  final Function(IWebViewXController controller)? onWebViewCreated;

  /// A set of [EmbeddedJsContent].
  ///
  /// You can define JS functions, which will be embedded into
  /// the HTML source (won't do anything on URL) and you can later call them
  /// using the controller.
  ///
  /// For more info, see [EmbeddedJsContent].
  final Set<EmbeddedJsContent> jsContent;

  /// A set of [DartCallback].
  ///
  /// You can define Dart functions, which can be called from the JS side.
  ///
  /// For more info, see [DartCallback].
  final Set<DartCallback> dartCallBacks;

  /// Boolean value to specify if should ignore all gestures that touch the webview.
  ///
  /// You can change this later from the controller.
  final bool ignoreAllGestures;

  /// Boolean value to specify if Javascript execution should be allowed inside the webview
  final JavascriptMode javascriptMode;

  /// This defines if media content(audio - video) should
  /// auto play when entering the page.
  final AutoMediaPlaybackPolicy initialMediaPlaybackPolicy;

  /// Callback for when the page starts loading.
  final void Function(String src)? onPageStarted;

  /// Callback for when the page has finished loading (i.e. is shown on screen).
  final void Function(String src)? onPageFinished;

  /// Callback for when something goes wrong in while page or resources load.
  final void Function(WebResourceError error)? onWebResourceError;

  /// Parameters specific to the web version.
  /// This may eventually be merged with [mobileSpecificParams],
  /// if all features become cross platform.
  final WebSpecificParams webSpecificParams;

  /// Parameters specific to the web version.
  /// This may eventually be merged with [webSpecificParams],
  /// if all features become cross platform.
  final MobileSpecificParams mobileSpecificParams;

  /// Constructor
  WebViewXWidget({
    Key? key,
    this.initialContent = 'about:blank',
    this.initialSourceType = SourceType.URL,
    this.userAgent,
    this.width,
    this.height,
    this.onWebViewCreated,
    this.jsContent = const {},
    this.dartCallBacks = const {},
    this.ignoreAllGestures = false,
    this.javascriptMode = JavascriptMode.unrestricted,
    this.initialMediaPlaybackPolicy =
        AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
    this.onPageStarted,
    this.onPageFinished,
    this.onWebResourceError,
    this.webSpecificParams = const WebSpecificParams(),
    this.mobileSpecificParams = const MobileSpecificParams(),
  }) : super(key: key);

  @override
  _WebViewXWidgetState createState() => _WebViewXWidgetState();
}

class _WebViewXWidgetState extends State<WebViewXWidget> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return mobile.WebViewXWidget(
        key: widget.key,
        initialContent: widget.initialContent,
        initialSourceType: widget.initialSourceType,
        userAgent: widget.userAgent,
        width: widget.width,
        height: widget.height,
        dartCallBacks: widget.dartCallBacks,
        jsContent: widget.jsContent,
        onWebViewCreated: widget.onWebViewCreated,
        ignoreAllGestures: widget.ignoreAllGestures,
        javascriptMode: widget.javascriptMode,
        initialMediaPlaybackPolicy: widget.initialMediaPlaybackPolicy,
        onPageStarted: widget.onPageStarted,
        onPageFinished: widget.onPageFinished,
        onWebResourceError: widget.onWebResourceError,
        webSpecificParams: widget.webSpecificParams,
        mobileSpecificParams: widget.mobileSpecificParams,
      );
    } else {
      throw UnimplementedError(
        'WebViewX (IO version) is not yet implemented for the current platform (${Platform.operatingSystem}).',
      );
    }
  }
}
