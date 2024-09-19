package com.example.todo.service.task;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TaskService {

    public List<TaskEntity> find() {
        var task1 = new TaskEntity(
                1L,
                "Spring Bootを学ぶ",
                "TODO アプリケーションを作ってみる",
                TaskStatus.TODO
        );
        var task2 = new TaskEntity(
                2L,
                "Spring Securityを学ぶ",
                "ログイン機能を作ってみる",
                TaskStatus.DOING
        );

        return List.of(task1, task2);
    }
}
