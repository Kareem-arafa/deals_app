import 'package:dealz/data/models/comment_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/products/product_details_widgets/delete_comment_icon.dart';
import 'package:dealz/ui/products/product_details_widgets/report_comment_icon.dart';
import 'package:dealz/ui/products/send_comment_dialog.dart';
import 'package:flutter/material.dart';

class CommentList extends StatelessWidget {
  final MyAdsModel myAdsModel;
  final UserModel? currentUser;
  final bool isSingleComment;

  const CommentList({super.key, required this.myAdsModel, this.currentUser, this.isSingleComment = false});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeTop: true,
      child: ListView.separated(
        itemCount: isSingleComment ? myAdsModel.comments?.take(4).length ?? 0 : myAdsModel.comments?.length ?? 0,
        shrinkWrap: true,
        physics: isSingleComment ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, int index) {
          CommentModel comment = myAdsModel.comments![index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    comment.user?.name ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (currentUser != null)
                    if (comment.user?.id != currentUser?.id)
                      ReportCommentIcon(
                        commentModel: comment,
                      )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: new Text(
                      comment.comment ?? "",
                      style: TextStyle(
                        color: Color(0xff858585),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (currentUser != null)
                    if (comment.user?.id == (currentUser?.id))
                      Row(
                        children: [
                          DeleteCommentIcon(
                            adsModel: myAdsModel,
                            commentModel: comment,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SendCommentDialog(
                                    content: myAdsModel,
                                    comment: comment,
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  Assets.images.editIcon.path,
                                  width: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                ],
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Color(0xff979797),
          height: 20,
        ),
      ),
    );
  }
}
