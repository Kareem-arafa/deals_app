import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/data/models/message_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/ui/chat/chat_bubble.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DialogScreen extends StatelessWidget {
  final UserModel user;

  const DialogScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _DialogScreenContent(
        viewModel: viewModel,
        user: user,
      ),
    );
  }
}

class _DialogScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final UserModel user;

  const _DialogScreenContent({super.key, required this.user, required this.viewModel});

  @override
  State<_DialogScreenContent> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<_DialogScreenContent> {
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.widget.viewModel.getChatMessage(widget.user.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(widget.user.image ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.user.name ?? "",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff93cb80),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          this.widget.viewModel.getChatMessagesReport.status == ActionStatus.running
              ? Center(
                  child: CupertinoActivityIndicator(
                    animating: true, // Control animation
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : RefreshIndicator.adaptive(
                  onRefresh: _handleRefresh,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: this.widget.viewModel.messages.length,
                    reverse: false,
                    padding: EdgeInsets.all(16) + EdgeInsets.only(bottom: 100),
                    itemBuilder: (_, index) {
                      final MessageModel message = this.widget.viewModel.messages[index];
                      return ChatBubble(
                        isME: message.senderId == widget.viewModel.user!.id!,
                        messageModel: message,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => SizedBox(
                      height: 15,
                    ),
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: new BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xffdcdcdc),
                  ),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0) + EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  child: TextFieldWidget(
                    type: TextFieldType.text,
                    controller: messageController,
                    hint: "Type Message...",
                    borderColor: Color(0xffc9c8d9),
                    suffixIcon: InkWell(
                      onTap: () {
                        if (messageController.text.isNotEmpty) {
                          this.widget.viewModel.sendMessage(widget.user.id!, messageController.text);
                          messageController.clear();
                        }
                      },
                      child: RotatedBox(
                        quarterTurns: -2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Assets.images.backArrow.path,
                                height: 16,
                                matchTextDirection: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    this.widget.viewModel.getChatMessage(widget.user.id!);
  }
}
