package com.example.todo.controller.task;

import com.example.todo.service.task.TaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/tasks")
public class TaskController {

    private final TaskService taskService;

    @GetMapping
    public String list(Model model) {
        var taskList = taskService.find() // List<TaskEntity> -> List<TaskDTO>
                .stream()
                        .map(TaskDTO::toDTO)
                        .toList();
        model.addAttribute("taskList", taskList);
        return "tasks/list";
    }

    @GetMapping("{id}")    // GET /tasks/detail
    public String showDetail(@PathVariable("id") long taskId, Model model) {
        model.addAttribute("taskId", taskId);
        var taskEntity = taskService.findById(taskId)
                .orElseThrow(() -> new IllegalArgumentException("Task not found: id = " + taskId));
        model.addAttribute("task", TaskDTO.toDTO(taskEntity));
        return "tasks/detail";
    }

    // GET /tasks/creationForm
    @GetMapping("creationForm")
    public String showCreationForm() {
        return "tasks/form";
    }

    // POST /tasks
    @PostMapping
    public String create(TaskForm form) {
        taskService.create(form.toEntity());
        return "redirect:/tasks";
    }
}
