import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hba_management/core/utils/size_config.dart';
import 'package:hba_management/layers/view/widgets/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

class CreateHotelScreen extends StatefulWidget {
  @override
  _CreateHotelScreenState createState() => _CreateHotelScreenState();
}

class _CreateHotelScreenState extends State<CreateHotelScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  double _rating = 0.0;
  List<XFile> _images = [];

  Future<void> _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
            _images = List.from(_images + selectedImages);
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Hotel Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _images.isNotEmpty
                  ? CarouselSlider(
                      imagesUrl: _images.map((e) => e.path).toList(),
                      isNetWork: false,
                      isFile: true,
                      startIndex: _images.length - 1,
                      height: SizeConfig.screenHeight * 0.35,
                      autoScroll: false)
                  : Container(
                      height: SizeConfig.screenHeight * 0.35,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: Center(
                        child: Icon(
                          Icons.image,
                          size: 30,
                        ),
                      ),
                    ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _pickImages,
                child: Text('Pick Images'),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the hotel name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the hotel address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the hotel description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('Rating', style: TextStyle(fontSize: 16)),
              Center(
                child: RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  glow: false,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Process the data
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
