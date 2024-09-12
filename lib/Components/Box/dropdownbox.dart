import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/theme.dart';

class Dropdownbox extends StatefulWidget {
  final double wsize, hsize; 
  final List<String> index_list;
  final ValueChanged<String?> onChanged; 

  Dropdownbox({
    required this.wsize,
    required this.hsize,
    required this.index_list,
    required this.onChanged,
    super.key,
  });

  @override
  State<Dropdownbox> createState() => _DropdownboxState();
}

class _DropdownboxState extends State<Dropdownbox> {
  GlobalKey _key = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  String? dropdownValue;
  bool _isDropdownOpen = false; 

  @override
  void initState() {
    super.initState();
    if (widget.index_list.isNotEmpty) { 
      dropdownValue = widget.index_list.first;
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;

    double containerHeight = widget.index_list.length > 2 ? 153 : 102;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          child: Material(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: containerHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: gray100),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: widget.index_list
                    .map((item) => ListTile(
                          title: Text(item, style: regular14.copyWith(color: gray800)),
                          onTap: () {
                            setState(() {
                              dropdownValue = item;
                              _isDropdownOpen = false;
                            });
                            widget.onChanged(item);
                            _overlayEntry?.remove();
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _overlayEntry?.remove();
      setState(() {
        _isDropdownOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
      setState(() {
        _isDropdownOpen = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        key: _key,
        onTap: _toggleDropdown,
        child: Container(
          width: MediaQuery.of(context).size.width * (widget.wsize / 393),
          height: widget.hsize,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: gray300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  dropdownValue ?? 'Select an item',
                  style: regular14.copyWith(color: gray800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SvgPicture.asset(
                  'assets/img/dropdown.svg',
                  width: 8,
                  height: 9,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
