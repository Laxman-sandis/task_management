import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/resources/string_helper.dart';
import '../viewmodels/task_viewmodel.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  final Task? task; // Null if adding a new task

  const AddTaskScreen({super.key, this.task});

  @override
  AddTaskScreenState createState() => AddTaskScreenState();
}

class AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _selectedDate;
  String selectedDate = '';
  TaskPriority _selectedPriority = TaskPriority.medium; // Default priority

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
      _selectedDate = DateFormat("dd/MM/yyyy").parse(widget.task!.dueDate);
      selectedDate = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      _selectedPriority = widget.task!.priority; // Load existing priority
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task == null ? StringHelper.addTaskTitle : StringHelper.editTaskTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Field
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: StringHelper.title,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value!.isEmpty ? StringHelper.titleCannotBeEmpty : null,
                ),
                const SizedBox(height: 12),

                // Description Field
                TextFormField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: StringHelper.description,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 2,
                  validator: (value) =>
                      value!.isEmpty ? StringHelper.descriptionCannotBeEmpty : null,
                ),
                const SizedBox(height: 16),

                // Priority Dropdown
                DropdownButtonFormField<TaskPriority>(
                  value: _selectedPriority,
                  decoration: InputDecoration(
                    labelText: StringHelper.priority,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: TaskPriority.values.map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority.name.toUpperCase()), // Display "LOW", "MEDIUM", "HIGH"
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Date Picker
                GestureDetector(
                  onTap: _pickDueDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate == null
                              ? StringHelper.selectDueDate
                              : selectedDate.toString(),
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        const Icon(Icons.calendar_today, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Save Button (Handles Add & Edit)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(widget.task == null ? Icons.add : Icons.edit),
                    label: Text(
                        widget.task == null ? StringHelper.addTaskTitle : StringHelper.updateTask),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _selectedDate != null) {
                        if (widget.task == null) {
                          // Adding a new task
                          ref.read(taskProvider.notifier).addTask(
                                Task(
                                  title: _titleController.text,
                                  description: _descController.text,
                                  dueDate: selectedDate,
                                  priority: _selectedPriority, // Save priority
                                ),
                              );
                        } else {
                          // Updating an existing task
                          ref.read(taskProvider.notifier).updateTask(
                                Task(
                                  id: widget.task!.id,
                                  title: _titleController.text,
                                  description: _descController.text,
                                  dueDate: selectedDate,
                                  isCompleted: widget.task!.isCompleted,
                                  priority: _selectedPriority, // Update priority
                                ),
                              );
                        }
                        Navigator.pop(context);
                      } else if (_selectedDate == null) {
                        _showSnackbar(StringHelper.pleaseSelectDueDate);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Date Picker Function
  Future<void> _pickDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        selectedDate = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }

  // Show Snackbar
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
