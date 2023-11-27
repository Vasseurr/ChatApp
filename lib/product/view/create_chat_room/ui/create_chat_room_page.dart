import 'package:chat_app/core/extension/context_extension.dart';
import 'package:chat_app/product/view/create_chat_room/controller/create_chat_room_controller.dart';
import 'package:chat_app/product/view/create_chat_room/mixin/create_chat_room_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:sizer/sizer.dart';
import '../../../../core/extension/string_extension.dart';

import '../../../../core/components/widgets/custom_profile_image.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/padding_values.dart';

class CreateChatRoomPage extends StatefulWidget {
  const CreateChatRoomPage({Key? key}) : super(key: key);

  @override
  State<CreateChatRoomPage> createState() => _CreateChatRoomPageState();
}

class _CreateChatRoomPageState extends State<CreateChatRoomPage>
    with CreateChatRoomMixin {
  final CreateChatRoomController _createChatRoomController =
      Get.find<CreateChatRoomController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Obx(() => _createChatRoomController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(CustomPaddingValues.mediumH),
                      child: Text("Who", style: context.textTheme.bodyLarge),
                    ),
                    _selectedUserList(context),
                    Padding(
                      padding: EdgeInsets.all(CustomPaddingValues.mediumH),
                      child:
                          Text("Suggested", style: context.textTheme.bodyLarge),
                    ),
                    _list(),
                  ],
                ),
                _createChatRoomController.isInnerLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox()
              ],
            )),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Create chat"),
      actions: [
        Obx(
          () => TextButton(
            style: TextButton.styleFrom(
                primary: _createChatRoomController.selectedUserList.isEmpty
                    ? Colors.grey
                    : Colors.grey.shade900),
            onPressed: _createChatRoomController.selectedUserList.isEmpty
                ? null
                : () => _createChatRoomController.createChatRoom(),
            child: const Text(
              "Chat",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
          ),
        )
      ],
    );
  }

  Container _selectedUserList(BuildContext context) {
    return Container(
      width: context.getWidth,
      height: context.getHeight * 0.07,
      margin: EdgeInsets.symmetric(horizontal: CustomPaddingValues.mediumH),
      child: _createChatRoomController.selectedUserList.isNotEmpty
          ? ListView.builder(
              itemCount: _createChatRoomController.selectedUserList.length + 1,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return index ==
                        _createChatRoomController.selectedUserList.length
                    ? _searchTFF(context)
                    : _selectedUserCard(index);
              },
            )
          : _searchTFF(context),
    );
  }

  Padding _selectedUserCard(int index) {
    return Padding(
      padding: EdgeInsets.only(right: CustomPaddingValues.xSmallH),
      child: InkWell(
        onTap: () => _createChatRoomController
            .unSelectUser(_createChatRoomController.selectedUserList[index]),
        child: Wrap(
          children: [
            Container(
              margin: EdgeInsets.all(CustomPaddingValues.smallH),
              padding: EdgeInsets.all(CustomPaddingValues.smallH),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.midRadius),
                  gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: MyColors.primaryColorList)),
              child: Text(
                _createChatRoomController.selectedUserList[index].userName ??
                    "",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _searchTFF(BuildContext context) {
    return SizedBox(
      width: context.getWidth,
      child: TextFormField(
        controller: _createChatRoomController.textEditingController,
        decoration: const InputDecoration(
          hintText: "Search User",
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        onChanged: (value) => filterSearchResults(
            controller: _createChatRoomController, searchingText: value),
      ),
    );
  }

  Expanded _list() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _createChatRoomController.tempUserList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            //* decide which operation will be used select/unselect
            onTap: () => _createChatRoomController
                .operate(_createChatRoomController.tempUserList[index]),
            leading: CustomProfileImage(
                profilePhotoLink:
                    _createChatRoomController.tempUserList[index].photoLink),
            title: Text(
              "${_createChatRoomController.tempUserList[index].firstName?.toCapitalize()} ${_createChatRoomController.tempUserList[index].lastName?.toCapitalize()}",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              _createChatRoomController.tempUserList[index].userName ?? "",
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
            ),
            trailing: Container(
              height: context.getHeight * 0.03.sp,
              width: context.getWidth * 0.1.sp,
              decoration: BoxDecoration(
                /*  gradient: _createChatRoomController.getIsSelected(
                            _createChatRoomController.tempUserList[index]) ==
                        true
                    ? const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: MyColors.primaryColorList)
                    : null,*/
                //  border: Border.all(color: Colors.purple.shade800),
                border: Border.all(color: Colors.grey),
                shape: BoxShape.circle,
              ),
              // child: const SizedBox(),
              child: _createChatRoomController.getIsSelected(
                          _createChatRoomController.tempUserList[index]) ==
                      true
                  ? Icon(Icons.check, color: Colors.purple.shade800)
                  : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
