import 'package:flutter/material.dart';

import './repository/TodoRepository.dart';

enum DetailPageState { create, edit }

class TodoDetailInfo {
  TodoDetailInfo(this.pageState, this.id);

  DetailPageState pageState;
  int id;
}

class DetailPresenter {
  DetailPresenter(TodoDetailInfo info) {
    pageTitle = info.pageState == DetailPageState.create ? '新規作成' : '編集';
    initTitle = info.pageState == DetailPageState.create
        ? ''
        : TodoRepository().getItemById(info.id).title;
    buttonTitle =
        info.pageState == DetailPageState.create ? '追加する' : '変更する';
    editId = info.id;
  }

  String pageTitle;
  String initTitle;
  String buttonTitle;
  int editId;
}

class NewTodoPage extends StatefulWidget {
  const NewTodoPage({Key key, this.title, @required this.pageInfo}) : super(key: key);

  final String title;
  final TodoDetailInfo pageInfo;

  @override
  _NewTodoPageState createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  final TodoRepository _repository = TodoRepository();
  TextEditingController _controller;
  DetailPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = DetailPresenter(widget.pageInfo);
    _controller = TextEditingController(text: _presenter.initTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_presenter.pageTitle),
        ),
        resizeToAvoidBottomPadding: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 160),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(
              'やること：',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'やること',
                  contentPadding: const EdgeInsets.fromLTRB(8, 12, 8, 16)),
              style: TextStyle(fontSize: 20, color: Colors.black87),
              controller: _controller,
            ),
            RaisedButton(
              onPressed: () => _buttonAction(),
              child: Text(_presenter.buttonTitle),
            )
          ]),
        ));
  }

  void _buttonAction() {
    if (_presenter.editId == 0) {
      _addNewTodo();
    } else {
      _editTodo();
    }
  }

  void _addNewTodo() {
    setState(() {
      _repository.addNewItem(_controller.text);
    });
    Navigator.pop(context);
  }

  void _editTodo() {
    setState(() {
      _repository.editItemById(widget.pageInfo.id, _controller.text);
    });
    Navigator.pop(context);
  }
}
