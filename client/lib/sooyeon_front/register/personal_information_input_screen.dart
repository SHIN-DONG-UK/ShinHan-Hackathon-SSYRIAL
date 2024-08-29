import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

class PersonalInformationInputScreen extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController birthdayController;
  final String? selectedGender;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onBirthdayChanged;
  final ValueChanged<String> onGenderSelected;

  const PersonalInformationInputScreen({
    required this.nameController,
    required this.birthdayController,
    this.selectedGender,
    required this.onNameChanged,
    required this.onBirthdayChanged,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kContainerPadding),
      decoration: BoxDecoration(
        color: kContainerBackgroundColor,
        borderRadius: kContainerBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이름 입력 섹션
          Text(
            '이름을 입력해주세요.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          _buildNameInputSection(),
          if (nameController.text.isNotEmpty) ...[
            SizedBox(height: 20),
            Text(
              '6자리 생년월일을 입력해주세요.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildBirthdayInputSection(),
          ],
          if (birthdayController.text.length == 6 && nameController.text.isNotEmpty) ...[
            SizedBox(height: 20),
            Text(
              '성별이 무엇입니까?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildGenderSelectionSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildNameInputSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이름'),
          SizedBox(height: 8),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: '입력해 주세요.',
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: onNameChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildBirthdayInputSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('생년월일'),
          SizedBox(height: 8),
          TextField(
            controller: birthdayController,
            decoration: InputDecoration(
              hintText: 'oooooo',
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            onChanged: onBirthdayChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelectionSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('성별'),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: Text('남자'),
                  onPressed: () => onGenderSelected('남자'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedGender == '남자' ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  child: Text('여자'),
                  onPressed: () => onGenderSelected('여자'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedGender == '여자' ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
