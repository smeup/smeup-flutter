import 'package:flutter/material.dart';
import 'package:smeup_flutter/main.dart';
import 'models/product.dart';
import 'package:smeup_flutter/services/firebaseHttpService.dart';

class FirebaseEditPage extends StatefulWidget {

  final Product _initValues; 
  final bool isFireStore;
  FirebaseEditPage(this._initValues, this.isFireStore);

  @override
  _FirebaseEditPageState createState() => _FirebaseEditPageState();
}

class _FirebaseEditPageState extends State<FirebaseEditPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: ''
  );

  @override
  void initState() {
    _editedProduct = Product(id: widget._initValues.id, title: widget._initValues.title, description: widget._initValues.description, price: widget._initValues.price);

    super.initState();
  }
  
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    
    _form.currentState.save();

    if(widget.isFireStore) {
      if (_editedProduct.id != null) {
        HttpProductsResponseSync response = await MyApp.firebaseHttpService.patchProductsSync(_editedProduct);
        if(!response.isError)
          Navigator.of(context).pop();
      } else {
        HttpProductsResponseSync response = await MyApp.firebaseHttpService.postProductsSync(_editedProduct);
        if(!response.isError)
          Navigator.of(context).pop();
      }
    } else {
      if (_editedProduct.id != null) {
        HttpProductsResponse response = await MyApp.firebaseHttpService.patchProducts(_editedProduct);
        if(!response.isError)
          Navigator.of(context).pop();
      } else {
        HttpProductsResponse response = await MyApp.firebaseHttpService.postProducts(_editedProduct);
        if(!response.isError)
          Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: widget._initValues.title,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      title: value,
                      price: _editedProduct.price,
                      description: _editedProduct.description,
                      id: _editedProduct.id,
                      isFavorite: _editedProduct.isFavorite);
                },
              ),
              TextFormField(
                initialValue: widget._initValues.price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      title: _editedProduct.title,
                      price: double.parse(value),
                      description: _editedProduct.description,
                      id: _editedProduct.id,
                      isFavorite: _editedProduct.isFavorite);
                },
              ),
              TextFormField(
                initialValue: widget._initValues.description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a description.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    title: _editedProduct.title,
                    price: _editedProduct.price,
                    description: value,
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
