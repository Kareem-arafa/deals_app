import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/chat/dialog_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _ChatScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _ChatScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _ChatScreenContent({super.key, required this.viewModel});

  @override
  State<_ChatScreenContent> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<_ChatScreenContent> {
  @override
  void initState() {
    super.initState();
    this.widget.viewModel.getChats();
  }

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _ChatScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.deleteChatReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.deleteChatReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.deleteChatReport.msg}");
        this.widget.viewModel.deleteChatReport.status = null;
      } else if (this.widget.viewModel.deleteChatReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("Chat deleted successfully");
        this.widget.viewModel.deleteChatReport.status = null;
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.deleteChatReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              Assets.images.backArrow.path,
              height: 18,
              matchTextDirection: true,
            ),
          ),
          centerTitle: false,
          title: Text(
            Translations.of(context).text("chatsLabel"),
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: this.widget.viewModel.getChatsReport.status == ActionStatus.running
            ? Center(
                child: CupertinoActivityIndicator(
                  animating: true, // Control animation
                  color: Theme.of(context).primaryColor,
                ),
              )
            : this.widget.viewModel.chats.isEmpty
                ? Center(
                    child: Text("No Messages Requested"),
                  )
                : MediaQuery.removePadding(
                    context: context,
                    removeBottom: true,
                    removeTop: true,
                    child: ListView.separated(
                      itemCount: this.widget.viewModel.chats.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16) + EdgeInsets.only(bottom: 10),
                      itemBuilder: (_, int index) {
                        UserModel user = this.widget.viewModel.chats[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DialogScreen(
                                  user: user,
                                ),
                              ),
                            );
                          },
                          child: ChatItem(
                            isSelected: index == 2,
                            user: user,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => SizedBox(
                        height: 15,
                      ),
                    ),
                  ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final bool? isSelected;
  final UserModel user;

  const ChatItem({super.key, this.isSelected, required this.user});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _ChatItemContent(
        viewModel: viewModel,
        user: user,
        isSelected: isSelected,
      ),
    );
  }
}

class _ChatItemContent extends StatefulWidget {
  final bool? isSelected;
  final UserModel user;
  final HomeViewModel viewModel;

  const _ChatItemContent({
    super.key,
    this.isSelected,
    required this.user,
    required this.viewModel,
  });

  @override
  State<_ChatItemContent> createState() => _ChatItemState();
}

class _ChatItemState extends State<_ChatItemContent> {

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              this.widget.viewModel.deleteChat(widget.user.id!);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xffd8d8d8),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.user.image ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.user.name ?? "",
                          style: TextStyle(
                            color: Color(0xff676578),
                            fontSize: 18,
                            letterSpacing: -0.09390937685966493,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Icon(
                            Directionality.of(context) == TextDirection.ltr
                                ? Icons.keyboard_arrow_right_outlined
                                : Icons.keyboard_arrow_left_outlined,
                            textDirection: Directionality.of(context),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.user.phone ?? "",
                          style: TextStyle(
                            color: Color(0xff908f9d),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
