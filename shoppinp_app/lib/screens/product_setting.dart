import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../providers/product.dart';
import '../providers/products_provider.dart';

class ProductSetting extends StatefulWidget {
  static const routeName = '/setting';

  @override
  State<ProductSetting> createState() => _ProductSettingState();
}

class _ProductSettingState extends State<ProductSetting> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrl = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _setProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');
  var _isDone = false;

  Map<String, String> _initMap = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener(_updateImage);
    super.initState();
  }

  void _updateImage() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null) {
        _setProduct = Provider.of<Products>(context, listen: false)
            .findById(productId.toString());
        _initMap = {
          'id': _setProduct.id,
          'title': _setProduct.title,
          'description': _setProduct.description,
          'price': _setProduct.price.toString(),
          'imageUrl': _setProduct.imageUrl,
        };
        _imageUrl.text = _setProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageUrlFocusNode.removeListener(_updateImage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrl.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    _isDone = true;
    if (_setProduct.id.isEmpty) {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_setProduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                    title: Text(
                      'An error occured',
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                    content: Text(error.toString()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Okay'))
                    ])));
      } finally {
        setState(() {
          _isDone = false;
        });
        Navigator.of(context).pop();
      }
    } else {
      Provider.of<Products>(context, listen: false).updateProduct(_setProduct);
      setState(() {
        _isDone = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        actions: [IconButton(onPressed: (_saveForm), icon: Icon(Icons.save))],
      ),
      body: _isDone
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initMap['title'],
                        decoration: InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (newValue) {
                          _initMap['title'] = newValue.toString();
                          _setProduct = Product(
                              isFavorite: _setProduct.isFavorite,
                              id: _setProduct.id,
                              title: newValue.toString(),
                              description: _setProduct.description,
                              price: _setProduct.price,
                              imageUrl: _setProduct.imageUrl);
                        },
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Please provide title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                          initialValue: _initMap['price'],
                          decoration: InputDecoration(labelText: 'Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          focusNode: _priceFocusNode,
                          onSaved: (newValue) {
                            _setProduct = Product(
                                isFavorite: _setProduct.isFavorite,
                                id: _setProduct.id,
                                title: _setProduct.title,
                                description: _setProduct.description,
                                price: double.parse(newValue.toString()),
                                imageUrl: _setProduct.imageUrl);
                          },
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please enter price';
                            }
                            if (double.tryParse(value.toString()) == null) {
                              return 'Please enter valid number';
                            }
                            if (double.parse(value.toString())! <= 0) {
                              return 'Number must be greater then zero';
                            }
                            return null;
                          }),
                      TextFormField(
                          initialValue: _initMap['description'],
                          decoration: InputDecoration(labelText: 'Description'),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocusNode,
                          onSaved: (newValue) {
                            _setProduct = Product(
                              isFavorite: _setProduct.isFavorite,
                              id: _setProduct.id,
                              title: _setProduct.title,
                              description: newValue.toString(),
                              price: _setProduct.price,
                              imageUrl: _setProduct.imageUrl,
                            );
                          },
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please provide image URL';
                            }
                            if (value.toString().length < 10) {
                              return 'Description is too short';
                            }
                            return null;
                          }),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: _imageUrl.text.isEmpty
                                ? Text('No image input')
                                : FittedBox(
                                    child: Image.network(
                                    _imageUrl.text,
                                    fit: BoxFit.cover,
                                  )),
                          ),
                          Expanded(
                            child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Image URL'),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.url,
                                focusNode: _imageUrlFocusNode,
                                controller: _imageUrl,
                                onFieldSubmitted: (_) {
                                  _saveForm();
                                },
                                onSaved: (newValue) {
                                  _setProduct = Product(
                                      isFavorite: _setProduct.isFavorite,
                                      id: _setProduct.id,
                                      title: _setProduct.title,
                                      description: _setProduct.description,
                                      price: _setProduct.price,
                                      imageUrl: newValue.toString());
                                },
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Please provide image URL';
                                  }
                                  if (!value.toString().startsWith('http') &&
                                      !value.toString().startsWith('https')) {
                                    return 'Please enter correct URL';
                                  }
                                  if (!value.toString().endsWith('.jpg') &&
                                      !value.toString().endsWith('.png') &&
                                      !value.toString().endsWith('.jpeg')) {
                                    return 'Please correct image';
                                  }
                                  return null;
                                }),
                          )
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
