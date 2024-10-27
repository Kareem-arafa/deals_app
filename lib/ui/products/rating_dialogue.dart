import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';

class RatingDialog extends StatelessWidget {
  final int contentId;

  const RatingDialog({super.key, required this.contentId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _RatingDialogContent(
        viewModel: viewModel,
        contentId: contentId,
      ),
    );
  }
}

class _RatingDialogContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final int contentId;

  const _RatingDialogContent({super.key, required this.viewModel, required this.contentId});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<_RatingDialogContent> {
  double _rating = 0.0;

  ProgressDialog? progressDialog;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate This Ads'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('How would you rate this ads?'),
          SizedBox(height: 20),
          RatingBar.builder(
            initialRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 20,
            unratedColor: Color(0xff1c274c),
            itemPadding: EdgeInsets.symmetric(horizontal: 4),
            onRatingUpdate: (rating) {
              _rating = rating;
              setState(() {});
            },
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                Assets.images.star.path,
                color: Colors.amber,
              );
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            if (_rating > 0.0) {
              this.widget.viewModel.createRating(widget.contentId, _rating);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
