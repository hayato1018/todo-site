package com.example.todo.controller.task;

public record TaskDTO(
        long id,
        String summary,
        String description,
        String status
) {
}
