import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/post_model.dart';
import 'package:learning/modules/edit_profile/edit_profile_screen.dart';
import 'package:learning/modules/login/login.dart';
import 'package:learning/shared/Cubit/social_App/Cubit.dart';
import 'package:learning/shared/Cubit/social_App/states.dart';
import 'package:learning/shared/compnents/component.dart';
import 'package:learning/shared/networking/lacal/cacheHelper.dart';

class ProfileScreen extends StatelessWidget {
  PostModel model;

  ProfileScreen({this.model});

  @override
  Widget build(BuildContext context) {
    var userData = SocialCubit.get(context).userModel;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialErrorState) {
          snackBar(context,
              text: 'Error please reload Page', color: Colors.red);
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: userData != null,
            builder: (context) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 219,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 175,
                                child: Image(
                                  image: NetworkImage('${userData.cover}'),
                                  fit: BoxFit.cover,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                              ),
                              Positioned(
                                bottom: -2,
                                left: 140,
                                child: CircleAvatar(
                                  radius: 52,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage('${userData.image}'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${userData.name}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${userData.bio}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Text(
                                      '100',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Posts',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Text(
                                      '90K',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Follower',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Text(
                                      '165',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Photos',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Text(
                                      '105',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Following',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  CacheHelper.removeData('uId').then((value) {
                                    navigateAnd(context, LogInScreen());
                                  });
                                },
                                child: Text('Add Photos '),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  SocialCubit.get(context)
                                      .emit(NewSocialSuccessState());
                                  navigateTo(context, EditProfileScreen());
                                },
                                child: Icon(Icons.edit_outlined)),
                          ],
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => PastBuilder(context,
                                SocialCubit.get(context).posts[index], index),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: SocialCubit.get(context).posts.length),
                      ],
                    ),
                  ),
                ),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget PastBuilder(context, PostModel model, index) => Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Colors.blue,
                        )
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(
              height: 6,
            ),

            Divider(
              height: 1,
              endIndent: 10,
              indent: 5,
            ),

            SizedBox(
              height: 9,
            ),

            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.bodyText2,
            ),

            SizedBox(
              height: 5,
            ),


            if (model.postPhoto != '')
              Image(
                image: NetworkImage('${model.postPhoto}'),
                fit: BoxFit.cover,
                width: double.infinity,
              ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_outline_rounded,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(
                          height: 3,
                          width: 5,
                        ),
                        Text(
                          '${SocialCubit.get(context).likesNum[index]}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(
                        height: 3,
                        width: 5,
                      ),
                      Text(
                        '0',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 5,
            ),

            Divider(
              height: 1,
            ),

            SizedBox(
              height: 5,
            ),

            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      '${SocialCubit.get(context).userModel.image}'),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'write a comment...',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_outline_rounded,
                        color: Colors.red,
                        size: 20,
                      ),
                      SizedBox(
                        height: 3,
                        width: 5,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: () {
                    SocialCubit.get(context)
                        .postLikes(SocialCubit.get(context).postId[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
