import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/presentation/bloc/post/post.bloc.dart';
import 'package:journey_share/presentation/bloc/post/post.events.dart';
import 'package:journey_share/presentation/bloc/post/post.state.dart';
import 'package:journey_share/style/text.styles.dart';

class AddDetailsScreen extends StatelessWidget {
  const AddDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PostBloc>(context);
    final state = bloc.state as CreateState;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        children: [
          Text(
            'Upload',
            style: TextStyles.title,
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 168,
            child: Image.file(state.imageFile!),
          ),
          const SizedBox(height: 32),
          TextFormField(
            autocorrect: false,
            enableSuggestions: false,
            autovalidateMode: AutovalidateMode.always,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.key),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              enabledBorder: OutlineInputBorder(),
              focusedBorder: UnderlineInputBorder(),
              labelText: 'Description',
              hintText: 'It was a fantastic journey..',
            ),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
          ),
          ElevatedButton(
            onPressed: () async {
              bloc.add(OnPublish(
                  fileToPublish: state.imageFile!, description: 'description'));
            },
            child: Row(
              children: const [
                Icon(Icons.publish),
                Text('PUBLISH'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
