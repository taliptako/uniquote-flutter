import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uniquote/widgets/bottom_loader.dart';
import 'package:uniquote/stores/profile_store.dart';
import 'package:uniquote/models/user_store.dart';
import 'package:uniquote/widgets/quote/quote_widget.dart';

class ProfileQuotes extends StatefulWidget {
  final UserStore user;
  final ScrollController scrollController;

  const ProfileQuotes({Key key, this.user, this.scrollController})
      : super(key: key);

  @override
  _ProfileQuotesState createState() => _ProfileQuotesState();
}

class _ProfileQuotesState extends State<ProfileQuotes> {
  final ProfileStore _profileStore = ProfileStore();

  @override
  void initState() {
    widget.scrollController.addListener(() async {
      final maxScroll = widget.scrollController.position.maxScrollExtent;
      if (maxScroll == widget.scrollController.position.pixels) {
        await _profileStore.fetch(widget.user.id);
      }
    });

    _profileStore.fetch(widget.user.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_profileStore.page == 1 && _profileStore.hasReachedEnd) {
        return SliverToBoxAdapter(
          child: Center(
            child: Text('No Quotes'),
          ),
        );
      } else if (!_profileStore.hasReachedEnd && _profileStore.quotes.isEmpty) {
        return SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return index + 1 >= _profileStore.quotes.length &&
                  !_profileStore.hasReachedEnd && _profileStore.quotes.length > 5
              ? Column(
                  children: <Widget>[
                    QuoteWidget(_profileStore.quotes[index]),
                    BottomLoader()
                  ],
                )
              : QuoteWidget(_profileStore.quotes[index]);
        }, childCount: _profileStore.quotes.length),
      );
    });
  }
}
